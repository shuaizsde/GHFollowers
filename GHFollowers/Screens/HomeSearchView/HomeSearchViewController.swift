//
//  HomeSearchViewController.swift
//  GHFollowers
//
//  Created by Shuai Zhang on 10/12/23.
//  Copyright © 2023 Sean Allen. All rights reserved.
//

import UIKit

class HomeSearchViewController: UIViewController {


	let logoImageView = UIImageView()
	let userNameTextField = GFTextField()
	let actionButton = GFButton(backgroundColor: .systemGreen, title: "Search")

	var isUserNameEntered: Bool { !userNameTextField.text!.isEmpty }

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .systemBackground
		configureUI()
		createDismissKeyboardTapGesture()
		configureActions()
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		userNameTextField.text = ""
		navigationController?.setNavigationBarHidden(true, animated: true)
	}

	// MARK: Actions

	func createDismissKeyboardTapGesture() {
		let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
		view.addGestureRecognizer(tap)
	}

	func configureActions() {
		userNameTextField.delegate = self
		actionButton.addTarget(self, action: #selector(pushFollowerListVC), for: .touchUpInside)
	}

	@objc func pushFollowerListVC() {
		guard isUserNameEntered else {
			presentGFAlertOnMainThread(title: "Empty user name", message: "Please enter a username. We need to know who to look for 😀.", buttonTitle: "OK")
			return
		}

		userNameTextField.resignFirstResponder()

		let followerListVC = FollowersGridViewController(userName: userNameTextField.text!)
		navigationController?.pushViewController(followerListVC, animated: true)
	}
}

// MARK: Configure UI
extension HomeSearchViewController {

	func configureUI() {
		confitureLogoImageView()
		confitureTextField()
		confitureSearchButton()
	}

	func confitureLogoImageView() {
		view.addSubview(logoImageView)
		logoImageView.translatesAutoresizingMaskIntoConstraints = false

		logoImageView.image = Images.ghLogo

		NSLayoutConstraint.activate([
			logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
			logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			logoImageView.heightAnchor.constraint(equalToConstant:200),
			logoImageView.widthAnchor.constraint(equalToConstant:200)
		])
	}

	func confitureTextField() {
		view.addSubview(userNameTextField)
		userNameTextField.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			userNameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
			userNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
			userNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
			userNameTextField.heightAnchor.constraint(equalToConstant: 50)
		])
	}

	func confitureSearchButton() {
		view.addSubview(actionButton)
		actionButton.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			actionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
			actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
			actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
			actionButton.heightAnchor.constraint(equalToConstant: 50)
		])
	}
}

extension HomeSearchViewController: UITextFieldDelegate {
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		pushFollowerListVC()
		return true
	}
}
