//
//  TextReaderTests.swift
//  Tests
//
//  Created by Ace Rodstin on 1/20/23.
//  Copyright © 2023 Ace Rodstin. All rights reserved.
//

import XCTest
@testable import Ace

final class TextReaderTests: XCTestCase {
	func testLoadLineStartsAtOne() throws {
		// Given
		let string = "test"
		let expected = 1
		
		// When
		let textReader = TextReader()
		textReader.load(string: string)
		
		let output = textReader.position.line
		
		// Then
		XCTAssertEqual(output, expected)
	}
	
	func testOpenColumnStartsAtZero() throws {
		// Given
		let string = "test"
		let expected = 0
		
		// When
		let textReader = TextReader()
		textReader.load(string: string)
		
		let output = textReader.position.column
		
		// Then
		XCTAssertEqual(output, expected)
	}
	
	func testReadLineAdvances() throws {
		// Given
		let string = "a\nb"
		let expected = 2
		
		// When
		let textReader = TextReader()
		textReader.load(string: string)
		
		_ = textReader.read()
		_ = textReader.read()
		
		let output = textReader.position.line
		
		// Then
		XCTAssertEqual(output, expected)
	}
	
	func testReadColumnAdvances() throws {
		// Given
		let string = "ab"
		let expected = 1
		
		// When
		let textReader = TextReader()
		textReader.load(string: string)
		
		_ = textReader.read()
		
		let output = textReader.position.column
		
		// Then
		XCTAssertEqual(output, expected)
	}
	
	func testReadPositionCorrect() throws {
		// Given
		let string = "line 1\nline 2\nline 3"
		let expected = TextReader.Position(line: 3, column: 6)
		
		// When
		let textReader = TextReader()
		textReader.load(string: string)
		
		var unit: TextReader.Unit?
		
		while unit != .character("3") {
			unit = textReader.read()
		}
		
		let output = textReader.position
		
		// Then
		XCTAssertEqual(output, expected)
	}
	
	func testReadCharacter() throws {
		// Given
		let string = "v"
		let expected: TextReader.Unit = .character("v")
		
		// When
		let textReader = TextReader()
		textReader.load(string: string)
		
		let output = textReader.read()
		
		// Then
		XCTAssertEqual(output, expected)
	}
	
	func testReadEndOfFile() throws {
		// Given
		let string = "line"
		let expected: TextReader.Unit = .endOfFile
		
		// When
		let textReader = TextReader()
		textReader.load(string: string)
		
		var unit: TextReader.Unit?
		
		while unit != .endOfFile {
			unit = textReader.read()
		}
		
		// Then
		XCTAssertEqual(unit, expected)
	}
	
	func testUnitIsBeginOfFile() throws {
		// Given
		let string = "line"
		let expected: TextReader.Unit = .beginOfFile
		
		// When
		let textReader = TextReader()
		textReader.load(string: string)
		
		let output = textReader.unit
		
		// Then
		XCTAssertEqual(output, expected)
	}
	
	func testUnitIsEndOfFile() throws {
		// Given
		let string = "line"
		let expected: TextReader.Unit = .endOfFile
		
		// When
		let textReader = TextReader()
		textReader.load(string: string)
		
		var unit: TextReader.Unit?
		
		while unit != .endOfFile {
			unit = textReader.read()
		}
		
		let output = textReader.unit
		
		// Then
		XCTAssertEqual(output, expected)
	}
	
	func testUnitEqualsRead() throws {
		// Given
		let string = "line"
		
		// When
		let textReader = TextReader()
		textReader.load(string: string)
		
		let read = textReader.read()
		let output = textReader.unit
		
		// Then
		XCTAssertEqual(output, read)
	}
	
	func testUnread() {
		// Given
		let string = "line"
		
		// When
		let textReader = TextReader()
		textReader.load(string: string)
		
		let read = textReader.read()
		
		// Then
		XCTAssertNoThrow(try textReader.unread(read))
	}
}
