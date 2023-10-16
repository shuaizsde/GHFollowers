//
//  ErrorMessage.swift
//  GHFollowers
//
//  Created by Sean Allen on 1/3/20.
//  Copyright © 2020 Sean Allen. All rights reserved.
//

import Foundation

enum GFError: Error {

	case invalidUsername
	case unableToComplete(errorMessage: String)
	case invalidResponse
	case invalidData

	var message: String {
		switch self {
		case .invalidUsername: return "This username created an invalid request. Please try again."
		case .unableToComplete(let message): return "Unable to complete your request. Error Message: \(message)"
		case .invalidResponse: return "Invalid response from the server. Please try again."
		case .invalidData: return "The data received from the server was invalid. Please try again."
		}
	}

	var title: String {
		switch self {
		case .invalidUsername: return "Invalid URL"
		case .unableToComplete: return "Unable to complete"
		case .invalidResponse: return "Bad Response"
		case .invalidData: return "Decoding Error"
		}
		
	}
}
