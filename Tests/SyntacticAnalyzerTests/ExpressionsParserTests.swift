//
//  ExpressionsParserTests.swift
//  Tests
//
//  Created by Ace Rodstin on 1/18/23.
//  Copyright © 2023 Ace Rodstin. All rights reserved.
//

import XCTest
@testable import Ace

final class ExpressionsParserTests: XCTestCase {
	
	private let parser = SyntacticAnalyzer.ExpressionsParser()
	
	private func parse(string: String) throws -> SyntacticNode {
		let tokenParser = TokenParser()
		let tokens = try tokenParser.parse(string: string)
		
		let stream = Stream(tokens)
		return try parser.parse(stream: stream)
	}

	func testParseUnaryExpression() throws {
		// Given
		let string = "1"
		
		let expected = """
		Expression
		└─ UnaryExpression
		   └─ PrimaryExpression
		      └─ Operand
		         └─ Literal
		            └─ BasicLiteral
		               └─ IntegerLiteral
		                  └─ DecimalLiteral
		                     └─ DecimalDigit
		                        └─ NonTerminal "1"
		"""
		
		// When
		let syntacticTree = try parse(string: string)
		let output = syntacticTree.debugDescription
		
		// Then
		XCTAssertEqual(output, expected)
	}
	
	func testParseUnaryExpressionWithUnaryOperator() throws {
		// Given
		let string = "-1"
		
		let expected = """
		Expression
		└─ UnaryExpression
		   ├─ UnaryOperator
		   │  └─ NonTerminal "-"
		   └─ PrimaryExpression
		      └─ Operand
		         └─ Literal
		            └─ BasicLiteral
		               └─ IntegerLiteral
		                  └─ DecimalLiteral
		                     └─ DecimalDigit
		                        └─ NonTerminal "1"
		"""
		
		// When
		let syntacticTree = try parse(string: string)
		let output = syntacticTree.debugDescription
		
		// Then
		XCTAssertEqual(output, expected)
	}
	
	func testParseExpressionBinaryOperatorExpression() throws {
		// Given
		let string = "1 + 2"
		
		let expected = """
		Expression
		├─ Expression
		│  └─ UnaryExpression
		│     └─ PrimaryExpression
		│        └─ Operand
		│           └─ Literal
		│              └─ BasicLiteral
		│                 └─ IntegerLiteral
		│                    └─ DecimalLiteral
		│                       └─ DecimalDigit
		│                          └─ NonTerminal "1"
		├─ BinaryOperator
		│  └─ AdditionGroupOperator
		│     └─ NonTerminal "+"
		└─ Expression
		   └─ UnaryExpression
		      └─ PrimaryExpression
		         └─ Operand
		            └─ Literal
		               └─ BasicLiteral
		                  └─ IntegerLiteral
		                     └─ DecimalLiteral
		                        └─ DecimalDigit
		                           └─ NonTerminal "2"
		"""
		
		// When
		let syntacticTree = try parse(string: string)
		let output = syntacticTree.debugDescription
		
		// Then
		XCTAssertEqual(output, expected)
	}
	
	func testParseExpressionOperatorPrecedence_1() throws {
		// Given
		let string = "1 + 2 * 3"
		
		let expected = """
		Expression
		├─ Expression
		│  └─ UnaryExpression
		│     └─ PrimaryExpression
		│        └─ Operand
		│           └─ Literal
		│              └─ BasicLiteral
		│                 └─ IntegerLiteral
		│                    └─ DecimalLiteral
		│                       └─ DecimalDigit
		│                          └─ NonTerminal "1"
		├─ BinaryOperator
		│  └─ AdditionGroupOperator
		│     └─ NonTerminal "+"
		└─ Expression
		   ├─ Expression
		   │  └─ UnaryExpression
		   │     └─ PrimaryExpression
		   │        └─ Operand
		   │           └─ Literal
		   │              └─ BasicLiteral
		   │                 └─ IntegerLiteral
		   │                    └─ DecimalLiteral
		   │                       └─ DecimalDigit
		   │                          └─ NonTerminal "2"
		   ├─ BinaryOperator
		   │  └─ MultiplicationGroupOperator
		   │     └─ NonTerminal "*"
		   └─ Expression
		      └─ UnaryExpression
		         └─ PrimaryExpression
		            └─ Operand
		               └─ Literal
		                  └─ BasicLiteral
		                     └─ IntegerLiteral
		                        └─ DecimalLiteral
		                           └─ DecimalDigit
		                              └─ NonTerminal "3"
		"""
		
		// When
		let syntacticTree = try parse(string: string)
		let output = syntacticTree.debugDescription
		
		// Then
		XCTAssertEqual(output, expected)
	}
	
