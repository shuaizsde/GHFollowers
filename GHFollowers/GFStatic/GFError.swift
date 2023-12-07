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
	case failedToGetCurrentUser = "Failed to get authenticated User"
	case failedToFollowUser = "Failed to follow this user"

	var title: String {
		switch self {
		case .networkIssue: return "Network Error"
		case .userNotExist: return "User Doesn't Exist"
		case .unableToFavorite:
			return "Unable To Favoriate"
		case .alreadyInFavorites:
			return "Already In Favorites"
		case .failedToGetCurrentUser:
			return "Invalid Authentication"
		case .failedToFollowUser:
			return "Unable to Follow User"
		}
		
	}
}

enum GFNetworkError: Error {
	case invalidURL
	case invalidToken
	case invalidResponseCode(statusCode: Int)
	case emptyData
	case unableToDecodeData
	case unexpectedError(errorMessage: String)
}
