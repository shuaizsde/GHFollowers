//
//  SearchVC.swift
//  GHFollowers
//
//  Created by Shuai Zhang on 10/12/23.
//  Copyright © 2023 Sean Allen. All rights reserved.
//

import UIKit

class SearchVC: UIViewController {

	var isUserNameEntered: Bool { !userNameTextField.text!.isEmpty }

	let logoImageView = UIImageView()
	let userNameTextField = GFTextField()
	let actionButton = GFButton(backgroundColor: .systemGreen, title: "Search")

	override func viewDidLoad() {
        super.viewDidLoad()
		view.backgroundColor = .systemBackground
		confitureLogoImageView()
		confitureTextField()
		confitureActionButton()
		createDismissKeyboardTapGesture()
    }

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.isNavigationBarHidden = true
	}

	// MARK: Configure Views
	func confitureLogoImageView() {
		view.addSubview(logoImageView)
		logoImageView.translatesAutoresizingMaskIntoConstraints = false
		logoImageView.image = UIImage(named: "gh-logo")!

		NSLayoutConstraint.activate([
			logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
			logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			logoImageView.heightAnchor.constraint(equalToConstant:200),
			logoImageView.widthAnchor.constraint(equalToConstant:200)
		])
	}

	func confitureTextField() {
		view.addSubview(userNameTextField)
		userNameTextField.delegate = self
		userNameTextField.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			userNameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
			userNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
			userNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
			userNameTextField.heightAnchor.constraint(equalToConstant: 50)
		])
	}

	func confitureActionButton() {
		view.addSubview(actionButton)
		actionButton.translatesAutoresizingMaskIntoConstraints = false
		actionButton.addTarget(self, action: #selector(pushFollowerListVC), for: .touchUpInside)
		NSLayoutConstraint.activate([
			actionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
			actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
			actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
			actionButton.heightAnchor.constraint(equalToConstant: 50)
		])
	}

	@objc func pushFollowerListVC() {
		guard isUserNameEntered else {
			presentGFAlertOnMainThread(
				title: "Empty user name",
				message: "Please enter a username, We need to know who are you looking for",
				buttonTitle: "OK"
			)
			return
		}

		let followerListVC = FollowerListVC()
		followerListVC.userName = userNameTextField.text
		followerListVC.title = userNameTextField.text

		navigationController?.pushViewController(followerListVC, animated: true)
	}

	// MARK: Dismiss Keyboard
	func createDismissKeyboardTapGesture() {
		let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
		view.addGestureRecognizer(tap)
	}
	
}

extension SearchVC: UITextFieldDelegate {
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		pushFollowerListVC()
		return true
	}
}
