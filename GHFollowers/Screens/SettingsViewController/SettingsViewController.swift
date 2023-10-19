//
//  SettingsViewController.swift
//  GHFollowers
//
//  Created by Shuai Zhang on 10/19/23.
//  Copyright © 2023 Simon Zhang. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

	let tokenInputTextField = GFTextField()
	let actionButton = GFButton(backgroundColor: .systemGreen, title: "Save")
	var isUserNameEntered: Bool { !tokenInputTextField.text!.isEmpty }

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .systemBackground
		
		configureUI()
		createDismissKeyboardTapGesture()
		configureActions()
	}

	func configureUI() {
		let padding: CGFloat = 20
		view.addSubview(tokenInputTextField)
		tokenInputTextField.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			// tokenInputTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			tokenInputTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
			tokenInputTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
			tokenInputTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
			tokenInputTextField.heightAnchor.constraint(equalToConstant: 50)
		])

		view.addSubview(actionButton)
		actionButton.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			actionButton.topAnchor.constraint(equalTo: tokenInputTextField.bottomAnchor, constant: 50),
			actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
			actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
			actionButton.heightAnchor.constraint(equalToConstant: 50)
		])

	}

	func configureActions() {
		tokenInputTextField.delegate = self
		actionButton.addTarget(self, action: #selector(saveToken), for: .touchUpInside)
	}

	@objc func saveToken() {
		if AuthenticationManager.shared.saveToken(tokenInputTextField.text!) {
			print("token saved as: \(AuthenticationManager.shared.loadToken() ?? "")")
		}else {
			print("failed to save token")
		}
	}

	func createDismissKeyboardTapGesture() {
		let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
		view.addGestureRecognizer(tap)
	}


	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		tokenInputTextField.text = ""
		navigationController?.setNavigationBarHidden(true, animated: true)
	}
}

extension SettingsViewController: UITextFieldDelegate {
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		// Do something, like showing alert
		return true
	}
}
