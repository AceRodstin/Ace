//
//  IdentifiersParserTests.swift
//  Tests
//
//  Created by Ace Rodstin on 1/18/23.
//  Copyright © 2023 Ace Rodstin. All rights reserved.
//

import XCTest
@testable import Ace

final class IdentifiersParserTests: XCTestCase {
	
	private let parser = SyntacticAnalyzer.IdentifiersParser()
	
	private func createStream(string: String) throws -> Stream<[Token]> {
		let tokens = try parseTokens(string: string)
		return Stream(tokens)
	}
	
	private func parseTokens(string: String) throws -> [Token] {
		let tokenParser = TokenParser()
		return try tokenParser.parse(string: string)
	}
	
	func testParseIdentifierUppercase() throws {
		// Given
		let string = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
		
		let expected = """
		Identifier
		├─ Letter
		│  └─ UnicodeLetter
		│     └─ NonTerminal "A"
		├─ Letter
		│  └─ UnicodeLetter
		│     └─ NonTerminal "B"
		├─ Letter
		│  └─ UnicodeLetter
		│     └─ NonTerminal "C"
		├─ Letter
		│  └─ UnicodeLetter
		│     └─ NonTerminal "D"
		├─ Letter
		│  └─ UnicodeLetter
		│     └─ NonTerminal "E"
		├─ Letter
		│  └─ UnicodeLetter
		│     └─ NonTerminal "F"
		├─ Letter
		│  └─ UnicodeLetter
		│     └─ NonTerminal "G"
		├─ Letter
		│  └─ UnicodeLetter
		│     └─ NonTerminal "H"
		├─ Letter
		│  └─ UnicodeLetter
		│     └─ NonTerminal "I"
		├─ Letter
		│  └─ UnicodeLetter
		│     └─ NonTerminal "J"
		├─ Letter
		│  └─ UnicodeLetter
		│     └─ NonTerminal "K"
		├─ Letter
		│  └─ UnicodeLetter
		│     └─ NonTerminal "L"
		├─ Letter
		│  └─ UnicodeLetter
		│     └─ NonTerminal "M"
		├─ Letter
		│  └─ UnicodeLetter
		│     └─ NonTerminal "N"
		├─ Letter
		│  └─ UnicodeLetter
		│     └─ NonTerminal "O"
		├─ Letter
		│  └─ UnicodeLetter
		│     └─ NonTerminal "P"
		├─ Letter
		│  └─ UnicodeLetter
		│     └─ NonTerminal "Q"
		├─ Letter
		│  └─ UnicodeLetter
		│     └─ NonTerminal "R"
		├─ Letter
		│  └─ UnicodeLetter
		│     └─ NonTerminal "S"
		├─ Letter
		│  └─ UnicodeLetter
		│     └─ NonTerminal "T"
		├─ Letter
		│  └─ UnicodeLetter
		│     └─ NonTerminal "U"
		├─ Letter
		│  └─ UnicodeLetter
		│     └─ NonTerminal "V"
		├─ Letter
		│  └─ UnicodeLetter
		│     └─ NonTerminal "W"
		├─ Letter
		│  └─ UnicodeLetter
		│     └─ NonTerminal "X"
		├─ Letter
		│  └─ UnicodeLetter
		│     └─ NonTerminal "Y"
		└─ Letter
		   └─ UnicodeLetter
		      └─ NonTerminal "Z"
		"""
		
		// When
		let stream = try createStream(string: string)
		let syntacticTree = try parser.parseIdentifier(stream: stream)
		let output = syntacticTree.debugDescription
		
		// Then
		XCTAssertEqual(output, expected)
	}
	
