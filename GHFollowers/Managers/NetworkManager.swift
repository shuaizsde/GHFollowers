//
//  NetworkManager.swift
//  GHFollowers
//
//  Created by Shuai Zhang on 10/13/23.
//  Copyright © 2023 Simon Zhang. All rights reserved.
//

import Foundation

// Singleton
final class NetworkManager {
	static let shared = NetworkManager()

	private init() {}

	let baseUrl = "https://api.github.com/users/"

	func getFollowers(for userName: String, page: Int, completion: @escaping (Result<[Follower], GFError>) -> Void) {
		let endPoint = baseUrl + "\(userName)/followers?per_page=100&page=\(page)"

		guard let url = URL(string: endPoint) else {
			completion(.failure(.invalidUsername))
			return
		}
		let task = URLSession.shared.dataTask(with: url) { data, response, error in
			if let error = error {
				completion(.failure(.unableToComplete(errorMessage: error.localizedDescription)))
				return
			}
			guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
				completion(.failure(.invalidResponse))
				return
			}
			guard let data = data else {
				completion(.failure(.invalidData))
				return
			}
			do {
				let decoder = JSONDecoder()
				decoder.keyDecodingStrategy = .convertFromSnakeCase
				let followers = try decoder.decode([Follower].self, from: data)
				completion(.success(followers))
			} catch {
				completion(.failure(.invalidData))
			}
		}
		task.resume()
	}

}
