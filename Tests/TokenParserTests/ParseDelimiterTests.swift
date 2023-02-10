//
//  ParseDelimiterTests.swift
//  TokenParser
//
//  Created by Ace Rodstin on 1/21/23.
//  Copyright © 2023 Ace Rodstin. All rights reserved.
//

import XCTest
@testable import Ace

final class ParseDelimiterTests: XCTestCase {
	func testParseDelimiterSpace() throws {
		// Given
		let string = "val value"
		let expected: [Token] = [.keyword(.val), .identifier("value")]
		
		// When
		let output = try Parser.parseTokens(string: string)
		
		// Then
		XCTAssert(output.contains(expected))
	}
	
	func testParseDelimiterSpaces() throws {
		// Given
		let string = "val   value"
		let expected: [Token] = [.keyword(.val), .identifier("value")]
		
		// When
		let output = try Parser.parseTokens(string: string)
		
		// Then
		XCTAssert(output.contains(expected))
	}
	
	func testParseDelimiterHeadSpace() throws {
		// Given
		let string = " val"
		let expected: [Token] = [.keyword(.val)]
		
		// When
		let output = try Parser.parseTokens(string: string)
		
		// Then
		XCTAssert(output.contains(expected))
	}
	
	func testParseDelimiterHeadSpaces() throws {
		// Given
		let string = "   val"
		let expected: [Token] = [.keyword(.val)]
		
		// When
		let output = try Parser.parseTokens(string: string)
		
		// Then
		XCTAssert(output.contains(expected))
	}
	
	func testParseDelimiterTab() throws {
		// Given
		let string = "val\tvalue"
		let expected: [Token] = [.keyword(.val), .identifier("value")]
		
		// When
		let output = try Parser.parseTokens(string: string)
		
		// Then
		XCTAssert(output.contains(expected))
	}
	
	func testParseDelimiterTabs() throws {
		// Given
		let string = "val\t\t\tvalue"
		let expected: [Token] = [.keyword(.val), .identifier("value")]
		
		// When
		let output = try Parser.parseTokens(string: string)
		
		// Then
		XCTAssert(output.contains(expected))
	}
	
	func testParseDelimiterHeadTab() throws {
		// Given
		let string = "\tval"
		let expected: [Token] = [.keyword(.val)]
		
		// When
		let output = try Parser.parseTokens(string: string)
		
		// Then
		XCTAssert(output.contains(expected))
	}
	
	func testParseDelimiterHeadTabs() throws {
		// Given
		let string = "\t\t\tval"
		let expected: [Token] = [.keyword(.val)]
		
		// When
		let output = try Parser.parseTokens(string: string)
		
		// Then
		XCTAssert(output.contains(expected))
	}
}
