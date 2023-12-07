//
//  UserInfoViewController.swift
//  GHFollowers
//
//  Created by Shuai Zhang on 10/17/23.
//  Copyright © 2023 Simon Zhang. All rights reserved.
//

import UIKit

protocol UserInfoViewControllerDelegate : AnyObject {
	func didRequestFollowers(for userName: String)
}

class UserInfoViewController: UIViewController {


	let headerView          = UIView()
	let itemViewOne         = UIView()
	let itemViewTwo         = UIView()
	let dateLabel = GFBodyLabel()
	var itemViews: [UIView] = []
	var username: String!
	var user: User!
	var scrollView = UIScrollView()
	var containerView = UIView()

	weak var delegate: UserInfoViewControllerDelegate?
	var isPresentedAsBottomSheet: Bool = false

	override func viewDidLoad() {
		super.viewDidLoad()
		configureViewController()
		layoutUI()
		getUserInfo()
	}

	init(userName: String) {
		self.username = userName
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func configureViewController() {
		view.backgroundColor = .systemBackground
		navigationController?.navigationBar.prefersLargeTitles = false
		if isPresentedAsBottomSheet {
			let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismssVC))
			navigationItem.rightBarButtonItem = doneButton
		}
	}

	func getUserInfo() {
		NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
			guard let self = self else { return }

			switch result {
			case .success(let user):
				DispatchQueue.main.async { self.configureUIElements(with: user) }

			case .failure(let error):
				self.showAlert(title: error.title, message: error.rawValue, buttonTitle: "Ok")
			}
		}
	}

	func configureUIElements(with user: User) {
		self.user = user
		let repoItemVC          = GFRepoItemVC(user: user)
		repoItemVC.delegate     = self

		let followerItemVC      = GFFollowerItemVC(user: user)
		followerItemVC.delegate = self

		self.add(childVC: followerItemVC, to: self.itemViewOne)
		self.add(childVC: repoItemVC, to: self.itemViewTwo)
		self.add(childVC: GFUserInfoHeaderVC(user: user), to: self.headerView)
		self.dateLabel.text = "GitHub since \(user.createdAt.convertToDisplayFormat())"
	}

	func layoutUI() {
		let padding: CGFloat    = 20
		let itemHeight: CGFloat = 140
		scrollView.translatesAutoresizingMaskIntoConstraints = false
		containerView.translatesAutoresizingMaskIntoConstraints = false
		scrollView.backgroundColor = .red
		containerView.backgroundColor = .blue
		
		view.addSubview(scrollView)
		scrollView.addSubview(containerView)


		NSLayoutConstraint.activate([
			scrollView.topAnchor.constraint(equalTo: view.topAnchor),
			scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
			scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

			containerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
			containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
			containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
			containerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor)

		])


		itemViews = [headerView, itemViewOne, itemViewTwo, dateLabel]

		for itemView in itemViews {
			containerView.addSubview(itemView)
			itemView.translatesAutoresizingMaskIntoConstraints = false

			NSLayoutConstraint.activate([
				itemView.widthAnchor.constraint(equalTo: containerView.widthAnchor, constant: -2 * padding),
				itemView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
			])
		}

		NSLayoutConstraint.activate([
			headerView.topAnchor.constraint(equalTo: containerView.topAnchor),
			headerView.heightAnchor.constraint(equalToConstant: 180),

			itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
			itemViewOne.heightAnchor.constraint(equalToConstant: itemHeight),

			itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: padding),
			itemViewTwo.heightAnchor.constraint(equalToConstant: itemHeight),

			dateLabel.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor, constant: padding),
			dateLabel.heightAnchor.constraint(equalToConstant: 18),
			// dateLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
		])
	}


	func add(childVC: UIViewController, to containerView: UIView) {
		addChild(childVC)
		containerView.addSubview(childVC.view)
		childVC.view.frame = containerView.bounds
		childVC.didMove(toParent: self)
	}

	@objc func dismssVC() {
		dismiss(animated: true)
	}
}

extension UserInfoViewController: GFItemInfoVCDelegate {

	func didTapGitHubProfile(for user: User) {
		guard let url = URL(string: user.htmlUrl) else {
			showAlert(title: "Invalid URL", message: "The url attached to this user is invalid.", buttonTitle: "Ok")
			return
		}
		presentSafariVC(with: url)
	}

	func didTapGetFollowers(for user: User) {
		guard user.followers != 0 else {
			showAlert(title: "No followers", message: "This user has no followers. What a shame 😞.", buttonTitle: "So sad")
			return
		}
		delegate?.didRequestFollowers(for: user.login)
		dismssVC()
	}

	func didTapItemInfoButton(viewController: GFItemInfoVC) {
		if viewController is GFFollowerItemVC {
			didTapGetFollowers(for: user)
		} else if viewController is GFRepoItemVC {
			didTapGitHubProfile(for: user)
		}
	}
}
