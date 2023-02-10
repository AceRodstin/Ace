//
//  ParseCharacterLiteralTests.swift
//  Tests
//
//  Created by Ace Rodstin on 1/21/23.
//  Copyright © 2023 Ace Rodstin. All rights reserved.
//

import XCTest
@testable import Ace

final class ParseCharacterLiteralTests: XCTestCase {
	func testParseCharacterLiteral() throws {
		// Given
		let string = "'a'"
		
		let literal = Literal(kind: .character, value: "a")
		let expected: [Token] = [.literal(literal)]
		
		// When
		let output = try Parser.parseTokens(string: string)
		
		// Then
		XCTAssert(output.contains(expected))
	}
	
	func testParseCharacterLiteralThrows() {
		// Given
		let string = "'ab'"
		
		// Then
		XCTAssertThrowsError(try Parser.parseTokens(string: string))
	}
}
