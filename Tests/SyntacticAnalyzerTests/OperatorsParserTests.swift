//
//  OperatorsParserTests.swift
//  Tests
//
//  Created by Ace Rodstin on 1/18/23.
//  Copyright © 2023 Ace Rodstin. All rights reserved.
//

import XCTest
@testable import Ace

final class OperatorsParserTests: XCTestCase {
	
	private let parser = SyntacticAnalyzer.OperatorsParser()
	
	private func createStream(string: String) throws -> Stream<[Token]> {
		let tokens = try parseTokens(string: string)
		return Stream(tokens)
	}
	
	private func parseTokens(string: String) throws -> [Token] {
		let tokenParser = TokenParser()
		return try tokenParser.parse(string: string)
	}

	func testParseBinaryOperatorPlus() throws {
		// Given
		let string = "+"
		
		let expected = """
		BinaryOperator
		└─ AdditionGroupOperator
		   └─ NonTerminal "+"
		"""
		
		// When
		let stream = try createStream(string: string)
		let syntacticTree = try parser.parseBinaryOperator(stream: stream)
		let output = syntacticTree.debugDescription
		
		// Then
		XCTAssertEqual(output, expected)
	}
	
	func testParseBinaryOperatorMinus() throws {
		// Given
		let string = "-"
		
		let expected = """
		BinaryOperator
		└─ AdditionGroupOperator
		   └─ NonTerminal "-"
		"""
		
		// When
		let stream = try createStream(string: string)
		let syntacticTree = try parser.parseBinaryOperator(stream: stream)
		let output = syntacticTree.debugDescription
		
		// Then
		XCTAssertEqual(output, expected)
	}
	
	func testParseBinaryOperatorAsterisk() throws {
		// Given
		let string = "*"
		
		let expected = """
		BinaryOperator
		└─ MultiplicationGroupOperator
		   └─ NonTerminal "*"
		"""
		
		// When
		let stream = try createStream(string: string)
		let syntacticTree = try parser.parseBinaryOperator(stream: stream)
		let output = syntacticTree.debugDescription
		
		// Then
		XCTAssertEqual(output, expected)
	}
	
	func testParseBinaryOperatorSlash() throws {
		// Given
		let string = "/"
		
		let expected = """
		BinaryOperator
		└─ MultiplicationGroupOperator
		   └─ NonTerminal "/"
		"""
		
		// When
		let stream = try createStream(string: string)
		let syntacticTree = try parser.parseBinaryOperator(stream: stream)
		let output = syntacticTree.debugDescription
		
		// Then
		XCTAssertEqual(output, expected)
	}
	
	func testParseUnaryOperatorPlus() throws {
		// Given
		let string = "+"
		
		let expected = """
		UnaryOperator
		└─ NonTerminal "+"
		"""
		
		// When
		let stream = try createStream(string: string)
		let syntacticTree = try parser.parseUnaryOperator(stream: stream)
		let output = syntacticTree.debugDescription
		
		// Then
		XCTAssertEqual(output, expected)
	}
	
	func testParseUnaryOperatorMinus() throws {
		// Given
		let string = "-"
		
		let expected = """
		UnaryOperator
		└─ NonTerminal "-"
		"""
		
		// When
		let stream = try createStream(string: string)
		let syntacticTree = try parser.parseUnaryOperator(stream: stream)
		let output = syntacticTree.debugDescription
		
		// Then
		XCTAssertEqual(output, expected)
	}
}
