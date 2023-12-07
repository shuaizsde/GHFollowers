//
//  APIClient.swift
//  GHFollowers
//
//  Created by Shuai Zhang on 10/16/23.
//  Copyright © 2023 Simon Zhang. All rights reserved.
//

import UIKit
class GFAPIClient {

	let cache = NSCache<NSString, UIImage>()

	static let shared = GFAPIClient()
	let decoder: JSONDecoder

	var token: String? {
		AuthenticationManager.shared.loadToken()
	}

	private init() {
		decoder = JSONDecoder()
		decoder.keyDecodingStrategy = .convertFromSnakeCase
		decoder.dateDecodingStrategy = .iso8601
	}

	func putRequest(url: String, completion: @escaping (Result<HTTPURLResponse, GFNetworkError>) -> Void) {
		guard let url = URL(string: url) else {
			completion(.failure(.invalidURL))
			return
		}
		var request = URLRequest(url: url)
        if let token = self.token, token.count > 10 {
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
		request.httpMethod = "PUT"
		let task = URLSession.shared.dataTask(with: request) { data, response, error in
			if let error = error {
				completion(.failure(.unexpectedError(errorMessage: error.localizedDescription)))
				return
			}

			guard let response = response as? HTTPURLResponse else {
				completion(.failure(.unexpectedError(errorMessage: "response is not HTTPURLResponse")))
				return
			}

			completion(.success(response))
		}
		task.resume()

	}

	func fetchData<Entity>(url: String, completion: @escaping (Result<Entity, GFNetworkError>) -> Void) where Entity: Codable {

		guard let url = URL(string: url) else {
			completion(.failure(.invalidURL))
			return
		}

		var request = URLRequest(url: url)
        if let token = self.token, token.count > 10 {
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }


		let task = URLSession.shared.dataTask(with: request) { data, response, error in
			if let error = error {
				completion(.failure(.unexpectedError(errorMessage: error.localizedDescription)))
				return
			}
			guard let response = response as? HTTPURLResponse else {
				completion(.failure(.unexpectedError(errorMessage: "response is not HTTPURLResponse")))
				return
			}
			guard response.statusCode == 200 else {
				completion(.failure(.invalidResponseCode(statusCode: response.statusCode)))
				return
			}
			guard let data = data else {
				completion(.failure(.emptyData))
				return
			}
			do {
				let result = try self.decoder.decode(Entity.self, from: data)
				completion(.success(result))
			} catch {
				completion(.failure(.unableToDecodeData))
			}
		}
		task.resume()
	}

	// TODO: Log Errors
	func fetchImage(from urlString: String, completion: @escaping ((UIImage) -> Void)) {

		let cacheKey = NSString(string: urlString)

		if let image = cache.object(forKey: cacheKey) {
			// print("used cache for: \(urlString)")
			completion(image)
		}
		guard let url = URL(string: urlString) else { return }

		var request = URLRequest(url: url)
		
        if let token = self.token, token.count > 10 {
			request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
		}

		let task = URLSession.shared.dataTask(with: request) {[weak self] data, response, error in
			guard let self else {return}
			guard error == nil else {return}
			guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {return}
			guard let data = data else {return}

			guard let image = UIImage(data: data) else {return}
			// self.cache.setObject(image, forKey: cacheKey)
			completion(image)
		}

		task.resume()
	}
}
