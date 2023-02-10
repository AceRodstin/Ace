//
//  FloatingPointLiteralsParserTests.swift
//  SyntacticAnalyzer
//
//  Created by Ace Rodstin on 2/8/23.
//  Copyright © 2023 Ace Rodstin. All rights reserved.
//

import XCTest
@testable import Ace

final class FloatingPointLiteralsParserTests: XCTestCase {
	
	private let parser = SyntacticAnalyzer.FloatingPointLiteralsParser()
	
	private func parse(string: String) throws -> SyntacticNode {
		let tokenParser = TokenParser()
		let tokens = try tokenParser.parse(string: string)
		
		let stream = Stream(tokens)
		return try parser.parse(stream: stream)
	}
	
	func testParseDecimalFloatLiteralWithFraction() throws {
		// Given
		let string = "1.1"
		
		let expected = """
		FloatLiteral
		└─ DecimalFloatLiteral
		   ├─ DecimalDigits
		   │  └─ DecimalDigit
		   │     └─ NonTerminal "1"
		   ├─ NonTerminal "."
		   └─ DecimalDigits
		      └─ DecimalDigit
		         └─ NonTerminal "1"
		"""
		
		// When
		let syntacticTree = try parse(string: string)
		let output = syntacticTree.debugDescription
		
		// Then
		XCTAssertEqual(output, expected)
	}
	
	func testParseDecimalFloatLiteralWithExponent() throws {
		// Given
		let string = "1E2"
		
		let expected = """
		FloatLiteral
		└─ DecimalFloatLiteral
		   ├─ DecimalDigits
		   │  └─ DecimalDigit
		   │     └─ NonTerminal "1"
		   └─ DecimalExponent
		      ├─ NonTerminal "E"
		      └─ DecimalDigits
		         └─ DecimalDigit
		            └─ NonTerminal "2"
		"""
		
		// When
		let syntacticTree = try parse(string: string)
		let output = syntacticTree.debugDescription
		
		// Then
		XCTAssertEqual(output, expected)
	}
	
	func testParseDecimalFloatLiteralWithExponentPlusSign() throws {
		// Given
		let string = "1E+2"
		
		let expected = """
		FloatLiteral
		└─ DecimalFloatLiteral
		   ├─ DecimalDigits
		   │  └─ DecimalDigit
		   │     └─ NonTerminal "1"
		   └─ DecimalExponent
		      ├─ NonTerminal "E"
		      ├─ NonTerminal "+"
		      └─ DecimalDigits
		         └─ DecimalDigit
		            └─ NonTerminal "2"
		"""
		
		// When
		let syntacticTree = try parse(string: string)
		let output = syntacticTree.debugDescription
		
		// Then
		XCTAssertEqual(output, expected)
	}
	
	func testParseDecimalFloatLiteralWithExponentMinusSign() throws {
		// Given
		let string = "1E-2"
		
		let expected = """
		FloatLiteral
		└─ DecimalFloatLiteral
		   ├─ DecimalDigits
		   │  └─ DecimalDigit
		   │     └─ NonTerminal "1"
		   └─ DecimalExponent
		      ├─ NonTerminal "E"
		      ├─ NonTerminal "-"
		      └─ DecimalDigits
		         └─ DecimalDigit
		            └─ NonTerminal "2"
		"""
		
		// When
		let syntacticTree = try parse(string: string)
		let output = syntacticTree.debugDescription
		
		// Then
		XCTAssertEqual(output, expected)
	}
	
	func testParseDecimalFloatLiteralWithFractionExponent() throws {
		// Given
		let string = "1.2E3"
		
		let expected = """
		FloatLiteral
		└─ DecimalFloatLiteral
		   ├─ DecimalDigits
		   │  └─ DecimalDigit
		   │     └─ NonTerminal "1"
		   ├─ NonTerminal "."
		   ├─ DecimalDigits
		   │  └─ DecimalDigit
		   │     └─ NonTerminal "2"
		   └─ DecimalExponent
		      ├─ NonTerminal "E"
		      └─ DecimalDigits
		         └─ DecimalDigit
		            └─ NonTerminal "3"
		"""
		
		// When
		let syntacticTree = try parse(string: string)
		let output = syntacticTree.debugDescription
		
		// Then
		XCTAssertEqual(output, expected)
	}
	
