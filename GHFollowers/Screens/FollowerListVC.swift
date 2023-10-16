//
//  FollowerListVC.swift
//  GHFollowers
//
//  Created by Shuai Zhang on 10/12/23.
//  Copyright © 2023 Sean Allen. All rights reserved.
//

import UIKit

class FollowerListVC: UIViewController {

	enum Section {
		case main
	}

	var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
	var userName: String!
	var collectionView: UICollectionView!
	var followers: [Follower] = []

    override func viewDidLoad() {
        super.viewDidLoad()
		configureViewController()
		configureCollectionView()
		getFollowers()
		configureDataSource()
    }

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.setNavigationBarHidden(false, animated: true)
	}

	// MARK: Configure collection view

	private func configureViewController() {
		view.backgroundColor = .systemBackground
		navigationController?.navigationBar.prefersLargeTitles = true
	}

	private func configureCollectionView() {
		collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createThreeColumnFlowLayout())
		view.addSubview(collectionView)
		collectionView.backgroundColor = .systemBlue
		collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
	}

	private func getFollowers() {
		NetworkManager.shared.getFollowers(for: userName, page: 1) { result in
			switch result {
				case .failure(let error):
					self.presentGFAlertOnMainThread(title: error.title, message: error.message, buttonTitle: "OK")
				case .success(let followers):
					self.followers = followers
					self.updateData()
			}
		}
	}

	func configureDataSource() {
		dataSource = UICollectionViewDiffableDataSource<Section,Follower>(collectionView: collectionView) { (collectionView, indexPath, follower) -> UICollectionViewCell? in
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as! FollowerCell
			cell.set(follower: follower)
			return cell
		}
	}

	func updateData() {
		var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
		snapshot.appendSections([.main])
		snapshot.appendItems(followers)
		DispatchQueue.main.async {
			self.dataSource.apply(snapshot, animatingDifferences: true)
		}
	}
}

extension FollowerListVC {

	private func createThreeColumnFlowLayout() -> UICollectionViewFlowLayout {
		let width = view.bounds.width
		let padding: CGFloat = 12
		let minimumItemSpacing: CGFloat = 10
		let availableWidth = width - padding * 2 - minimumItemSpacing * 2
		let itemWidth = availableWidth / 3

		let flowLayout = UICollectionViewFlowLayout()
		flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
		flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 40)

		return flowLayout
	}

}
