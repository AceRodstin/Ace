//
//  FloatLiteralsExecutorTests.swift
//  Tests
//
//  Created by Ace Rodstin on 2/8/23.
//  Copyright © 2023 Ace Rodstin. All rights reserved.
//

import XCTest
@testable import Ace

final class FloatLiteralsExecutorTests: XCTestCase {
	func testExecuteDecimalFloatLiteralWithFraction() throws {
		// Given
		let string = "val value = 1.1"
		let expected = Symbol(id: "value", type: .double, mutability: .constant, value: 1.1)
		
		// When
		let symbols = try Parser.parseSymbols(string: string)
		
		// Then
		XCTAssert(symbols.contains(expected))
	}
	
	func testExecuteDecimalFloatLiteralWithExponent() throws {
		// Given
		let string = "val value = 1E2"
		let expected = Symbol(id: "value", type: .double, mutability: .constant, value: 100.0)
		
		// When
		let symbols = try Parser.parseSymbols(string: string)
		
		// Then
		XCTAssert(symbols.contains(expected))
	}
	
	func testExecuteDecimalFloatLiteralWithExponentPlusSign() throws {
		// Given
		let string = "val value = 1E+2"
		let expected = Symbol(id: "value", type: .double, mutability: .constant, value: 100.0)
		
		// When
		let symbols = try Parser.parseSymbols(string: string)
		
		// Then
		XCTAssert(symbols.contains(expected))
	}
	
	func testExecuteDecimalFloatLiteralWithExponentMinusSign() throws {
		// Given
		let string = "val value = 1E-2"
		let expected = Symbol(id: "value", type: .double, mutability: .constant, value: 0.01)
		
		// When
		let symbols = try Parser.parseSymbols(string: string)
		
		// Then
		XCTAssert(symbols.contains(expected))
	}
	
	func testExecuteDecimalFloatLiteralWithFractionExponent() throws {
		// Given
		let string = "val value = 1.2E3"
		let expected = Symbol(id: "value", type: .double, mutability: .constant, value: 1200.0)
		
		// When
		let symbols = try Parser.parseSymbols(string: string)
		
		// Then
		XCTAssert(symbols.contains(expected))
	}
	
	func testExecuteDecimalFloatLiteralWithFractionExponentSign() throws {
		// Given
		let string = "val value = 1.2E+3"
		let expected = Symbol(id: "value", type: .double, mutability: .constant, value: 1200.0)
		
		// When
		let symbols = try Parser.parseSymbols(string: string)
		
		// Then
		XCTAssert(symbols.contains(expected))
	}
	
	func testExecuteDecimalFloatLiteralStartsWithZero() throws {
		// Given
		let string = "val value = 0.1"
		let expected = Symbol(id: "value", type: .double, mutability: .constant, value: 0.1)
		
		// When
		let symbols = try Parser.parseSymbols(string: string)
		
		// Then
		XCTAssert(symbols.contains(expected))
	}
	
	func testExecuteHexadecimalFloatLiteral() throws {
		// Given
		let string = "val value = 0xFP1"
		let expected = Symbol(id: "value", type: .double, mutability: .constant, value: 30.0)
		
		// When
		let symbols = try Parser.parseSymbols(string: string)
		
		// Then
		XCTAssert(symbols.contains(expected))
	}
	
	func testExecuteHexadecimalFloatLiteralWithUnderscore() throws {
		// Given
		let string = "val value = 0x_FP1"
		let expected = Symbol(id: "value", type: .double, mutability: .constant, value: 30.0)
		
		// When
		let symbols = try Parser.parseSymbols(string: string)
		
		// Then
		XCTAssert(symbols.contains(expected))
	}
	
	func testExecuteHexadecimalFloatLiteralWithUnderscores() throws {
		// Given
		let string = "val value = 0xF_FP1"
		let expected = Symbol(id: "value", type: .double, mutability: .constant, value: 510.0)
		
		// When
		let symbols = try Parser.parseSymbols(string: string)
		
		// Then
		XCTAssert(symbols.contains(expected))
	}
	
	func testExecuteHexadecimalFloatLiteralWithFraction() throws {
		// Given
		let string = "val value = 0xF.FP1"
		let expected = Symbol(id: "value", type: .double, mutability: .constant, value: 31.875)
		
		// When
		let symbols = try Parser.parseSymbols(string: string)
		
		// Then
		XCTAssert(symbols.contains(expected))
	}
}
