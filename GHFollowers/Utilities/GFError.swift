//
//  GFError.swift
//  GHFollowers
//
//  Created by Sean Allen on 1/3/20.
//  Copyright © 2020 Sean Allen. All rights reserved.
//

import Foundation

enum GFError: String, Error {
	case networkIssue = "Unable to fetch data from user. Please check your internet."
	case userNotExist = "This user does not exist. Please try again."
	case unableToFavorite = "There was an error favoriting this user. Please try again."
	case alreadyInFavorites = "You've already favorited this user. You must REALLY like them!"

	var title: String {
		switch self {
		case .networkIssue: return "Network Error"
		case .userNotExist: return "User Doesn't Exist"
		case .unableToFavorite:
			return "Unable To Favoriate"
		case .alreadyInFavorites:
			return "Already In Favorites"
		}
		
	}
}

enum GFNetworkError: Error {
	case invalidURL
	case invalidResponseCode(statusCode: Int)
	case emptyData
	case unableToDecodeData
	case unexpectedError(errorMessage: String)
}
