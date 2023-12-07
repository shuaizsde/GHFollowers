//
//  ButtonTests.swift
//  GHFollowersTests
//
//  Created by Shuai Zhang on 10/25/23.
//  Copyright © 2023 Simon Zhang. All rights reserved.
//

import XCTest
@testable import GHFollowers

final class ButtonTests: XCTestCase {
	func testButton() {
		let button = GFButton(backgroundColor: .black, title: "haha")
		XCTAssertTrue(button.titleLabel?.text == "haha")
	}
}
