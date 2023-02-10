//
//  LiteralsParserTests.swift
//  Tests
//
//  Created by Ace Rodstin on 1/18/23.
//  Copyright © 2023 Ace Rodstin. All rights reserved.
//

import XCTest
@testable import Ace

final class LiteralsParserTests: XCTestCase {
	
	private let parser = SyntacticAnalyzer.LiteralsParser()
	
	private func parse(string: String) throws -> SyntacticNode {
		let tokenParser = TokenParser()
		let tokens = try tokenParser.parse(string: string)
		
		let stream = Stream(tokens)
		return try parser.parse(stream: stream)
	}

	func testParseIntegerLiteral() throws {
		// Given
		let string = "12345"
		
		let expected = """
		Literal
		└─ BasicLiteral
		   └─ IntegerLiteral
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
		            └─ DecimalDigit
		               └─ NonTerminal "5"
		"""
		
		// When
		let syntacticTree = try parse(string: string)
		let output = syntacticTree.debugDescription
		
		// Then
		XCTAssertEqual(output, expected)
	}
	
	func testParseFloatLiteral() throws {
		// Given
		let string = "0.5"
		
		let expected = """
		Literal
		└─ BasicLiteral
		   └─ FloatLiteral
		      └─ DecimalFloatLiteral
		         ├─ DecimalDigits
		         │  └─ DecimalDigit
		         │     └─ NonTerminal "0"
		         ├─ NonTerminal "."
		         └─ DecimalDigits
		            └─ DecimalDigit
		               └─ NonTerminal "5"
		"""
		
		// When
		let syntacticTree = try parse(string: string)
		let output = syntacticTree.debugDescription
		
		// Then
		XCTAssertEqual(output, expected)
	}
}
