//
//  IntegerLiteralsParserTests.swift
//  Tests
//
//  Created by Ace Rodstin on 1/17/23.
//  Copyright © 2023 Ace Rodstin. All rights reserved.
//

import XCTest
@testable import Ace

final class IntegerLiteralsParserTests: XCTestCase {
	
	private let parser = SyntacticAnalyzer.IntegerLiteralsParser()
	
	private func parse(string: String) throws -> SyntacticNode {
		let tokenParser = TokenParser()
		let tokens = try tokenParser.parse(string: string)
		
		let stream = Stream(tokens)
		return try parser.parse(stream: stream)
	}
	
	func testParseDecimalLiteral() throws {
		// Given
		let string = "1234567890"
		
		let expected = """
		IntegerLiteral
		└─ DecimalLiteral
		   ├─ DecimalDigit
		   │  └─ NonTerminal "1"
		   └─ DecimalDigits
		      ├─ DecimalDigit
		      │  └─ NonTerminal "2"
		      ├─ DecimalDigit
		      │  └─ NonTerminal "3"
		      ├─ DecimalDigit
		      │  └─ NonTerminal "4"
		      ├─ DecimalDigit
		      │  └─ NonTerminal "5"
		      ├─ DecimalDigit
		      │  └─ NonTerminal "6"
		      ├─ DecimalDigit
		      │  └─ NonTerminal "7"
		      ├─ DecimalDigit
		      │  └─ NonTerminal "8"
		      ├─ DecimalDigit
		      │  └─ NonTerminal "9"
		      └─ DecimalDigit
		         └─ NonTerminal "0"
		"""
		
		// When
		let syntacticTree = try parse(string: string)
		let output = syntacticTree.debugDescription
		
		// Then
		XCTAssertEqual(output, expected)
	}
	
	func testParseDecimalLiteralHasUnderscore() throws {
		// Given
		let string = "1_000"

		let expected = """
		IntegerLiteral
		└─ DecimalLiteral
		   ├─ DecimalDigit
		   │  └─ NonTerminal "1"
		   ├─ NonTerminal "_"
		   └─ DecimalDigits
		      ├─ DecimalDigit
		      │  └─ NonTerminal "0"
		      ├─ DecimalDigit
		      │  └─ NonTerminal "0"
		      └─ DecimalDigit
		         └─ NonTerminal "0"
		"""
		
		// When
		let syntacticTree = try parse(string: string)
		let output = syntacticTree.debugDescription
		
		// Then
		XCTAssertEqual(output, expected)
	}
	
	func testParseDecimalLiteralHasUnderscores() {
		// Given
		let string = "1__000"
		
		// Then
		XCTAssertThrowsError(try parse(string: string))
	}
	
	func testParseDecimalLiteralStartsWithUnderscore() {
		// Given
		let string = "_1000"
		
		// Then
		XCTAssertThrowsError(try parse(string: string))
	}
	
	func testParseDecimalLiteralEndsWithUnderscore() throws {
		// Given
		let string = "1000_"
		
		// Then
		XCTAssertThrowsError(try parse(string: string))
	}
	
	func testParseBinaryLiteral() throws {
		// Given
		let string = "0b10"
		
		let expected = """
		IntegerLiteral
		└─ BinaryLiteral
		   ├─ NonTerminal "0b"
		   └─ BinaryDigits
		      ├─ BinaryDigit
		      │  └─ NonTerminal "1"
		      └─ BinaryDigit
		         └─ NonTerminal "0"
		"""
		
		// When
		let syntacticTree = try parse(string: string)
		let output = syntacticTree.debugDescription
		
		// Then
		XCTAssertEqual(output, expected)
	}
	
	func testParseBinaryLiteralHasUnderscore() throws {
		// Given
		let string = "0b1_0"
		
		let expected = """
		IntegerLiteral
		└─ BinaryLiteral
		   ├─ NonTerminal "0b"
		   └─ BinaryDigits
		      ├─ BinaryDigit
		      │  └─ NonTerminal "1"
		      ├─ NonTerminal "_"
		      └─ BinaryDigit
		         └─ NonTerminal "0"
		"""
		
		// When
		let syntacticTree = try parse(string: string)
		let output = syntacticTree.debugDescription
		
		// Then
		XCTAssertEqual(output, expected)
	}
	
