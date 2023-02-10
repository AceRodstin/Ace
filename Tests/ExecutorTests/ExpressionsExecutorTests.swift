//
//  ExpressionsExecutorTests.swift
//  Tests
//
//  Created by Ace Rodstin on 2/8/23.
//  Copyright © 2023 Ace Rodstin. All rights reserved.
//

import XCTest
@testable import Ace

final class ExpressionsExecutorTests: XCTestCase {
	func testExecutionAddition() throws {
		// Given
		let string = "val value = 1 + 2"
		let expected = Symbol(id: "value", type: .integer, mutability: .constant, value: 3)
		
		// When
		let symbols = try Parser.parseSymbols(string: string)
		
		// Then
		XCTAssert(symbols.contains(expected))
	}
	
	func testExecutionSubtraction() throws {
		// Given
		let string = "val value = 1 - 2"
		let expected = Symbol(id: "value", type: .integer, mutability: .constant, value: -1)
		
		// When
		let symbols = try Parser.parseSymbols(string: string)
		
		// Then
		XCTAssert(symbols.contains(expected))
	}
	
	func testExecutionMultiplication() throws {
		// Given
		let string = "val value = 1 * 2"
		let expected = Symbol(id: "value", type: .integer, mutability: .constant, value: 2)
		
		// When
		let symbols = try Parser.parseSymbols(string: string)
		
		// Then
		XCTAssert(symbols.contains(expected))
	}
	
	func testExecutionDivision() throws {
		// Given
		let string = "val value = 1 / 2"
		let expected = Symbol(id: "value", type: .integer, mutability: .constant, value: 0)
		
		// When
		let symbols = try Parser.parseSymbols(string: string)
		
		// Then
		XCTAssert(symbols.contains(expected))
	}
	
	func testExecutionMultipleAddition() throws {
		// Given
		let string = "val value = 1 + 2 + 3"
		let expected = Symbol(id: "value", type: .integer, mutability: .constant, value: 6)
		
		// When
		let symbols = try Parser.parseSymbols(string: string)
		
		// Then
		XCTAssert(symbols.contains(expected))
	}
	
	func testExecutionAdditionMultiplication() throws {
		// Given
		let string = "val value = 1 + 2 * 3"
		let expected = Symbol(id: "value", type: .integer, mutability: .constant, value: 7)
		
		// When
		let symbols = try Parser.parseSymbols(string: string)
		
		// Then
		XCTAssert(symbols.contains(expected))
	}
	
	func testExecutionMultiplicationAddition() throws {
		// Given
		let string = "val value = 1 * 2 + 3"
		let expected = Symbol(id: "value", type: .integer, mutability: .constant, value: 5)
		
		// When
		let symbols = try Parser.parseSymbols(string: string)
		
		// Then
		XCTAssert(symbols.contains(expected))
	}
	
	func testExecutionMultipleAdditionMultiplication() throws {
		// Given
		let string = "val value = 1 * 2 + 3 + 4 * 5 + 6 * 7"
		let expected = Symbol(id: "value", type: .integer, mutability: .constant, value: 67)
		
		// When
		let symbols = try Parser.parseSymbols(string: string)
		
		// Then
		XCTAssert(symbols.contains(expected))
	}
	
	func testExecutionParenthesized_1() throws {
		// Given
		let string = "val value = (1)"
		let expected = Symbol(id: "value", type: .integer, mutability: .constant, value: 1)
		
		// When
		let symbols = try Parser.parseSymbols(string: string)
		
		// Then
		XCTAssert(symbols.contains(expected))
	}
	
	func testExecutionParenthesized_2() throws {
		// Given
		let string = "val value = 1 * (2 + 3)"
		let expected = Symbol(id: "value", type: .integer, mutability: .constant, value: 5)
		
		// When
		let symbols = try Parser.parseSymbols(string: string)
		
		// Then
		XCTAssert(symbols.contains(expected))
	}
	
	func testExecutionParenthesized_3() throws {
		// Given
		let string = "val value = 1 * (2 + 3) * (4 + 5)"
		let expected = Symbol(id: "value", type: .integer, mutability: .constant, value: 45)
		
		// When
		let symbols = try Parser.parseSymbols(string: string)
		
		// Then
		XCTAssert(symbols.contains(expected))
	}
	
	func testExecutionParenthesized_4() throws {
		// Given
		let string = "val value = 1 * (2 + 3) + 4 * 5"
		let expected = Symbol(id: "value", type: .integer, mutability: .constant, value: 25)
		
		// When
		let symbols = try Parser.parseSymbols(string: string)
		
		// Then
		XCTAssert(symbols.contains(expected))
	}
}
