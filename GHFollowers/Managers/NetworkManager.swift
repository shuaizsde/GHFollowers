//
//  NetworkManager.swift
//  GHFollowers
//
//  Created by Shuai Zhang on 10/13/23.
//  Copyright © 2023 Simon Zhang. All rights reserved.
//

import UIKit

// Singleton
final class NetworkManager {

	static let shared = NetworkManager()

	private let baseUrl = "https://api.github.com/users/"
	private let APIClient = GFAPIClient.shared


	init() {}

	func getAuthenticatedUser(completion: @escaping (Result<User, GFError>) -> Void) {
		let endPoint = "https://api.github.com/user"
		APIClient.fetchData(url: endPoint) { (result: Result<User, GFNetworkError>) in
			switch result {
			case .success(let currentUser):
				completion(.success(currentUser))
			case .failure:
				completion(.failure(GFError.failedToGetCurrentUser))
			}
		}
	}

	func follow(userName: String , completion: @escaping (GFError?) -> Void) {
		let endPoint = "https://api.github.com/user/following/\(userName)"
		APIClient.putRequest(url: endPoint) { result in
			switch result {
			case .success(let response):
				if !(response.statusCode >= 200 && response.statusCode < 300 ) {
					completion(.failedToFollowUser)
				}else {
					completion(nil)
				}
			case .failure:
				completion(.failedToFollowUser)
			}
		}
	}

	func getFollowers(for userName: String, page: Int, completion: @escaping (Result<[Follower], GFError>) -> Void) {
		let endPoint = baseUrl + "\(userName)/followers?per_page=100&page=\(page)"

		APIClient.fetchData(url: endPoint) { (result: Result<[Follower], GFNetworkError>) in
			switch result {
			case .success(let followers):
				completion(.success(followers))
			case .failure(let error):
				switch error {
				case .emptyData, .unableToDecodeData, .invalidURL, .unexpectedError, .invalidToken:
					completion(.failure(.networkIssue))
				case .invalidResponseCode(let code):
					if code == 404 {
						completion(.failure(.userNotExist))
					}else {
						completion(.failure(.networkIssue))
					}
				}
			}
		}
	}
	
	func getUserInfo(for userName: String, completion: @escaping (Result<User, GFError>) -> Void) {
		let endPoint = baseUrl + "\(userName)"
		APIClient.fetchData(url: endPoint) { (result: Result<User, GFNetworkError>) in
			switch result {
			case .success(let user):
				completion(.success(user))
			case .failure(let error):
				switch error {
				case .emptyData, .unableToDecodeData, .invalidURL, .unexpectedError, .invalidToken:
					completion(.failure(.networkIssue))
				case .invalidResponseCode(let code):
					if code == 404 {
						completion(.failure(.userNotExist))
					}else {
						completion(.failure(.networkIssue))
					}
				}
			}
		}
	}

	// TODO: Decide either fetching from DB or call API Client, optimize checking if should fetch thumbnail or original picture
	func fetchImage(from urlString: String, completion: @escaping ((UIImage) -> Void)) {
		APIClient.fetchImage(from: urlString) { image in
			completion(image)
		}
	}
}


//// Async Practice
//extension NetworkManager {
//
//	func fetchImageAsync(from urlString: String) async -> UIImage? {
//
//		let cacheKey = NSString(string: urlString)
//		if let image = cache.object(forKey: cacheKey) {
//			print("used cache for: \(urlString)")
//			return image
//		}
//
//		guard let url = URL(string: urlString) else { return nil }
//
//		do {
//			let (data, _) = try await URLSession.shared.data(for: URLRequest(url: url))
//			guard let image = UIImage(data: data) else {
//				return nil
//			}
//			self.cache.setObject(image, forKey: cacheKey)
//			return image
//		} catch {
//			return nil
//		}
//
//	}
//}
