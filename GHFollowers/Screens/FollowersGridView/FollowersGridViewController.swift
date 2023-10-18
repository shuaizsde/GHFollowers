//
//  FollowerListVC.swift
//  GHFollowers
//
//  Created by Shuai Zhang on 10/12/23.
//  Copyright © 2023 Sean Allen. All rights reserved.
//

import UIKit

protocol FollowerListVCDelegate: AnyObject {
	func didRequestFollowers(for username: String)
}

class FollowersGridViewController: UIViewController {
	var userName: String
	private var collectionView: UICollectionView!

	private var page = 1
	private var hasMoreFollowers = true
	private var isSearching = false

	private enum Section { case main }
	private var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!


	private var filteredFollowers: [Follower] = []
	private var followers: [Follower] = [] {
		didSet {
			print("Followers array was set. New count: \(followers.count)")
		}
	}

	init(userName: String) {
		self.userName = userName
		super.init(nibName: nil, bundle:nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}


    override func viewDidLoad() {
        super.viewDidLoad()
		title = userName
		view.backgroundColor = .systemBackground
		navigationController?.navigationBar.prefersLargeTitles = true

		configureCollectionView()
		configureSearchController()
		getFollowers(userName: userName, page: 1)
		configureDataSource()
    }

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.setNavigationBarHidden(false, animated: true)
	}

	// MARK: Configure collection view
	private func configureCollectionView() {
		collectionView = UICollectionView(
			frame: view.bounds,
			collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view)
		)
		view.addSubview(collectionView)
		collectionView.delegate = self
		collectionView.backgroundColor = .systemBackground
		collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
	}

	func configureDataSource() {
		dataSource = UICollectionViewDiffableDataSource<Section,Follower>(collectionView: collectionView) { (collectionView, indexPath, follower) -> UICollectionViewCell? in
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as! FollowerCell
			cell.set(follower: follower)
			return cell
		}
	}

	func configureSearchController() {
		let searchController = UISearchController()
		searchController.searchResultsUpdater = self
		searchController.searchBar.delegate = self
		searchController.searchBar.placeholder = "Search for a user name"
		navigationItem.searchController = searchController

	}
	
	private func getFollowers(userName: String, page: Int) {
		self.showLoadingView()
		NetworkManager.shared.getFollowers(for: userName, page: page) { [weak self] result in
			guard let self = self else { return }
			self.dismissLoadingView()
			switch result {
			case .failure(let error):
				self.presentGFAlertOnMainThread(title: error.title, message: error.rawValue, buttonTitle: "OK")
			case .success(let followers):
				if followers.count < 100 { self.hasMoreFollowers = false }
				self.followers.append(contentsOf: followers)

				if self.followers.isEmpty {
					DispatchQueue.main.async {
						self.showEmptyStateView(with: "\(userName) doesn't have any followers. Go follow them😅", in: self.view)
					}
					return
				}
				
				self.updateData(on: followers)
			}
		}
	}

	private func updateData(on followers: [Follower]) {
		var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
		snapshot.appendSections([.main])
		snapshot.appendItems(followers)
		DispatchQueue.main.async {
			self.dataSource.apply(snapshot, animatingDifferences: true)
		}
	}
}

extension FollowersGridViewController: UISearchResultsUpdating, UISearchBarDelegate {
	func updateSearchResults(for searchController: UISearchController) {
		isSearching = true
		guard let searchKey = searchController.searchBar.text, !searchKey.isEmpty else { return }
		filteredFollowers = followers.filter({$0.login.lowercased().contains(searchKey.lowercased())})
		updateData(on: filteredFollowers)
	}
	
	func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
		isSearching = false
		updateData(on: followers)
	}

}

extension FollowersGridViewController: UICollectionViewDelegate {

	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let follower = isSearching ? filteredFollowers[indexPath.item] : followers[indexPath.item]
		let rootViewController = UserInfoViewController(userName: follower.login)
		rootViewController.followerGridViewDelegate = self
		let destinationVC = UINavigationController(rootViewController: rootViewController)

		// Navigated next view
		// let destinationVC = UserInfoViewController()
		// navigationController?.pushViewController(destinationVC, animated: true)
		// BottomSheet
		present(destinationVC, animated: true)


	}

	func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
		let offsetY = scrollView.contentOffset.y
		let contentHeight = scrollView.contentSize.height
		let height = scrollView.frame.size.height

		if offsetY > contentHeight - height && hasMoreFollowers {
			page += 1
			getFollowers(userName: userName, page: page)
		}
	}
}

// AlertView delegate
extension FollowersGridViewController: GFAlertVCDelegate {
	 func didTapAlertButton() {
		 DispatchQueue.main.async {
			 self.navigationController?.popViewController(animated: true)
		 }
	}
}

extension FollowersGridViewController: UserInfoViewControllerDelegate {

	func didRequestFollowers(for userName: String) {
		self.userName   = userName
		title           = userName
		page            = 1
		followers.removeAll()
		filteredFollowers.removeAll()
		collectionView.setContentOffset(.zero, animated: true)
		getFollowers(userName: userName, page: page)
	}
}