	func testParseExpressionOperatorPrecedence_2() throws {
		// Given
		let string = "1 * 2 + 3"
		
		let expected = """
		Expression
		├─ Expression
		│  ├─ Expression
		│  │  └─ UnaryExpression
		│  │     └─ PrimaryExpression
		│  │        └─ Operand
		│  │           └─ Literal
		│  │              └─ BasicLiteral
		│  │                 └─ IntegerLiteral
		│  │                    └─ DecimalLiteral
		│  │                       └─ DecimalDigit
		│  │                          └─ NonTerminal "1"
		│  ├─ BinaryOperator
		│  │  └─ MultiplicationGroupOperator
		│  │     └─ NonTerminal "*"
		│  └─ Expression
		│     └─ UnaryExpression
		│        └─ PrimaryExpression
		│           └─ Operand
		│              └─ Literal
		│                 └─ BasicLiteral
		│                    └─ IntegerLiteral
		│                       └─ DecimalLiteral
		│                          └─ DecimalDigit
		│                             └─ NonTerminal "2"
		├─ BinaryOperator
		│  └─ AdditionGroupOperator
		│     └─ NonTerminal "+"
		└─ Expression
		   └─ UnaryExpression
		      └─ PrimaryExpression
		         └─ Operand
		            └─ Literal
		               └─ BasicLiteral
		                  └─ IntegerLiteral
		                     └─ DecimalLiteral
		                        └─ DecimalDigit
		                           └─ NonTerminal "3"
		"""
		
		// When
		let syntacticTree = try parse(string: string)
		let output = syntacticTree.debugDescription
		
		// Then
		XCTAssertEqual(output, expected)
	}
	
	func testParseExpressionOperatorPrecedence_3() throws {
		// Given
		let string = "1 * 2 + 3 * 4"
		
		let expected = """
		Expression
		├─ Expression
		│  ├─ Expression
		│  │  └─ UnaryExpression
		│  │     └─ PrimaryExpression
		│  │        └─ Operand
		│  │           └─ Literal
		│  │              └─ BasicLiteral
		│  │                 └─ IntegerLiteral
		│  │                    └─ DecimalLiteral
		│  │                       └─ DecimalDigit
		│  │                          └─ NonTerminal "1"
		│  ├─ BinaryOperator
		│  │  └─ MultiplicationGroupOperator
		│  │     └─ NonTerminal "*"
		│  └─ Expression
		│     └─ UnaryExpression
		│        └─ PrimaryExpression
		│           └─ Operand
		│              └─ Literal
		│                 └─ BasicLiteral
		│                    └─ IntegerLiteral
		│                       └─ DecimalLiteral
		│                          └─ DecimalDigit
		│                             └─ NonTerminal "2"
		├─ BinaryOperator
		│  └─ AdditionGroupOperator
		│     └─ NonTerminal "+"
		└─ Expression
		   ├─ Expression
		   │  └─ UnaryExpression
		   │     └─ PrimaryExpression
		   │        └─ Operand
		   │           └─ Literal
		   │              └─ BasicLiteral
		   │                 └─ IntegerLiteral
		   │                    └─ DecimalLiteral
		   │                       └─ DecimalDigit
		   │                          └─ NonTerminal "3"
		   ├─ BinaryOperator
		   │  └─ MultiplicationGroupOperator
		   │     └─ NonTerminal "*"
		   └─ Expression
		      └─ UnaryExpression
		         └─ PrimaryExpression
		            └─ Operand
		               └─ Literal
		                  └─ BasicLiteral
		                     └─ IntegerLiteral
		                        └─ DecimalLiteral
		                           └─ DecimalDigit
		                              └─ NonTerminal "4"
		"""
		
		// When
		let syntacticTree = try parse(string: string)
		let output = syntacticTree.debugDescription
		
		// Then
		XCTAssertEqual(output, expected)
	}
	
	func testParseExpressionParenthesized_1() throws {
		// Given
		let string = "(1)"
		
		let expected = """
		Expression
		└─ UnaryExpression
		   └─ PrimaryExpression
		      └─ Operand
		         ├─ NonTerminal "("
		         ├─ Expression
		         │  └─ UnaryExpression
		         │     └─ PrimaryExpression
		         │        └─ Operand
		         │           └─ Literal
		         │              └─ BasicLiteral
		         │                 └─ IntegerLiteral
		         │                    └─ DecimalLiteral
		         │                       └─ DecimalDigit
		         │                          └─ NonTerminal "1"
		         └─ NonTerminal ")"
		"""
		
		// When
		let syntacticTree = try parse(string: string)
		let output = syntacticTree.debugDescription
		
		// Then
		XCTAssertEqual(output, expected)
	}
	
