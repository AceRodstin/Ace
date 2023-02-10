//
//  CharactersParserTests.swift
//  SyntacticAnalyzer
//
//  Created by Ace Rodstin on 1/17/23.
//  Copyright © 2023 Ace Rodstin. All rights reserved.
//

import XCTest
@testable import Ace

final class CharactersParserTests: XCTestCase {
	
	private let parser = SyntacticAnalyzer.CharactersParser()

	func testParseLetter() throws {
		// Given
		let character: Character = "A"
		let expected = """
		Letter
		└─ UnicodeLetter
		   └─ NonTerminal "A"
		"""
		
		// When
		let tree = try parser.parseLetter(character: character)
		let output = tree.debugDescription
		
		// Then
		XCTAssertEqual(output, expected)
	}
	
	func testParseLetterUnderscore() throws {
		// Given
		let character: Character = "_"
		let expected = """
		Letter
		└─ NonTerminal "_"
		"""
		
		// When
		let tree = try parser.parseLetter(character: character)
		let output = tree.debugDescription
		
		// Then
		XCTAssertEqual(output, expected)
	}
	
	func testParseInvalidLetter() {
		// Given
		let character: Character = "\n"
		
		// Then
		XCTAssertThrowsError(try parser.parseLetter(character: character))
	}
	
	func testParseDecimalDigit() throws {
		// Given
		let character: Character = "1"
		let expected = """
		DecimalDigit
		└─ NonTerminal "1"
		"""
		
		// When
		let tree = try parser.parseDecimalDigit(character: character)
		let output = tree.debugDescription
		
		// Then
		XCTAssertEqual(output, expected)
	}
	
	func testParseInvalidDecimalDigit() {
		// Given
		let character: Character = "Z"
		
		// Then
		XCTAssertThrowsError(try parser.parseDecimalDigit(character: character))
	}
	
	func testParseBinaryDigit() throws {
		// Given
		let character: Character = "1"
		let expected = """
		BinaryDigit
		└─ NonTerminal "1"
		"""
		
		// When
		let tree = try parser.parseBinaryDigit(character: character)
		let output = tree.debugDescription
		
		// Then
		XCTAssertEqual(output, expected)
	}
	
	func testParseInvalidBinaryDigit() {
		// Given
		let character: Character = "Z"
		
		// Then
		XCTAssertThrowsError(try parser.parseBinaryDigit(character: character))
	}
	
	func testParseOctalDigit() throws {
		// Given
		let character: Character = "7"
		let expected = """
		OctalDigit
		└─ NonTerminal "7"
		"""
		
		// When
		let tree = try parser.parseOctalDigit(character: character)
		let output = tree.debugDescription
		
		// Then
		XCTAssertEqual(output, expected)
	}
	
	func testParseInvalidOctalDigit() {
		// Given
		let character: Character = "Z"
		
		// Then
		XCTAssertThrowsError(try parser.parseOctalDigit(character: character))
	}
	
	func testParseHexadecimalDigit() throws {
		// Given
		let character: Character = "A"
		let expected = """
		HexadecimalDigit
		└─ NonTerminal "A"
		"""
		
		// When
		let tree = try parser.parseHexadecimalDigit(character: character)
		let output = tree.debugDescription
		
		// Then
		XCTAssertEqual(output, expected)
	}
	
	func testParseInvalidHexadecimalDigit() {
		// Given
		let character: Character = "Z"
		
		// Then
		XCTAssertThrowsError(try parser.parseHexadecimalDigit(character: character))
	}
	
	func testParseUnicodeLetter() throws {
		// Given
		let character: Character = "A"
		let expected = """
		UnicodeLetter
		└─ NonTerminal "A"
		"""
		
		// When
		let tree = try parser.parseUnicodeLetter(character: character)
		let output = tree.debugDescription
		
		// Then
		XCTAssertEqual(output, expected)
	}
	
	func testParseUnicodeDigit() throws {
		// Given
		let character: Character = "1"
		let expected = """
		UnicodeDigit
		└─ NonTerminal "1"
		"""
		
		// When
		let tree = try parser.parseUnicodeDigit(character: character)
		let output = tree.debugDescription
		
		// Then
		XCTAssertEqual(output, expected)
	}
}
