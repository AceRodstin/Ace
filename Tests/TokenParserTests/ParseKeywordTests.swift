//
//  ParseKeywordTests.swift
//  Tests
//
//  Created by Ace Rodstin on 1/21/23.
//  Copyright © 2023 Ace Rodstin. All rights reserved.
//

import XCTest
@testable import Ace

final class ParseKeywordTests: XCTestCase {
	func testParseKeyword() throws {
		// Given
		let string = "val"
		let expected: Token = .keyword(.val)
		
		// When
		let output = try Parser.parseTokens(string: string)
		
		// Then
		XCTAssert(output.contains(expected))
	}
}
