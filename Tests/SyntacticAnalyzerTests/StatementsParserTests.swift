//
//  StatementsParserTests.swift
//  Tests
//
//  Created by Ace Rodstin on 1/4/23.
//  Copyright © 2023 Ace Rodstin. All rights reserved.
//

import XCTest
@testable import Ace

final class StatementsParserTests: XCTestCase {
	
	private let parser = SyntacticAnalyzer.StatementsParser()
	
	private func parse(string: String) throws -> SyntacticNode {
		let tokenParser = TokenParser()
		let tokens = try tokenParser.parse(string: string)
		
		let stream = Stream(tokens)
		return try parser.parse(stream: stream)
	}

	func testParseDeclaration() throws {
		// Given
		let string = "var value = 1"
		
		let expected = """
		Statement
		└─ Declaration
		   └─ VariableDeclaration
		      ├─ NonTerminal "var"
		      └─ VariableSpecification
		         ├─ IdentifierList
		         │  └─ Identifier
		         │     ├─ Letter
		         │     │  └─ UnicodeLetter
		         │     │     └─ NonTerminal "v"
		         │     ├─ Letter
		         │     │  └─ UnicodeLetter
		         │     │     └─ NonTerminal "a"
		         │     ├─ Letter
		         │     │  └─ UnicodeLetter
		         │     │     └─ NonTerminal "l"
		         │     ├─ Letter
		         │     │  └─ UnicodeLetter
		         │     │     └─ NonTerminal "u"
		         │     └─ Letter
		         │        └─ UnicodeLetter
		         │           └─ NonTerminal "e"
		         ├─ NonTerminal "="
		         └─ Expression
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
	
	func testParseAssignment() throws {
		// Given
		let string = "value = 1"
		
		let expected = """
		Statement
		└─ SimpleStatement
		   └─ AssignmentStatement
		      ├─ Identifier
		      │  ├─ Letter
		      │  │  └─ UnicodeLetter
		      │  │     └─ NonTerminal "v"
		      │  ├─ Letter
		      │  │  └─ UnicodeLetter
		      │  │     └─ NonTerminal "a"
		      │  ├─ Letter
		      │  │  └─ UnicodeLetter
		      │  │     └─ NonTerminal "l"
		      │  ├─ Letter
		      │  │  └─ UnicodeLetter
		      │  │     └─ NonTerminal "u"
		      │  └─ Letter
		      │     └─ UnicodeLetter
		      │        └─ NonTerminal "e"
		      ├─ AssignOperator
		      │  └─ NonTerminal "="
		      └─ Expression
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
}
