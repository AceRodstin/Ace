//
//  ExecutorTests.swift
//  Tests
//
//  Created by Ace Rodstin on 2/9/23.
//  Copyright © 2023 Ace Rodstin. All rights reserved.
//

import XCTest
@testable import Ace

final class ExecutorTests: XCTestCase {
	func testExecuteConstantDeclarationWithTypeAnnotation() throws {
		// Given
		let string = "val value: Integer"
		let expected = Symbol(id: "value", type: .integer, mutability: .constant)
		
		// When
		let symbols = try Parser.parseSymbols(string: string)
		
		// Then
		XCTAssert(symbols.contains(expected))
	}
	
	func testExecuteVariableDeclarationWithTypeAnnotation() throws {
		// Given
		let string = "var value: Double"
		let expected = Symbol(id: "value", type: .double, mutability: .variable)
		
		// When
		let symbols = try Parser.parseSymbols(string: string)
		
		// Then
		XCTAssert(symbols.contains(expected))
	}
	
	func testExecuteConstantDeclarationWithIntegerTypeInference() throws {
		// Given
		let string = "val value = 1"
		let expected = Symbol(id: "value", type: .integer, mutability: .constant, value: 1)
		
		// When
		let symbols = try Parser.parseSymbols(string: string)
		
		// Then
		XCTAssert(symbols.contains(expected))
	}
	
	func testExecuteVariableDeclarationWithDoubleTypeInference() throws {
		// Given
		let string = "var value = 0.5"
		let expected = Symbol(id: "value", type: .double, mutability: .variable, value: 0.5)
		
		// When
		let symbols = try Parser.parseSymbols(string: string)
		
		// Then
		XCTAssert(symbols.contains(expected))
	}
	
	func testExecuteConstantDeclarationWithTypeAnnotationTypeInference() throws {
		// Given
		let string = "val value: Integer = 1"
		let expected = Symbol(id: "value", type: .integer, mutability: .constant, value: 1)
		
		// When
		let symbols = try Parser.parseSymbols(string: string)
		
		// Then
		XCTAssert(symbols.contains(expected))
	}
	
	func testExecuteConstantDeclarationWithTypeAnnotationInvalidDoubleTypeInference() {
		// Given
		let string = "val value: Integer = 1.0"
		
		// Then
		XCTAssertThrowsError(try Parser.parseSymbols(string: string))
	}
	
	func testExecuteVariableDeclarationWithTypeAnnotationInvalidIntegerTypeInference() {
		// Given
		let string = "var value: Double = 1"
		
		// Then
		XCTAssertThrowsError(try Parser.parseSymbols(string: string))
	}
	
	func testExecuteVariableDeclarationWithTypeConversion() throws {
		// Given
		let string = "var value = 1 + 2.5"
		let expected = Symbol(id: "value", type: .double, mutability: .variable, value: 3.5)
		
		// When
		let symbols = try Parser.parseSymbols(string: string)
		
		// Then
		XCTAssert(symbols.contains(expected))
	}
	
	func testExecuteConstantDeclarationWithIdentifierInExpression() throws {
		// Given
		let string = "val value = 1 + another"
		let anotherSymbol = Symbol(id: "another", type: .integer, mutability: .constant, value: 9)
		let expected = Symbol(id: "value", type: .integer, mutability: .constant, value: 10)
		
		// When
		let symbols = try Parser.parseSymbols(string: string, symbols: [anotherSymbol])
		
		// Then
		XCTAssert(symbols.contains(expected))
	}
	
	func testExecuteTypeConversionWithIdentifierInExpression_1() throws {
		// Given
		let string = "val value = 1 + another"
		let anotherSymbol = Symbol(id: "another", type: .double, mutability: .constant, value: 0.1)
		let expected = Symbol(id: "value", type: .double, mutability: .constant, value: 1.1)
		
		// When
		let symbols = try Parser.parseSymbols(string: string, symbols: [anotherSymbol])
		
		// Then
		XCTAssert(symbols.contains(expected))
	}
	
	func testExecuteTypeConversionWithIdentifierInExpression_2() throws {
		// Given
		let string = "val value = 1.5 + another"
		let anotherSymbol = Symbol(id: "another", type: .integer, mutability: .constant, value: 1)
		let expected = Symbol(id: "value", type: .double, mutability: .constant, value: 2.5)
		
		// When
		let symbols = try Parser.parseSymbols(string: string, symbols: [anotherSymbol])
		
		// Then
		XCTAssert(symbols.contains(expected))
	}
	
	func testAssignment() throws {
		// Given
		let string = "value = 2"
		let symbol = Symbol(id: "value", type: .integer, mutability: .variable, value: 1)
		let expected = Symbol(id: "value", type: .integer, mutability: .variable, value: 2)
		
		// When
		let symbols = try Parser.parseSymbols(string: string, symbols: [symbol])
		
		// Then
		XCTAssert(symbols.contains(expected))
	}
}
