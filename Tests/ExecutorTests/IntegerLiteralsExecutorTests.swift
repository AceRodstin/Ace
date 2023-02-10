//
//  IntegerLiteralsExecutorTests.swift
//  Tests
//
//  Created by Ace Rodstin on 2/8/23.
//  Copyright © 2023 Ace Rodstin. All rights reserved.
//

import XCTest
@testable import Ace

final class IntegerLiteralsExecutorTests: XCTestCase {
	func testExecuteConstantDeclarationWithDecimalIntegerLiteral() throws {
		// Given
		let string = "val value = 500"
		let expected = Symbol(id: "value", type: .integer, mutability: .constant, value: 500)
		
		// When
		let symbols = try Parser.parseSymbols(string: string)
		
		// Then
		XCTAssert(symbols.contains(expected))
	}
	
	func testExecuteConstantDeclarationWithBinaryIntegerLiteral() throws {
		// Given
		let string = "val value = 0b0001_1111_0100"
		let expected = Symbol(id: "value", type: .integer, mutability: .constant, value: 500)
		
		// When
		let symbols = try Parser.parseSymbols(string: string)
		
		// Then
		XCTAssert(symbols.contains(expected))
	}
	
	func testExecuteConstantDeclarationWithOctalIntegerLiteral() throws {
		// Given
		let string = "val value = 0o764"
		let expected = Symbol(id: "value", type: .integer, mutability: .constant, value: 500)
		
		// When
		let symbols = try Parser.parseSymbols(string: string)
		
		// Then
		XCTAssert(symbols.contains(expected))
	}
	
	func testExecuteConstantDeclarationWithHexadecimalIntegerLiteral() throws {
		// Given
		let string = "val value = 0x1F4"
		let expected = Symbol(id: "value", type: .integer, mutability: .constant, value: 500)
		
		// When
		let symbols = try Parser.parseSymbols(string: string)
		
		// Then
		XCTAssert(symbols.contains(expected))
	}
}
