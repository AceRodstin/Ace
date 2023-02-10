//
//  DeclarationsParserTests.swift
//  Tests
//
//  Created by Ace Rodstin on 1/18/23.
//  Copyright © 2023 Ace Rodstin. All rights reserved.
//

import XCTest
@testable import Ace

final class DeclarationsParserTests: XCTestCase {

	private let parser = SyntacticAnalyzer.DeclarationsParser()
	
	private func parse(string: String) throws -> SyntacticNode {
		let tokenParser = TokenParser()
		let tokens = try tokenParser.parse(string: string)
		
		let stream = Stream(tokens)
		return try parser.parse(stream: stream)
	}

	func testParseConstantDeclaration() throws {
		// Given
		let string = "val value = 1"
		
		let expected = """
		Declaration
		└─ ConstantDeclaration
		   ├─ NonTerminal "val"
		   └─ ConstantSpecification
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
	
	func testParseVariableDeclaration() throws {
		// Given
		let string = "var value = 1"
		
		let expected = """
		Declaration
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
	
	func testParseDeclarationWithTypeAnnotation() throws {
		// Given
		let string = "val value: Integer"
		
		let expected = """
		Declaration
		└─ ConstantDeclaration
		   ├─ NonTerminal "val"
		   └─ ConstantSpecification
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
		      ├─ NonTerminal ":"
		      └─ Type
		         └─ TypeName
		            └─ Identifier
		               ├─ Letter
		               │  └─ UnicodeLetter
		               │     └─ NonTerminal "I"
		               ├─ Letter
		               │  └─ UnicodeLetter
		               │     └─ NonTerminal "n"
		               ├─ Letter
		               │  └─ UnicodeLetter
		               │     └─ NonTerminal "t"
		               ├─ Letter
		               │  └─ UnicodeLetter
		               │     └─ NonTerminal "e"
		               ├─ Letter
		               │  └─ UnicodeLetter
		               │     └─ NonTerminal "g"
		               ├─ Letter
		               │  └─ UnicodeLetter
		               │     └─ NonTerminal "e"
		               └─ Letter
		                  └─ UnicodeLetter
		                     └─ NonTerminal "r"
		"""
		
		// When
		let syntacticTree = try parse(string: string)
		let output = syntacticTree.debugDescription
		
		// Then
		XCTAssertEqual(output, expected)
	}
	
	func testParseDeclarationWithTypeAnnotationAndExpression() throws {
		// Given
		let string = "val value: Integer = 1"
		
		let expected = """
		Declaration
		└─ ConstantDeclaration
		   ├─ NonTerminal "val"
		   └─ ConstantSpecification
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
		      ├─ NonTerminal ":"
		      ├─ Type
		      │  └─ TypeName
		      │     └─ Identifier
		      │        ├─ Letter
		      │        │  └─ UnicodeLetter
		      │        │     └─ NonTerminal "I"
		      │        ├─ Letter
		      │        │  └─ UnicodeLetter
		      │        │     └─ NonTerminal "n"
		      │        ├─ Letter
		      │        │  └─ UnicodeLetter
		      │        │     └─ NonTerminal "t"
		      │        ├─ Letter
		      │        │  └─ UnicodeLetter
		      │        │     └─ NonTerminal "e"
		      │        ├─ Letter
		      │        │  └─ UnicodeLetter
		      │        │     └─ NonTerminal "g"
		      │        ├─ Letter
		      │        │  └─ UnicodeLetter
		      │        │     └─ NonTerminal "e"
		      │        └─ Letter
		      │           └─ UnicodeLetter
		      │              └─ NonTerminal "r"
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
	
	func testParseDeclarationWithIdentifierList() throws {
		// Given
		let string = "val x, y: Integer"
		
		let expected = """
		Declaration
		└─ ConstantDeclaration
		   ├─ NonTerminal "val"
		   └─ ConstantSpecification
		      ├─ IdentifierList
		      │  ├─ Identifier
		      │  │  └─ Letter
		      │  │     └─ UnicodeLetter
		      │  │        └─ NonTerminal "x"
		      │  ├─ NonTerminal ","
		      │  └─ Identifier
		      │     └─ Letter
		      │        └─ UnicodeLetter
		      │           └─ NonTerminal "y"
		      ├─ NonTerminal ":"
		      └─ Type
		         └─ TypeName
		            └─ Identifier
		               ├─ Letter
		               │  └─ UnicodeLetter
		               │     └─ NonTerminal "I"
		               ├─ Letter
		               │  └─ UnicodeLetter
		               │     └─ NonTerminal "n"
		               ├─ Letter
		               │  └─ UnicodeLetter
		               │     └─ NonTerminal "t"
		               ├─ Letter
		               │  └─ UnicodeLetter
		               │     └─ NonTerminal "e"
		               ├─ Letter
		               │  └─ UnicodeLetter
		               │     └─ NonTerminal "g"
		               ├─ Letter
		               │  └─ UnicodeLetter
		               │     └─ NonTerminal "e"
		               └─ Letter
		                  └─ UnicodeLetter
		                     └─ NonTerminal "r"
		"""
		
		// When
		let syntacticTree = try parse(string: string)
		let output = syntacticTree.debugDescription
		
		// Then
		XCTAssertEqual(output, expected)
	}
}
