//
//  FollowerListVC.swift
//  GHFollowers
//
//  Created by Shuai Zhang on 10/12/23.
//  Copyright © 2023 Sean Allen. All rights reserved.
//

import UIKit

class FollowersGridViewController: GFDataLoadingVC {
	enum Section { case main }

	var userName: String!

	var page                            = 1
	var hasMoreFollowers                = true
	var isSearching                     = false{
		didSet {
			print("isSearching: \(isSearching)")
		}
	}
	var isLoadingMoreFollowers          = false

	var collectionView: UICollectionView!
	var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!

	var filteredFollowers: [Follower]   = []
	private var followers: [Follower]   = []

	init(userName: String) {
		super.init(nibName: nil, bundle: nil)
		self.userName   = userName
		title           = userName
	}

	deinit {
		print("Followers controller is deinited")
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

    override func viewDidLoad() {
        super.viewDidLoad()
		configureViewController()
		configureCollectionView()
		configureSearchController()
		getFollowers(userName: userName, page: page)
		configureDataSource()
    }

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.setNavigationBarHidden(false, animated: true)
	}

	// MARK: Configure collection view

	func configureViewController() {
		view.backgroundColor = .systemBackground
		navigationController?.navigationBar.prefersLargeTitles = true

		let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
		navigationItem.rightBarButtonItem = addButton
	}

	private func configureCollectionView() {
		let layout = UIHelper.createThreeColumnFlowLayout(in: view)

		collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)

		layout.footerReferenceSize = CGSize(width: collectionView.bounds.width, height: 50) // Set footer size after initializing collectionView

		collectionView.register(FooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "FooterView")

		view.addSubview(collectionView)
		collectionView.delegate = self
		collectionView.dataSource = dataSource  // Assuming you'll also implement the data source methods
		collectionView.backgroundColor = .systemBackground
		collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
	}

	func configureDataSource() {
		dataSource = UICollectionViewDiffableDataSource<Section,Follower>(collectionView: collectionView) { (collectionView, indexPath, follower) -> UICollectionViewCell? in
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as! FollowerCell
			cell.set(follower: follower)
			return cell
		}


		dataSource.supplementaryViewProvider = { [weak self] collectionView, kind, indexPath in
			guard let self = self else { return nil }
			if kind == UICollectionView.elementKindSectionFooter {
				let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "FooterView", for: indexPath) as! FooterView
				if !self.hasMoreFollowers {
					footerView.label.text = "No more users"
				}
				return footerView
			}
			return nil
		}
	}

	func configureSearchController() {
		let searchController = UISearchController()
		searchController.searchResultsUpdater = self
		searchController.searchBar.delegate = self
		searchController.searchBar.placeholder = "Search for a user name"
		navigationItem.searchController = searchController

	}

	// MARK: Add To Favoriate
	@objc func addButtonTapped() {
		showLoadingView()
		NetworkManager.shared.getUserInfo(for: userName) { [weak self] result in
			guard let self else {return}
			switch result {
			case .success(let user):
				self.addUserToFavorites(user: user)
				self.dismissLoadingView()
			case .failure(let error):
				showAlert(title: error.title, message: error.rawValue, buttonTitle: "Ok")
			}
		}
	}
	func addUserToFavorites(user: User) {
		let favorite = Follower(login: user.login, avatarUrl: user.avatarUrl)

		PersistenceManager.updateWith(favorite: favorite, actionType: .add) { [weak self] error in
			guard let self = self else { return }

			guard let error = error else {
				DispatchQueue.main.async {
					self.showAlert(title: "Success!", message: "You have successfully favorited this user 🎉", buttonTitle: "Hooray!")
				}

				return
			}

			DispatchQueue.main.async {
				self.showAlert(title: error.title, message: error.rawValue, buttonTitle: "Ok")
			}
		}
	}
}

//MARK: Search
extension FollowersGridViewController: UISearchResultsUpdating, UISearchBarDelegate {

	private func getFollowers(userName: String, page: Int) {
		self.showLoadingView()
		isLoadingMoreFollowers = true

		NetworkManager.shared.getFollowers(for: userName, page: page) { [weak self] result in
			guard let self = self else { return }

			switch result {
			case .failure(let error):
				self.showAlert(title: error.title, message: error.rawValue, buttonTitle: "OK")
				self.dismissLoadingView()
			case .success(let followers):
				if followers.count < 100 { self.hasMoreFollowers = false }
				self.followers.append(contentsOf: followers)
				self.dismissLoadingView()
				self.isLoadingMoreFollowers = false
				if self.followers.isEmpty {
					DispatchQueue.main.async {
						self.showEmptyStateView(with: "\(userName) doesn't have any followers. Go follow them😅", in: self.view)
					}
					return
				}

				self.updateData(on: self.followers)
			}
		}
	}

	func updateData(on followers: [Follower]) {
		var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
		snapshot.appendSections([.main])
		snapshot.appendItems(followers)

		DispatchQueue.main.async {
			self.dataSource.apply(snapshot, animatingDifferences: true)
		}
	}

	func updateSearchResults(for searchController: UISearchController) {
		guard let searchKey = searchController.searchBar.text, !searchKey.isEmpty else { return }
		self.isSearching = true
		filteredFollowers = followers.filter({$0.login.lowercased().contains(searchKey.lowercased())})
		updateData(on: filteredFollowers)
	}
	
	func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
		self.isSearching = false
		updateData(on: followers)
	}

}

extension FollowersGridViewController: UICollectionViewDelegate {

	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let follower = isSearching ? filteredFollowers[indexPath.item] : followers[indexPath.item]
		let userInfoViewVC = UserInfoViewController(userName: follower.login)
		userInfoViewVC.isPresentedAsBottomSheet = true
		userInfoViewVC.delegate = self
		let destinationVC = UINavigationController(rootViewController: userInfoViewVC)
		present(destinationVC, animated: true)
	}

	func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
		let offsetY = scrollView.contentOffset.y
		let contentHeight = scrollView.contentSize.height
		let height = scrollView.frame.size.height

		if offsetY > contentHeight - height {
			guard hasMoreFollowers, !isLoadingMoreFollowers else { return }
			page += 1
			getFollowers(userName: userName, page: page)
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

































//// MARK: when alert message button tapped, back to previous vc
//extension FollowersGridViewController: GFAlertVCDelegate {
//	 func didTapAlertButton() {
//		 DispatchQueue.main.async {
//			 self.navigationController?.popViewController(animated: true)
//		 }
//	}
//}


