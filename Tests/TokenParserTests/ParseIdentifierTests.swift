//
//  ParseIdentifierTests.swift
//  Tests
//
//  Created by Ace Rodstin on 1/21/23.
//  Copyright © 2023 Ace Rodstin. All rights reserved.
//

import XCTest
@testable import Ace

final class ParseIdentifierTests: XCTestCase {
	func testParseIdentifier() throws {
		// Given
		let string = "value"
		let expected: Token = .identifier("value")
		
		// When
		let output = try Parser.parseTokens(string: string)
		
		// Then
		XCTAssert(output.contains(expected))
	}

	func testParseIdentifierWithDecimal() throws {
		// Given
		let string = "value1"
		let expected: [Token] = [.identifier("value1")]
		
		// When
		let output = try Parser.parseTokens(string: string)
		
		// Then
		XCTAssert(output.contains(expected))
	}

	func testParseIdentifierWithUnderscore() throws {
		// Given
		let string = "head_ing"
		let expected: [Token] = [.identifier("head_ing")]
		
		// When
		let output = try Parser.parseTokens(string: string)
		
		// Then
		XCTAssert(output.contains(expected))
	}
	
	func testParseIdentifierStartsWithDigit() {
		// Given
		let string = "1a"
		
		// Then
		XCTAssertThrowsError(try Parser.parseTokens(string: string))
	}
}