	func testParseBinaryLiteralHasUnderscores() {
		// Given
		let string = "0b1__0"
		
		// Then
		XCTAssertThrowsError(try parse(string: string))
	}
	
	func testParseBinaryLiteralStartsWithUnderscore() throws {
		// Given
		let string = "0b_1"
		
		let expected = """
		IntegerLiteral
		└─ BinaryLiteral
		   ├─ NonTerminal "0b"
		   ├─ NonTerminal "_"
		   └─ BinaryDigits
		      └─ BinaryDigit
		         └─ NonTerminal "1"
		"""
		
		// When
		let syntacticTree = try parse(string: string)
		let output = syntacticTree.debugDescription
		
		// Then
		XCTAssertEqual(output, expected)
	}
	
	func testParseBinaryLiteralEndsWithUnderscore() {
		// Given
		let string = "0b1_"
		
		// Then
		XCTAssertThrowsError(try parse(string: string))
	}
	
	func testParseOctalLiteral() throws {
		// Given
		let string = "0o1234567"
		
		let expected = """
		IntegerLiteral
		└─ OctalLiteral
		   ├─ NonTerminal "0o"
		   └─ OctalDigits
		      ├─ OctalDigit
		      │  └─ NonTerminal "1"
		      ├─ OctalDigit
		      │  └─ NonTerminal "2"
		      ├─ OctalDigit
		      │  └─ NonTerminal "3"
		      ├─ OctalDigit
		      │  └─ NonTerminal "4"
		      ├─ OctalDigit
		      │  └─ NonTerminal "5"
		      ├─ OctalDigit
		      │  └─ NonTerminal "6"
		      └─ OctalDigit
		         └─ NonTerminal "7"
		"""
		
		// When
		let syntacticTree = try parse(string: string)
		let output = syntacticTree.debugDescription
		
		// Then
		XCTAssertEqual(output, expected)
	}
	
	func testOctalLiteralHasUnderscore() throws {
		// Given
		let string = "0o1_2"
		
		let expected = """
		IntegerLiteral
		└─ OctalLiteral
		   ├─ NonTerminal "0o"
		   └─ OctalDigits
		      ├─ OctalDigit
		      │  └─ NonTerminal "1"
		      ├─ NonTerminal "_"
		      └─ OctalDigit
		         └─ NonTerminal "2"
		"""
		
		// When
		let syntacticTree = try parse(string: string)
		let output = syntacticTree.debugDescription
		
		// Then
		XCTAssertEqual(output, expected)
	}
	
	func testParseOctalLiteralHasUnderscores() {
		// Given
		let string = "0o1__2"
		
		// Then
		XCTAssertThrowsError(try parse(string: string))
	}
	
	func testParseOctalLiteralStartsWithUnderscore() throws {
		// Given
		let string = "0o_1"
		
		let expected = """
		IntegerLiteral
		└─ OctalLiteral
		   ├─ NonTerminal "0o"
		   ├─ NonTerminal "_"
		   └─ OctalDigits
		      └─ OctalDigit
		         └─ NonTerminal "1"
		"""
		
		// When
		let syntacticTree = try parse(string: string)
		let output = syntacticTree.debugDescription
		
		// Then
		XCTAssertEqual(output, expected)
	}
	
	func testParseOctalLiteralEndsWithUnderscore() {
		// Given
		let string = "0o1_"
		
		// Then
		XCTAssertThrowsError(try parse(string: string))
	}
	
	func testParseHexadecimalLiteralHasDecimalDigits() throws {
		// Given
		let string = "0x1234567890"
		
		let expected = """
		IntegerLiteral
		└─ HexadecimalLiteral
		   ├─ NonTerminal "0x"
		   └─ HexadecimalDigits
		      ├─ HexadecimalDigit
		      │  └─ NonTerminal "1"
		      ├─ HexadecimalDigit
		      │  └─ NonTerminal "2"
		      ├─ HexadecimalDigit
		      │  └─ NonTerminal "3"
		      ├─ HexadecimalDigit
		      │  └─ NonTerminal "4"
		      ├─ HexadecimalDigit
		      │  └─ NonTerminal "5"
		      ├─ HexadecimalDigit
		      │  └─ NonTerminal "6"
		      ├─ HexadecimalDigit
		      │  └─ NonTerminal "7"
		      ├─ HexadecimalDigit
		      │  └─ NonTerminal "8"
		      ├─ HexadecimalDigit
		      │  └─ NonTerminal "9"
		      └─ HexadecimalDigit
		         └─ NonTerminal "0"
		"""
		
		// When
		let syntacticTree = try parse(string: string)
		let output = syntacticTree.debugDescription
		
		// Then
		XCTAssertEqual(output, expected)
	}
	