	func testParseDecimalFloatLiteralWithFractionExponentSign() throws {
		// Given
		let string = "1.2E+3"
		
		let expected = """
		FloatLiteral
		└─ DecimalFloatLiteral
		   ├─ DecimalDigits
		   │  └─ DecimalDigit
		   │     └─ NonTerminal "1"
		   ├─ NonTerminal "."
		   ├─ DecimalDigits
		   │  └─ DecimalDigit
		   │     └─ NonTerminal "2"
		   └─ DecimalExponent
		      ├─ NonTerminal "E"
		      ├─ NonTerminal "+"
		      └─ DecimalDigits
		         └─ DecimalDigit
		            └─ NonTerminal "3"
		"""
		
		// When
		let syntacticTree = try parse(string: string)
		let output = syntacticTree.debugDescription
		
		// Then
		XCTAssertEqual(output, expected)
	}
	
	func testParseDecimalFloatLiteralStartsWithZero() throws {
		// Given
		let string = "0.1"
		
		let expected = """
		FloatLiteral
		└─ DecimalFloatLiteral
		   ├─ DecimalDigits
		   │  └─ DecimalDigit
		   │     └─ NonTerminal "0"
		   ├─ NonTerminal "."
		   └─ DecimalDigits
		      └─ DecimalDigit
		         └─ NonTerminal "1"
		"""
		
		// When
		let syntacticTree = try parse(string: string)
		let output = syntacticTree.debugDescription
		
		// Then
		XCTAssertEqual(output, expected)
	}
	
	func testParseHexadecimalFloatLiteral() throws {
		// Given
		let string = "0xFP1"
		
		let expected = """
		FloatLiteral
		└─ HexadecimalFloatLiteral
		   ├─ NonTerminal "0x"
		   ├─ HexadecimalMantissa
		   │  └─ HexadecimalDigits
		   │     └─ HexadecimalDigit
		   │        └─ NonTerminal "F"
		   └─ HexadecimalExponent
		      ├─ NonTerminal "P"
		      └─ DecimalDigits
		         └─ DecimalDigit
		            └─ NonTerminal "1"
		"""
		
		// When
		let syntacticTree = try parse(string: string)
		let output = syntacticTree.debugDescription
		
		// Then
		XCTAssertEqual(output, expected)
	}
	
	func testParseHexadecimalFloatLiteralWithUnderscore() throws {
		// Given
		let string = "0x_FP1"
		
		let expected = """
		FloatLiteral
		└─ HexadecimalFloatLiteral
		   ├─ NonTerminal "0x"
		   ├─ HexadecimalMantissa
		   │  ├─ NonTerminal "_"
		   │  └─ HexadecimalDigits
		   │     └─ HexadecimalDigit
		   │        └─ NonTerminal "F"
		   └─ HexadecimalExponent
		      ├─ NonTerminal "P"
		      └─ DecimalDigits
		         └─ DecimalDigit
		            └─ NonTerminal "1"
		"""
		
		// When
		let syntacticTree = try parse(string: string)
		let output = syntacticTree.debugDescription
		
		// Then
		XCTAssertEqual(output, expected)
	}
	
	func testParseHexadecimalFloatLiteralWithUnderscores() throws {
		// Given
		let string = "0xF_FP1"
		
		let expected = """
		FloatLiteral
		└─ HexadecimalFloatLiteral
		   ├─ NonTerminal "0x"
		   ├─ HexadecimalMantissa
		   │  └─ HexadecimalDigits
		   │     ├─ HexadecimalDigit
		   │     │  └─ NonTerminal "F"
		   │     ├─ NonTerminal "_"
		   │     └─ HexadecimalDigit
		   │        └─ NonTerminal "F"
		   └─ HexadecimalExponent
		      ├─ NonTerminal "P"
		      └─ DecimalDigits
		         └─ DecimalDigit
		            └─ NonTerminal "1"
		"""
		
		// When
		let syntacticTree = try parse(string: string)
		let output = syntacticTree.debugDescription
		
		// Then
		XCTAssertEqual(output, expected)
	}

	func testParseHexadecimalFloatLiteralWithFraction() throws {
		// Given
		let string = "0xF.FP1"
		
		let expected = """
		FloatLiteral
		└─ HexadecimalFloatLiteral
		   ├─ NonTerminal "0x"
		   ├─ HexadecimalMantissa
		   │  ├─ HexadecimalDigits
		   │  │  └─ HexadecimalDigit
		   │  │     └─ NonTerminal "F"
		   │  ├─ NonTerminal "."
		   │  └─ HexadecimalDigits
		   │     └─ HexadecimalDigit
		   │        └─ NonTerminal "F"
		   └─ HexadecimalExponent
		      ├─ NonTerminal "P"
		      └─ DecimalDigits
		         └─ DecimalDigit
		            └─ NonTerminal "1"
		"""
		
		// When
		let syntacticTree = try parse(string: string)
		let output = syntacticTree.debugDescription
		
		// Then
		XCTAssertEqual(output, expected)
	}
}