	func testParseExpressionParenthesized_2() throws {
		// Given
		let string = "1 * (2 + 3)"
		
		let expected = """
		Expression
		├─ Expression
		│  └─ UnaryExpression
		│     └─ PrimaryExpression
		│        └─ Operand
		│           └─ Literal
		│              └─ BasicLiteral
		│                 └─ IntegerLiteral
		│                    └─ DecimalLiteral
		│                       └─ DecimalDigit
		│                          └─ NonTerminal "1"
		├─ BinaryOperator
		│  └─ MultiplicationGroupOperator
		│     └─ NonTerminal "*"
		└─ Expression
		   └─ UnaryExpression
		      └─ PrimaryExpression
		         └─ Operand
		            ├─ NonTerminal "("
		            ├─ Expression
		            │  ├─ Expression
		            │  │  └─ UnaryExpression
		            │  │     └─ PrimaryExpression
		            │  │        └─ Operand
		            │  │           └─ Literal
		            │  │              └─ BasicLiteral
		            │  │                 └─ IntegerLiteral
		            │  │                    └─ DecimalLiteral
		            │  │                       └─ DecimalDigit
		            │  │                          └─ NonTerminal "2"
		            │  ├─ BinaryOperator
		            │  │  └─ AdditionGroupOperator
		            │  │     └─ NonTerminal "+"
		            │  └─ Expression
		            │     └─ UnaryExpression
		            │        └─ PrimaryExpression
		            │           └─ Operand
		            │              └─ Literal
		            │                 └─ BasicLiteral
		            │                    └─ IntegerLiteral
		            │                       └─ DecimalLiteral
		            │                          └─ DecimalDigit
		            │                             └─ NonTerminal "3"
		            └─ NonTerminal ")"
		"""
		
		// When
		let syntacticTree = try parse(string: string)
		let output = syntacticTree.debugDescription
		
		// Then
		XCTAssertEqual(output, expected)
	}
	
	func testParseExpressionParenthesized_3() throws {
		// Given
		let string = "1 * (2 + 3) * (4 + 5)"
		
		let expected = """
		Expression
		├─ Expression
		│  ├─ Expression
		│  │  └─ UnaryExpression
		│  │     └─ PrimaryExpression
		│  │        └─ Operand
		│  │           └─ Literal
		│  │              └─ BasicLiteral
		│  │                 └─ IntegerLiteral
		│  │                    └─ DecimalLiteral
		│  │                       └─ DecimalDigit
		│  │                          └─ NonTerminal "1"
		│  ├─ BinaryOperator
		│  │  └─ MultiplicationGroupOperator
		│  │     └─ NonTerminal "*"
		│  └─ Expression
		│     └─ UnaryExpression
		│        └─ PrimaryExpression
		│           └─ Operand
		│              ├─ NonTerminal "("
		│              ├─ Expression
		│              │  ├─ Expression
		│              │  │  └─ UnaryExpression
		│              │  │     └─ PrimaryExpression
		│              │  │        └─ Operand
		│              │  │           └─ Literal
		│              │  │              └─ BasicLiteral
		│              │  │                 └─ IntegerLiteral
		│              │  │                    └─ DecimalLiteral
		│              │  │                       └─ DecimalDigit
		│              │  │                          └─ NonTerminal "2"
		│              │  ├─ BinaryOperator
		│              │  │  └─ AdditionGroupOperator
		│              │  │     └─ NonTerminal "+"
		│              │  └─ Expression
		│              │     └─ UnaryExpression
		│              │        └─ PrimaryExpression
		│              │           └─ Operand
		│              │              └─ Literal
		│              │                 └─ BasicLiteral
		│              │                    └─ IntegerLiteral
		│              │                       └─ DecimalLiteral
		│              │                          └─ DecimalDigit
		│              │                             └─ NonTerminal "3"
		│              └─ NonTerminal ")"
		├─ BinaryOperator
		│  └─ MultiplicationGroupOperator
		│     └─ NonTerminal "*"
		└─ Expression
		   └─ UnaryExpression
		      └─ PrimaryExpression
		         └─ Operand
		            ├─ NonTerminal "("
		            ├─ Expression
		            │  ├─ Expression
		            │  │  └─ UnaryExpression
		            │  │     └─ PrimaryExpression
		            │  │        └─ Operand
		            │  │           └─ Literal
		            │  │              └─ BasicLiteral
		            │  │                 └─ IntegerLiteral
		            │  │                    └─ DecimalLiteral
		            │  │                       └─ DecimalDigit
		            │  │                          └─ NonTerminal "4"
		            │  ├─ BinaryOperator
		            │  │  └─ AdditionGroupOperator
		            │  │     └─ NonTerminal "+"
		            │  └─ Expression
		            │     └─ UnaryExpression
		            │        └─ PrimaryExpression
		            │           └─ Operand
		            │              └─ Literal
		            │                 └─ BasicLiteral
		            │                    └─ IntegerLiteral
		            │                       └─ DecimalLiteral
		            │                          └─ DecimalDigit
		            │                             └─ NonTerminal "5"
		            └─ NonTerminal ")"
		"""
		
		// When
		let syntacticTree = try parse(string: string)
		let output = syntacticTree.debugDescription
		
		// Then
		XCTAssertEqual(output, expected)
	}
	
