//
//  File.swift
//  GHFollowers
//
//  Created by Shuai Zhang on 10/13/23.
//  Copyright © 2023 Simon Zhang. All rights reserved.
//

import Foundation

struct User: Codable {
	let login: String
	let avatarUrl: String
	var name: String?
	var location: String?
	var bio: String?
	let publicRepos: Int
	let publicGists: Int
	let htmlUrl: String
	let following: Int
	let followers: Int
	let createdAt: String
	let reposUrl: String
}

extension String {
	func convertToDate() -> Date? {
		let dateFormatter           = DateFormatter()
		dateFormatter.dateFormat    = "yyyy-MM-dd'T'HH:mm:ssZ"
		dateFormatter.locale        = Locale(identifier: "en_US_POSIX")
		dateFormatter.timeZone      = .current

		return dateFormatter.date(from: self)
	}


	func convertToDisplayFormat() -> String {
		guard let date = self.convertToDate() else { return "N/A" }
		return date.convertToMonthYearFormat()
	}
}

extension Date {
	func convertToMonthYearFormat() -> String {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "MMM yyyy"
		return dateFormatter.string(from: self)
	}
}
