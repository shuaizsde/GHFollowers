//
//  GHFollowersUITests.swift
//  GHFollowersUITests
//
//  Created by Shuai Zhang on 10/25/23.
//  Copyright © 2023 Simon Zhang. All rights reserved.
//

import XCTest
// @testable import GHFollowers

final class GHFollowersUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

	func testGitHubFollowersFlow() throws {
		// Launch the application.
		let app = XCUIApplication()
		app.launch()

		// Find the text field and type "zhang86036055".
		let textField = app.textFields["Enter a username"]
		XCTAssertTrue(textField.exists, "Username text field does not exist")
		textField.tap()
	}


    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
