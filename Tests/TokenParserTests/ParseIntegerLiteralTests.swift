//
//  ParseIntegerLiteralTests.swift
//  TokenParser
//
//  Created by Ace Rodstin on 1/21/23.
//  Copyright © 2023 Ace Rodstin. All rights reserved.
//

import XCTest
@testable import Ace

final class ParseIntegerLiteralTests: XCTestCase {
	func testParseDecimalIntegerZero() throws {
		// Given
		let string = "0"
		
		let literal = Literal(kind: .integer(.decimal), value: "0")
		let expected: [Token] = [.literal(literal)]
		
		// When
		let output = try Parser.parseTokens(string: string)
		
		// Then
		XCTAssert(output.contains(expected))
	}
	
	func testParseDecimalIntegerLiteral() throws {
		// Given
		let string = "1"
		
		let literal = Literal(kind: .integer(.decimal), value: "1")
		let expected: [Token] = [.literal(literal)]
		
		// When
		let output = try Parser.parseTokens(string: string)
		
		// Then
		XCTAssert(output.contains(expected))
	}
	
	func testParseDecimalLiteralHasInvalidCharacter() {
		// Given
		let string = "1Z"
		
		// Then
		XCTAssertThrowsError(try Parser.parseTokens(string: string))
	}
	
	func testParseDecimalIntegerLiteralWithUnderscore() throws {
		// Given
		let string = "1_000"
		
		let literal = Literal(kind: .integer(.decimal), value: "1_000")
		let expected: [Token] = [.literal(literal)]
		
		// When
		let output = try Parser.parseTokens(string: string)
		
		// Then
		XCTAssert(output.contains(expected))
	}
	
	func testParseBinaryIntegerLiteral() throws {
		// Given
		let string = "0b1"
		
		let literal = Literal(kind: .integer(.binary), value: "0b1")
		let expected: [Token] = [.literal(literal)]
		
		// When
		let output = try Parser.parseTokens(string: string)
		
		// Then
		XCTAssert(output.contains(expected))
	}
	
	func testParseBinaryIntegerLiteralThrows() {
		// Given
		let string = "0bZ"
		
		// Then
		XCTAssertThrowsError(try Parser.parseTokens(string: string))
	}
	
	func testParseBinaryIntegerLiteralWithUnderscore() throws {
		// Given
		let string = "0b1_0"
		
		let literal = Literal(kind: .integer(.binary), value: "0b1_0")
		let expected: [Token] = [.literal(literal)]
		
		// When
		let output = try Parser.parseTokens(string: string)
		
		// Then
		XCTAssert(output.contains(expected))
	}
	
	func testParseOctalIntegerLiteral() throws {
		// Given
		let string = "0o7"
		
		let literal = Literal(kind: .integer(.octal), value: "0o7")
		let expected: [Token] = [.literal(literal)]
		
		// When
		let output = try Parser.parseTokens(string: string)
		
		// Then
		XCTAssert(output.contains(expected))
	}
	
	func testParseOctalIntegerLiteralThrows() {
		// Given
		let string = "0oZ"
		
		// Then
		XCTAssertThrowsError(try Parser.parseTokens(string: string))
	}
	
	func testParseOctalIntegerLiteralWithUnderscore() throws {
		// Given
		let string = "0o7_7"
		
		let literal = Literal(kind: .integer(.octal), value: "0o7_7")
		let expected: [Token] = [.literal(literal)]
		
		// When
		let output = try Parser.parseTokens(string: string)
		
		// Then
		XCTAssert(output.contains(expected))
	}
	
	func testParseHexadecimalIntegerLiteral() throws {
		// Given
		let string = "0xF"
		
		let literal = Literal(kind: .integer(.hexadecimal), value: "0xF")
		let expected: [Token] = [.literal(literal)]
		
		// When
		let output = try Parser.parseTokens(string: string)
		
		// Then
		XCTAssert(output.contains(expected))
	}
	
	func testParseHexadecimalIntegerLiteralThrows() {
		// Given
		let string = "0xZ"
		
		// Then
		XCTAssertThrowsError(try Parser.parseTokens(string: string))
	}
	
	func testParseHexadecimalIntegerLiteralWithUnderscore() throws {
		// Given
		let string = "0xF_F"
		
		let literal = Literal(kind: .integer(.hexadecimal), value: "0xF_F")
		let expected: [Token] = [.literal(literal)]
		
		// When
		let output = try Parser.parseTokens(string: string)
		
		// Then
		XCTAssert(output.contains(expected))
	}
	
	func testParseIntegerLiteralInParenthesis() throws {
		// Given
		let string = "(1)"
		
		let literal = Literal(kind: .integer(.decimal), value: "1")
		let expected: [Token] = [.literal(literal)]
		
		// When
		let output = try Parser.parseTokens(string: string)
		
		// Then
		XCTAssert(output.contains(expected))
	}
}
