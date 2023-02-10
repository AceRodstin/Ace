//
//  ParseStringLiteralTests.swift
//  Tests
//
//  Created by Ace Rodstin on 1/21/23.
//  Copyright © 2023 Ace Rodstin. All rights reserved.
//

import XCTest
@testable import Ace

final class ParseStringLiteralTests: XCTestCase {
	func testParseStringLiteral() throws {
		// Given
		let string = "\"abcde\""
		
		let literal = Literal(kind: .string, value: "abcde")
		let expected: [Token] = [.literal(literal)]
		
		// When
		let output = try Parser.parseTokens(string: string)
		
		// Then
		XCTAssert(output.contains(expected))
	}
}
