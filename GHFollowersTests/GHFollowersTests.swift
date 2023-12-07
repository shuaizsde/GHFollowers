//
//  GHFollowersTests.swift
//  GHFollowersTests
//
//  Created by Shuai Zhang on 10/25/23.
//  Copyright © 2023 Simon Zhang. All rights reserved.
//

import XCTest

@testable import GHFollowers
final class GHFollowersTests: XCTestCase {

	override func setUp() {
		super.setUp()
	}


	func testExample() throws {
		let client = GFAPIClient.shared
		let expectation = self.expectation(description: "Asynchronous task completed")

		client.fetchData(url: "www.google.com") { (result: Result<Follower, GFNetworkError>) in

			switch result {
			case .success(let fetchedFollower):
				XCTAssertEqual(fetchedFollower.login, "123")
				XCTAssertEqual(fetchedFollower.avatarUrl, "456")
			case .failure(let error):
				XCTFail("Failed with error: \(error)")
			}

			// Fulfill the expectation
			expectation.fulfill()
		}

		// Wait for the expectation to be fulfilled
		waitForExpectations(timeout: 5) { error in
			if let error = error {
				XCTFail("Wait for expectation timed out with error: \(error)")
			}
		}
	}

	func testExample2() throws {

	}
	func testExample3() throws {
//		let vc = FollowersGridViewController(userName: "simon")
//		XCTAssertTrue(vc.userName == "simon")
	}
	func testExample4() throws {
//		let vc = FollowersGridViewController(userName: "simon")
//		XCTAssertTrue(vc.userName == "simon")
	}
	func testExample5() throws {
//		let vc = FollowersGridViewController(userName: "simon")
//		XCTAssertTrue(vc.userName == "simon")
	}
	func testExample6() throws {
//		let vc = FollowersGridViewController(userName: "simon")
//		XCTAssertTrue(vc.userName == "simon")
	}

	
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
//        measure {
//            // Put the code you want to measure the time of here.
//        }
    }

}
