//
//  ParseFloatLiteralTests.swift
//  TokenParser
//
//  Created by Ace Rodstin on 1/21/23.
//  Copyright © 2023 Ace Rodstin. All rights reserved.
//

import XCTest
@testable import Ace

final class ParseFloatLiteralTests: XCTestCase {
	func testParseDecimalFloatLiteral() throws {
		// Given
		let string = "1.1"
		
		let literal = Literal(kind: .float(.decimal), value: "1.1")
		let expected: [Token] = [.literal(literal)]
		
		// When
		let output = try Parser.parseTokens(string: string)
		
		// Then
		XCTAssert(output.contains(expected))
	}
	
	func testParseDecimalFloatLiteralWithUnderscore() throws {
		// Given
		let string = "0.000_1"
		
		let literal = Literal(kind: .float(.decimal), value: "0.000_1")
		let expected: [Token] = [.literal(literal)]
		
		// When
		let output = try Parser.parseTokens(string: string)
		
		// Then
		XCTAssert(output.contains(expected))
	}
	
	func testParseDecimalFloatLiteral_2() throws {
		// Given
		let string = "1.2e1"
		
		let literal = Literal(kind: .float(.decimal), value: "1.2e1")
		let expected: [Token] = [.literal(literal)]
		
		// When
		let output = try Parser.parseTokens(string: string)
		
		// Then
		XCTAssert(output.contains(expected))
	}
	
	func testParseDecimalFloatLiteral_3() throws {
		// Given
		let string = "1.2e+1"
		
		let literal = Literal(kind: .float(.decimal), value: "1.2e+1")
		let expected: [Token] = [.literal(literal)]
		
		// When
		let output = try Parser.parseTokens(string: string)
		
		// Then
		XCTAssert(output.contains(expected))
	}
	
	func testParseDecimalFloatLiteral_4() throws {
		// Given
		let string = "1e1"
		
		let literal = Literal(kind: .float(.decimal), value: "1e1")
		let expected: [Token] = [.literal(literal)]
		
		// When
		let output = try Parser.parseTokens(string: string)
		
		// Then
		XCTAssert(output.contains(expected))
	}
	
	func testParseDecimalFloatLiteral_5() throws {
		// Given
		let string = "1e+1"
		
		let literal = Literal(kind: .float(.decimal), value: "1e+1")
		let expected: [Token] = [.literal(literal)]
		
		// When
		let output = try Parser.parseTokens(string: string)
		
		// Then
		XCTAssert(output.contains(expected))
	}
	
	func testParseHexadecimalFloatLiteral_1() throws {
		// Given
		let string = "0xF.1"
		
		let literal = Literal(kind: .float(.hexadecimal), value: "0xF.1")
		let expected: [Token] = [.literal(literal)]
		
		// When
		let parser = TokenParser()
		let output = try parser.parse(string: string)
		
		// Then
		XCTAssert(output.contains(expected))
	}
	
	func testParseHexadecimalFloatLiteral_2() throws {
		// Given
		let string = "0xF.Fp1"
		
		let literal = Literal(kind: .float(.hexadecimal), value: "0xF.Fp1")
		let expected: [Token] = [.literal(literal)]
		
		// When
		let output = try Parser.parseTokens(string: string)
		
		// Then
		XCTAssert(output.contains(expected))
	}
	
	func testParseHexadecimalFloatLiteral_3() throws {
		// Given
		let string = "0xF.Fp+1"
		
		let literal = Literal(kind: .float(.hexadecimal), value: "0xF.Fp+1")
		let expected: [Token] = [.literal(literal)]
		
		// When
		let output = try Parser.parseTokens(string: string)
		
		// Then
		XCTAssert(output.contains(expected))
	}
	
	func testParseHexadecimalFloatLiteral_4() throws {
		// Given
		let string = "0xFp1"
		
		let literal = Literal(kind: .float(.hexadecimal), value: "0xFp1")
		let expected: [Token] = [.literal(literal)]
		
		// When
		let output = try Parser.parseTokens(string: string)
		
		// Then
		XCTAssert(output.contains(expected))
	}
	
	func testParseHexadecimalFloatLiteral_5() throws {
		// Given
		let string = "0xFp+1"
		
		let literal = Literal(kind: .float(.hexadecimal), value: "0xFp+1")
		let expected: [Token] = [.literal(literal)]
		
		// When
		let output = try Parser.parseTokens(string: string)
		
		// Then
		XCTAssert(output.contains(expected))
	}
}