	func testParseHexadecimalLiteralHasUppercaseDigits() throws {
		// Given
		let string = "0xABCDEF"
		
		let expected = """
		IntegerLiteral
		└─ HexadecimalLiteral
		   ├─ NonTerminal "0x"
		   └─ HexadecimalDigits
		      ├─ HexadecimalDigit
		      │  └─ NonTerminal "A"
		      ├─ HexadecimalDigit
		      │  └─ NonTerminal "B"
		      ├─ HexadecimalDigit
		      │  └─ NonTerminal "C"
		      ├─ HexadecimalDigit
		      │  └─ NonTerminal "D"
		      ├─ HexadecimalDigit
		      │  └─ NonTerminal "E"
		      └─ HexadecimalDigit
		         └─ NonTerminal "F"
		"""
		
		// When
		let syntacticTree = try parse(string: string)
		let output = syntacticTree.debugDescription
		
		// Then
		XCTAssertEqual(output, expected)
	}
	
	func testParseHexadecimalLiteralHasLowercaseDigits() throws {
		// Given
		let string = "0xabcdef"
		
		let expected = """
		IntegerLiteral
		└─ HexadecimalLiteral
		   ├─ NonTerminal "0x"
		   └─ HexadecimalDigits
		      ├─ HexadecimalDigit
		      │  └─ NonTerminal "a"
		      ├─ HexadecimalDigit
		      │  └─ NonTerminal "b"
		      ├─ HexadecimalDigit
		      │  └─ NonTerminal "c"
		      ├─ HexadecimalDigit
		      │  └─ NonTerminal "d"
		      ├─ HexadecimalDigit
		      │  └─ NonTerminal "e"
		      └─ HexadecimalDigit
		         └─ NonTerminal "f"
		"""
		
		// When
		let syntacticTree = try parse(string: string)
		let output = syntacticTree.debugDescription
		
		// Then
		XCTAssertEqual(output, expected)
	}
	
	func testParseHexadecimalLiteralHasUnderscore() throws {
		// Given
		let string = "0xF_F"
		
		let expected = """
		IntegerLiteral
		└─ HexadecimalLiteral
		   ├─ NonTerminal "0x"
		   └─ HexadecimalDigits
		      ├─ HexadecimalDigit
		      │  └─ NonTerminal "F"
		      ├─ NonTerminal "_"
		      └─ HexadecimalDigit
		         └─ NonTerminal "F"
		"""
		
		// When
		let syntacticTree = try parse(string: string)
		let output = syntacticTree.debugDescription
		
		// Then
		XCTAssertEqual(output, expected)
	}
	
	func testParseHexadecimalLiteralHasUnderscores() {
		// Given
		let string = "0xF__F"
		
		// Then
		XCTAssertThrowsError(try parse(string: string))
	}
	
	func testParseHexadecimalLiteralStartsWithUnderscore() throws {
		// Given
		let string = "0x_F"
		
		let expected = """
		IntegerLiteral
		└─ HexadecimalLiteral
		   ├─ NonTerminal "0x"
		   ├─ NonTerminal "_"
		   └─ HexadecimalDigits
		      └─ HexadecimalDigit
		         └─ NonTerminal "F"
		"""
		
		// When
		let syntacticTree = try parse(string: string)
		let output = syntacticTree.debugDescription
		
		// Then
		XCTAssertEqual(output, expected)
	}
	
	func testParseHexadecimalLiteralEndsWithUnderscore() {
		// Given
		let string = "0xF_"
		
		// Then
		XCTAssertThrowsError(try parse(string: string))
	}
}
