//
//  UIViewController+Ext.swift
//  GHFollowers
//
//  Created by Shuai Zhang on 10/12/23.
//  Copyright © 2023 Sean Allen. All rights reserved.
//

import UIKit
import SafariServices

extension UIViewController {
	@objc
	func presentDefaultError() {
		let alertVC = GFAlertVC(title: "Something Went Wrong",
								message: "We were unable to complete your task at this time. Please try again.",
								buttonTitle: "Ok")
		alertVC.modalPresentationStyle  = .overFullScreen
		alertVC.modalTransitionStyle    = .crossDissolve
		present(alertVC, animated: true)
	}

	func showAlert(title: String, message: String, buttonTitle: String) {
		DispatchQueue.main.async {
			let alertVC = GFAlertVC(title: title, message: message, buttonTitle: buttonTitle)
			alertVC.delegate = self as? GFAlertVCDelegate
			alertVC.modalPresentationStyle  = .overFullScreen
			alertVC.modalTransitionStyle    = .crossDissolve
			self.present(alertVC, animated: true)
		}
	}

	func presentSafariVC(with url: URL) {
		let safariVC = SFSafariViewController(url: url)
		safariVC.preferredControlTintColor = .systemGreen
		present(safariVC, animated: true)
	}
	
}
