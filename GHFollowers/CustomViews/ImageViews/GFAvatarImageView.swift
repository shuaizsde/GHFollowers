//
//  GFAvatarImageView.swift
//  GHFollowers
//
//  Created by Shuai Zhang on 10/16/23.
//  Copyright © 2023 Simon Zhang. All rights reserved.
//

import UIKit

class GFAvatarImageView: UIImageView {

	let placeholderImage = UIImage(named: "avatar-placeholder")!

	override init(frame: CGRect) {
		super.init(frame: frame)
		configure()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}


	private func configure() {
		layer.cornerRadius = 10
		clipsToBounds = true
		image = placeholderImage
		translatesAutoresizingMaskIntoConstraints = false
		
	}

	func downloadImage(from urlString: String) {
		NetworkManager.shared.fetchImage(from: urlString) { [weak self] image in
			guard let self else {return}
			DispatchQueue.main.async {
				self.image = image
			}
		}
	}

}
