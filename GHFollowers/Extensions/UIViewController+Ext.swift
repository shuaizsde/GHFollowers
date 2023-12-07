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

//	struct SubviewPadding {
//		var top: CGFloat = 0
//		var bottom: CGFloat = 0
//		var leading: CGFloat = 0
//		var trailing: CGFloat = 0
//	}
//	enum AppendingDirection {
//		case top
//		case bottom
//		case leading
//		case trailing
//	}
//
//
//	func appendView(with view1: UIView, after anotherView: UIView, direction: AppendingDirection, spacing: CGFloat) {
//
//	}
//
//	func addSubview(with view1: UIView, to parentView: UIView, paddings: SubviewPadding = SubviewPadding()) {
//		parentView.addSubview(view1)
//		view1.translatesAutoresizingMaskIntoConstraints = false
//		NSLayoutConstraint.activate([
//			view1.topAnchor.constraint(equalTo: parentView.topAnchor, constant: paddings.top),
//			view1.bottomAnchor.constraint(equalTo: parentView.bottomAnchor, constant: paddings.bottom),
//			view1.leadingAnchor.constraint(equalTo: parentView.leadingAnchor, constant: paddings.leading),
//			view1.trailingAnchor.constraint(equalTo: parentView.trailingAnchor, constant: paddings.trailing),
//		])
//	}
}