	func testParseIdentifierLowercase() throws {
		// Given
		let string = "abcdefghijklmnopqrstuvwxyz"
		
		let expected = """
		Identifier
		├─ Letter
		│  └─ UnicodeLetter
		│     └─ NonTerminal "a"
		├─ Letter
		│  └─ UnicodeLetter
		│     └─ NonTerminal "b"
		├─ Letter
		│  └─ UnicodeLetter
		│     └─ NonTerminal "c"
		├─ Letter
		│  └─ UnicodeLetter
		│     └─ NonTerminal "d"
		├─ Letter
		│  └─ UnicodeLetter
		│     └─ NonTerminal "e"
		├─ Letter
		│  └─ UnicodeLetter
		│     └─ NonTerminal "f"
		├─ Letter
		│  └─ UnicodeLetter
		│     └─ NonTerminal "g"
		├─ Letter
		│  └─ UnicodeLetter
		│     └─ NonTerminal "h"
		├─ Letter
		│  └─ UnicodeLetter
		│     └─ NonTerminal "i"
		├─ Letter
		│  └─ UnicodeLetter
		│     └─ NonTerminal "j"
		├─ Letter
		│  └─ UnicodeLetter
		│     └─ NonTerminal "k"
		├─ Letter
		│  └─ UnicodeLetter
		│     └─ NonTerminal "l"
		├─ Letter
		│  └─ UnicodeLetter
		│     └─ NonTerminal "m"
		├─ Letter
		│  └─ UnicodeLetter
		│     └─ NonTerminal "n"
		├─ Letter
		│  └─ UnicodeLetter
		│     └─ NonTerminal "o"
		├─ Letter
		│  └─ UnicodeLetter
		│     └─ NonTerminal "p"
		├─ Letter
		│  └─ UnicodeLetter
		│     └─ NonTerminal "q"
		├─ Letter
		│  └─ UnicodeLetter
		│     └─ NonTerminal "r"
		├─ Letter
		│  └─ UnicodeLetter
		│     └─ NonTerminal "s"
		├─ Letter
		│  └─ UnicodeLetter
		│     └─ NonTerminal "t"
		├─ Letter
		│  └─ UnicodeLetter
		│     └─ NonTerminal "u"
		├─ Letter
		│  └─ UnicodeLetter
		│     └─ NonTerminal "v"
		├─ Letter
		│  └─ UnicodeLetter
		│     └─ NonTerminal "w"
		├─ Letter
		│  └─ UnicodeLetter
		│     └─ NonTerminal "x"
		├─ Letter
		│  └─ UnicodeLetter
		│     └─ NonTerminal "y"
		└─ Letter
		   └─ UnicodeLetter
		      └─ NonTerminal "z"
		"""
		
		// When
		let stream = try createStream(string: string)
		let syntacticTree = try parser.parseIdentifier(stream: stream)
		let output = syntacticTree.debugDescription
		
		// Then
		XCTAssertEqual(output, expected)
	}
	
	func testParseIdentifierHasUnderscore() throws {
		// Given
		let string = "a_b"
		
		let expected = """
		Identifier
		├─ Letter
		│  └─ UnicodeLetter
		│     └─ NonTerminal "a"
		├─ Letter
		│  └─ NonTerminal "_"
		└─ Letter
		   └─ UnicodeLetter
		      └─ NonTerminal "b"
		"""
		
		// When
		let stream = try createStream(string: string)
		let syntacticTree = try parser.parseIdentifier(stream: stream)
		let output = syntacticTree.debugDescription
		
		// Then
		XCTAssertEqual(output, expected)
	}
	
	func testParseIdentifierStartsWithUnderscore() throws {
		// Given
		let string = "_a"
		
		let expected = """
		Identifier
		├─ Letter
		│  └─ NonTerminal "_"
		└─ Letter
		   └─ UnicodeLetter
		      └─ NonTerminal "a"
		"""
		
		// When
		let stream = try createStream(string: string)
		let syntacticTree = try parser.parseIdentifier(stream: stream)
		let output = syntacticTree.debugDescription
		
		// Then
		XCTAssertEqual(output, expected)
	}
	
	func testParseIdentifierEndsWithUnderscore() throws {
		// Given
		let string = "a_"
		
		let expected = """
		Identifier
		├─ Letter
		│  └─ UnicodeLetter
		│     └─ NonTerminal "a"
		└─ Letter
		   └─ NonTerminal "_"
		"""
		
		// When
		let stream = try createStream(string: string)
		let syntacticTree = try parser.parseIdentifier(stream: stream)
		let output = syntacticTree.debugDescription
		
		// Then
		XCTAssertEqual(output, expected)
	}
	
	func testParseIdentifierDigits() throws {
		// Given
		let string = "_1234567890"
		
		let expected = """
		Identifier
		├─ Letter
		│  └─ NonTerminal "_"
		├─ UnicodeDigit
		│  └─ NonTerminal "1"
		├─ UnicodeDigit
		│  └─ NonTerminal "2"
		├─ UnicodeDigit
		│  └─ NonTerminal "3"
		├─ UnicodeDigit
		│  └─ NonTerminal "4"
		├─ UnicodeDigit
		│  └─ NonTerminal "5"
		├─ UnicodeDigit
		│  └─ NonTerminal "6"
		├─ UnicodeDigit
		│  └─ NonTerminal "7"
		├─ UnicodeDigit
		│  └─ NonTerminal "8"
		├─ UnicodeDigit
		│  └─ NonTerminal "9"
		└─ UnicodeDigit
		   └─ NonTerminal "0"
		"""
		
		// When
		let stream = try createStream(string: string)
		let syntacticTree = try parser.parseIdentifier(stream: stream)
		let output = syntacticTree.debugDescription
		
		// Then
		XCTAssertEqual(output, expected)
	}
	
	func testParseIdentifierList() throws {
		// Given
		let string = "x, y"
		
		let expected = """
		IdentifierList
		├─ Identifier
		│  └─ Letter
		│     └─ UnicodeLetter
		│        └─ NonTerminal "x"
		├─ NonTerminal ","
		└─ Identifier
		   └─ Letter
		      └─ UnicodeLetter
		         └─ NonTerminal "y"
		"""
		
		// When
		let stream = try createStream(string: string)
		let syntacticTree = try parser.parseIdentifierList(stream: stream)
		let output = syntacticTree.debugDescription
		
		// Then
		XCTAssertEqual(output, expected)
	}
}

