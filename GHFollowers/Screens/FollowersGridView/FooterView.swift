//
//  FollowersGridFooterView.swift
//  GHFollowers
//
//  Created by Shuai Zhang on 10/19/23.
//  Copyright © 2023 Simon Zhang. All rights reserved.
//

import UIKit
class FooterView: UICollectionReusableView {
	let label: UILabel = {
		let lbl = UILabel()
		lbl.textAlignment = .center
		lbl.translatesAutoresizingMaskIntoConstraints = false
		return lbl
	}()

	override init(frame: CGRect) {
		super.init(frame: frame)
		addSubview(label)
		NSLayoutConstraint.activate([
			label.centerXAnchor.constraint(equalTo: centerXAnchor),
			label.centerYAnchor.constraint(equalTo: centerYAnchor)
		])
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
