//
//  FollowerListVC.swift
//  GHFollowers
//
//  Created by Shuai Zhang on 10/12/23.
//  Copyright © 2023 Sean Allen. All rights reserved.
//

import UIKit

class FollowerListVC: UIViewController {

	var userName: String!

    override func viewDidLoad() {
        super.viewDidLoad()
		view.backgroundColor = .systemRed
		navigationController?.isNavigationBarHidden = false
		navigationController?.navigationBar.prefersLargeTitles = true
    }
}
