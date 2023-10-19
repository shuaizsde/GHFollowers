//
//  UITableView+Ext.swift
//  GHFollowers
//
//  Created by Sean Allen on 2/1/20.
//  Copyright © 2020 Sean Allen. All rights reserved.
//

import UIKit

extension UITableView {
    
    func reloadDataOnMainThread() {
        DispatchQueue.main.async { self.reloadData() }
    }
    

    func removeExcessCells() {
        tableFooterView = UIView(frame: .zero)
    }
}
