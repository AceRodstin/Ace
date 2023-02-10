//
//  ParsePunctuatorTests.swift
//  Tests
//
//  Created by Ace Rodstin on 1/19/23.
//

import XCTest
@testable import Ace

final class ParsePunctuatorTests: XCTestCase {
	func testParsePunctuatorEqualInAssignment() throws {
		// Given
		let string = "val value = 1"
		let expected: [Token] = [
			.keyword(.val),
			.identifier("value"),
			.punctuator(.equal),
			.literal(Literal(kind: .integer(.decimal), value: "1"))
		]
		
		// When
		let output = try Parser.parseTokens(string: string)
		
		// Then
		XCTAssertEqual(output, expected)
	}
	
	func testParsePunctuatorColonInTypeAnnotation() throws {
		// Given
		let string = "val value: Integer"
		let expected: [Token] = [
			.keyword(.val),
			.identifier("value"),
			.punctuator(.colon),
			.identifier("Integer")
		]
		
		// When
		let output = try Parser.parseTokens(string: string)
		
		// Then
		XCTAssertEqual(output, expected)
	}
	
	func testParseParenthesis() throws {
		// Given
		let string = "val value = (1 + 2)"
		let expected: [Token] = [
			.keyword(.val),
			.identifier("value"),
			.punctuator(.equal),
			.punctuator(.leftParenthesis),
			.literal(Literal(kind: .integer(.decimal), value: "1")),
			.punctuator(.plus),
			.literal(Literal(kind: .integer(.decimal), value: "2")),
			.punctuator(.rightParenthesis),
		]
		
		// When
		let output = try Parser.parseTokens(string: string)
		
		// Then
		XCTAssertEqual(output, expected)
	}
}
