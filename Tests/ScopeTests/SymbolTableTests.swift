//
//  SymbolTableTests.swift
//  Tests
//
//  Created by Ace Rodstin on 2/9/23.
//  Copyright © 2023 Ace Rodstin. All rights reserved.
//

import XCTest
@testable import Ace

final class SymbolTableTests: XCTestCase {
	func testInsertSymbol() {
		// Given
		let symbol = Symbol(id: "value", type: .integer, mutability: .constant)
		
		// When
		let symbolTable = SymbolTable()
		
		// Then
		XCTAssertNoThrow(try symbolTable.insert(symbol))
	}
	
	func testInsertSymbolThrows() throws {
		// Given
		let symbol = Symbol(id: "value", type: .integer, mutability: .constant)
		
		// When
		let symbolTable = SymbolTable()
		try symbolTable.insert(symbol)
		
		// Then
		XCTAssertThrowsError(try symbolTable.insert(symbol))
	}
	
	func testFindSymbol() throws {
		// Given
		let symbol = Symbol(id: "value", type: .integer, mutability: .constant)
		
		// When
		let symbolTable = SymbolTable()
		try symbolTable.insert(symbol)
		let output = symbolTable.symbol(with: symbol.id)
		
		// Then
		XCTAssertEqual(output, symbol)
	}
	
	func testChangeSymbolValue() throws {
		// Given
		let symbol = Symbol(id: "value", type: .integer, mutability: .variable, value: 1)
		let expected = Symbol(id: "value", type: .integer, mutability: .variable, value: 2)
		
		// When
		let symbolTable = SymbolTable()
		try symbolTable.insert(symbol)
		try symbolTable.changeValue(of: "value", newValue: 2)
		let output = symbolTable.symbol(with: symbol.id)
		
		// Then
		XCTAssertEqual(output, expected)
	}
	
	func testChangeSymbolValueThrows() throws {
		// Given
		let symbol = Symbol(id: "value", type: .integer, mutability: .constant, value: 1)
		
		// When
		let symbolTable = SymbolTable()
		try symbolTable.insert(symbol)
		
		// Then
		XCTAssertThrowsError(try symbolTable.changeValue(of: "value", newValue: 2))
	}
}
