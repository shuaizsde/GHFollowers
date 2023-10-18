//
//  FollowerCell.swift
//  GHFollowers
//
//  Created by Shuai Zhang on 10/16/23.
//  Copyright © 2023 Simon Zhang. All rights reserved.
//

import UIKit

class FollowerCell: UICollectionViewCell {
    static let reuseID = "FollowerCell"
	let avatarImageView = GFAvatarImageView(frame: .zero)
	let userNameLabel = GFTitleLabel(textAlignment: .center, fontSize: 16)
	let padding: CGFloat = 8

	override init(frame: CGRect) {
		super.init(frame: frame)
		configure()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func set(follower: Follower) {
		userNameLabel.text = follower.login
		avatarImageView.downloadImage(from: follower.avatarUrl)
	}

	private func configure() {
		contentView.addSubview(avatarImageView)
		contentView.addSubview(userNameLabel)
		userNameLabel.adjustsFontSizeToFitWidth = false
		userNameLabel.numberOfLines = 2

		NSLayoutConstraint.activate([
			avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
			avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
			avatarImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
			avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),

			userNameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 12),
			userNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
			userNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
		])
	}


}