	func testParseExpressionParenthesized_4() throws {
		// Given
		let string = "1 * (2 + 3) + 4 * 5"
		
		let expected = """
		Expression
		├─ Expression
		│  ├─ Expression
		│  │  └─ UnaryExpression
		│  │     └─ PrimaryExpression
		│  │        └─ Operand
		│  │           └─ Literal
		│  │              └─ BasicLiteral
		│  │                 └─ IntegerLiteral
		│  │                    └─ DecimalLiteral
		│  │                       └─ DecimalDigit
		│  │                          └─ NonTerminal "1"
		│  ├─ BinaryOperator
		│  │  └─ MultiplicationGroupOperator
		│  │     └─ NonTerminal "*"
		│  └─ Expression
		│     └─ UnaryExpression
		│        └─ PrimaryExpression
		│           └─ Operand
		│              ├─ NonTerminal "("
		│              ├─ Expression
		│              │  ├─ Expression
		│              │  │  └─ UnaryExpression
		│              │  │     └─ PrimaryExpression
		│              │  │        └─ Operand
		│              │  │           └─ Literal
		│              │  │              └─ BasicLiteral
		│              │  │                 └─ IntegerLiteral
		│              │  │                    └─ DecimalLiteral
		│              │  │                       └─ DecimalDigit
		│              │  │                          └─ NonTerminal "2"
		│              │  ├─ BinaryOperator
		│              │  │  └─ AdditionGroupOperator
		│              │  │     └─ NonTerminal "+"
		│              │  └─ Expression
		│              │     └─ UnaryExpression
		│              │        └─ PrimaryExpression
		│              │           └─ Operand
		│              │              └─ Literal
		│              │                 └─ BasicLiteral
		│              │                    └─ IntegerLiteral
		│              │                       └─ DecimalLiteral
		│              │                          └─ DecimalDigit
		│              │                             └─ NonTerminal "3"
		│              └─ NonTerminal ")"
		├─ BinaryOperator
		│  └─ AdditionGroupOperator
		│     └─ NonTerminal "+"
		└─ Expression
		   ├─ Expression
		   │  └─ UnaryExpression
		   │     └─ PrimaryExpression
		   │        └─ Operand
		   │           └─ Literal
		   │              └─ BasicLiteral
		   │                 └─ IntegerLiteral
		   │                    └─ DecimalLiteral
		   │                       └─ DecimalDigit
		   │                          └─ NonTerminal "4"
		   ├─ BinaryOperator
		   │  └─ MultiplicationGroupOperator
		   │     └─ NonTerminal "*"
		   └─ Expression
		      └─ UnaryExpression
		         └─ PrimaryExpression
		            └─ Operand
		               └─ Literal
		                  └─ BasicLiteral
		                     └─ IntegerLiteral
		                        └─ DecimalLiteral
		                           └─ DecimalDigit
		                              └─ NonTerminal "5"
		"""
		
		// When
		let syntacticTree = try parse(string: string)
		let output = syntacticTree.debugDescription
		
		// Then
		XCTAssertEqual(output, expected)
	}
	
	func testParseIdentifier() throws {
		// Given
		let string = "value"
		
		let expected = """
		Expression
		└─ UnaryExpression
		   └─ PrimaryExpression
		      └─ Operand
		         └─ OperandName
		            └─ Identifier
		               ├─ Letter
		               │  └─ UnicodeLetter
		               │     └─ NonTerminal "v"
		               ├─ Letter
		               │  └─ UnicodeLetter
		               │     └─ NonTerminal "a"
		               ├─ Letter
		               │  └─ UnicodeLetter
		               │     └─ NonTerminal "l"
		               ├─ Letter
		               │  └─ UnicodeLetter
		               │     └─ NonTerminal "u"
		               └─ Letter
		                  └─ UnicodeLetter
		                     └─ NonTerminal "e"
		"""
		
		// When
		let syntacticTree = try parse(string: string)
		let output = syntacticTree.debugDescription
		
		// Then
		XCTAssertEqual(output, expected)
	}
}
