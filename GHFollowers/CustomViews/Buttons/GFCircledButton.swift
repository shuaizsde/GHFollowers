//
//  GFCircledButton.swift
//  GHFollowers
//
//  Created by Shuai Zhang on 10/20/23.
//  Copyright © 2023 Simon Zhang. All rights reserved.
//

import UIKit

class GFCircledButton: UIButton {

	override init(frame: CGRect) {
		super.init(frame: frame)
		configure()
	}

	init(color: UIColor, systemImageName: String) {
		super.init(frame: .zero)
		setImage(UIImage(systemName: systemImageName)?.withRenderingMode(.alwaysTemplate), for: .normal)
		backgroundColor = color
		configure()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	private func configure() {
		imageView?.tintColor = .white
		translatesAutoresizingMaskIntoConstraints = false
	}

	override func layoutSubviews() {
		super.layoutSubviews()
		layer.cornerRadius = self.bounds.width / 2
	}
}
