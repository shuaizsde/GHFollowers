//
//  GFUserInfoHeaderVC.swift
//  GHFollowers
//
//  Created by Sean Allen on 1/22/20.
//  Copyright © 2020 Sean Allen. All rights reserved.
//

import UIKit

class GFUserInfoHeaderVC: UIViewController {
    
    let avatarImageView     = GFAvatarImageView(frame: .zero)
    let usernameLabel       = GFTitleLabel(textAlignment: .left, fontSize: 34)
    let nameLabel           = GFSecondaryTitleLabel(fontSize: 18)
    let locationImageView   = UIImageView()
    let locationLabel       = GFSecondaryTitleLabel(fontSize: 18)
    let bioLabel            = GFBodyLabel(textAlignment: .left)
	let followButton		= GFCircledButton(color: .systemGreen, systemImageName: "plus")
    
    var user: User!
    
    
    init(user: User) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        layoutUI()
        configureUIElements()
    }
    
    
    func configureUIElements() {
        avatarImageView.downloadImage(from: user.avatarUrl)
        usernameLabel.text          = user.login
        nameLabel.text              = user.name ?? ""
        locationLabel.text          = user.location ?? "No Location"
        bioLabel.text               = user.bio ?? "No bio available"
        bioLabel.numberOfLines      = 3
		followButton.addTarget(self, action: #selector(followUser), for: .touchUpInside)
        locationImageView.image     = SFSymbols.location
        locationImageView.tintColor = .secondaryLabel
    }
    
    
    func addSubviews() {
        view.addSubview(avatarImageView)
        view.addSubview(usernameLabel)
        view.addSubview(nameLabel)
        view.addSubview(locationImageView)
        view.addSubview(locationLabel)
        view.addSubview(bioLabel)
		view.addSubview(followButton)
    }
    
	@objc func followUser() {
		NetworkManager.shared.follow(userName: user.login) {[weak self] error in
			guard let self = self else {return}
			if let error = error {
				self.showAlert(title: error.title, message: error.rawValue, buttonTitle: "OK")
			}else {
				self.showAlert(title: "Success", message: "Successfully Followed \(user.login)", buttonTitle: "OK")
			}
		}
	}

    func layoutUI() {
        let padding: CGFloat            = 20
        let textImagePadding: CGFloat   = 12
        locationImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            avatarImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            avatarImageView.widthAnchor.constraint(equalToConstant: 90),
            avatarImageView.heightAnchor.constraint(equalToConstant: 90),

			followButton.topAnchor.constraint(equalTo: avatarImageView.topAnchor, constant: 8),
			followButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
			followButton.widthAnchor.constraint(equalToConstant: 25),
			followButton.heightAnchor.constraint(equalToConstant: 25),

            usernameLabel.topAnchor.constraint(equalTo: avatarImageView.topAnchor),
            usernameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
            usernameLabel.trailingAnchor.constraint(equalTo: followButton.leadingAnchor, constant: -textImagePadding),
            usernameLabel.heightAnchor.constraint(equalToConstant: 38),

            nameLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 20),
            
            locationImageView.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor),
            locationImageView.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
            locationImageView.widthAnchor.constraint(equalToConstant: 20),
            locationImageView.heightAnchor.constraint(equalToConstant: 20),
            
            locationLabel.centerYAnchor.constraint(equalTo: locationImageView.centerYAnchor),
            locationLabel.leadingAnchor.constraint(equalTo: locationImageView.trailingAnchor, constant: 5),
            locationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            locationLabel.heightAnchor.constraint(equalToConstant: 20),
            
            bioLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: textImagePadding),
            bioLabel.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor),
            bioLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bioLabel.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}
