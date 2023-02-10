//
//  ScopeTests.swift
//  Tests
//
//  Created by Ace Rodstin on 2/9/23.
//  Copyright © 2023 Ace Rodstin. All rights reserved.
//

import XCTest
@testable import Ace

final class ScopeTests: XCTestCase {
	func testDeclareSymbol() {
		// Given
		let symbol = Symbol(id: "value", type: .integer, mutability: .constant)
		
		// When
		let scope = Scope()
		
		// Then
		XCTAssertNoThrow(try scope.declare(symbol: symbol))
	}
	
	func testDeclareSymbolThrows() throws {
		// Given
		let symbol = Symbol(id: "value", type: .integer, mutability: .constant)
		
		// When
		let scope = Scope()
		try scope.declare(symbol: symbol)
		
		// Then
		XCTAssertThrowsError(try scope.declare(symbol: symbol))
	}
	
	func testGetValue() throws {
		// Given
		let symbol = Symbol(id: "value", type: .integer, mutability: .constant, value: 10)
		let expected = 10
		
		// When
		let scope = Scope()
		try scope.declare(symbol: symbol)
		
		let value = try scope.value(of: "value")
		let output = value as? Int
		
		// Then
		XCTAssertEqual(output, expected)
	}
	
	func testGetValueThrows() throws {
		// Given
		let symbol = Symbol(id: "value", type: .integer, mutability: .constant)
		
		// When
		let scope = Scope()
		try scope.declare(symbol: symbol)
		
		// Then
		XCTAssertThrowsError(try scope.value(of: "another"))
	}
	
	func testChangeValue() throws {
		// Given
		let symbol = Symbol(id: "value", type: .integer, mutability: .variable, value: 1)
		let expected = 2
		
		// When
		let scope = Scope()
		try scope.declare(symbol: symbol)
		try scope.changeValue(of: "value", newValue: 2)
		
		let value = try scope.value(of: "value")
		let output = value as? Int
		
		// Then
		XCTAssertEqual(output, expected)
	}
	
	func testChangeValueThrows() throws {
		// Given
		let symbol = Symbol(id: "value", type: .integer, mutability: .constant, value: 1)
		
		// When
		let scope = Scope()
		try scope.declare(symbol: symbol)
		
		// Then
		XCTAssertThrowsError(try scope.changeValue(of: "value", newValue: 2))
	}
}
