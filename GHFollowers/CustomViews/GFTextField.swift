//
//  GFTextField.swift
//  GHFollowers
//
//  Created by Shuai Zhang on 10/12/23.
//  Copyright © 2023 Sean Allen. All rights reserved.
//

import UIKit

class GFTextField: UITextField {


	override init(frame: CGRect) {
		super.init(frame: frame)
		configure()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}


	private func configure() {
		translatesAutoresizingMaskIntoConstraints = false

		layer.cornerRadius = 10
		layer.borderWidth = 2
		// Note: convert to cgColor when dealing with layer
		layer.borderColor = UIColor.systemGray4.cgColor

		textColor = .label
		tintColor = .label
		textAlignment = .center
		font = UIFont.preferredFont(forTextStyle: .title2)
		adjustsFontSizeToFitWidth = true
		minimumFontSize = 12

		backgroundColor = .tertiarySystemBackground
		autocorrectionType = .no
		// optional: keyboardType = .emailAddress
		returnKeyType = .go
		placeholder = "Enter a username"
	}
}
