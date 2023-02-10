//
//  TypesParserTests.swift
//  Tests
//
//  Created by Ace Rodstin on 1/18/23.
//  Copyright © 2023 Ace Rodstin. All rights reserved.
//

import XCTest
@testable import Ace

final class TypesParserTests: XCTestCase {
	
	private let parser = SyntacticAnalyzer.TypesParser()
	
	private func parse(string: String) throws -> SyntacticNode {
		let tokenParser = TokenParser()
		let tokens = try tokenParser.parse(string: string)
		
		let stream = Stream(tokens)
		return try parser.parse(stream: stream)
	}

	func testParseTypeName() throws {
		// Given
		let string = "Integer"
		
		let expected = """
		Type
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
