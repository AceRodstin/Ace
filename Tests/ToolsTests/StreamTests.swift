//
//  StreamTests.swift
//  Tests
//
//  Created by Ace Rodstin on 1/4/23.
//  Copyright © 2023 Ace Rodstin. All rights reserved.
//

import XCTest
@testable import Ace

final class StreamTests: XCTestCase {
	func testBuffer() {
		// Given
		let stream = Stream([1, 2, 3])
		let expected = [1, 2, 3]
		
		// When
		let output = stream.buffer
		
		// Then
		XCTAssertEqual(output, expected)
	}
	
	func testGetLowerBound() {
		// Given
		let stream = Stream([1, 2, 3])
		let expected: Stream<[Int]>.Unit = .buffered(1)
		
		// When
		let output = stream.get()
		
		// Then
		XCTAssertEqual(output, expected)
	}
	
	func testGetUpperBound() {
		// Given
		let stream = Stream([1])
		let expected: Stream<[Int]>.Unit = .buffered(1)
		
		// When
		let output = stream.get()
		
		// Then
		XCTAssertEqual(output, expected)
	}
	
	func testGetBufferElement() {
		// Given
		let stream = Stream([1, 2, 3])
		let expected: Stream<[Int]>.Unit = .buffered(1)
		
		// When
		let output = stream.get()
		
		// Then
		XCTAssertEqual(output, expected)
	}
	
	func testGetEndOfStream() {
		// Given
		let stream = Stream([1])
		let expected: Stream<[Int]>.Unit = .endOfStream
		
		// When
		_ = stream.get()
		let output = stream.get()
		
		// Then
		XCTAssertEqual(output, expected)
	}
	
	func testGetUnderEndOfStream() {
		// Given
		let stream = Stream([1])
		let expected: Stream<[Int]>.Unit = .endOfStream
		
		// When
		_ = stream.get()
		_ = stream.get()
		let output = stream.get()
		
		// Then
		XCTAssertEqual(output, expected)
	}
	
	func testPeekElement() {
		// Given
		let stream = Stream([1, 2, 3])
		let expected: Stream<[Int]>.Unit = .buffered(1)
		
		// When
		let output = stream.peek()
		
		// Then
		XCTAssertEqual(output, expected)
	}
	
	func testPeekEndOfStream() {
		// Given
		let stream = Stream("")
		let expected: Stream<String>.Unit = .endOfStream
		
		// When
		let output = stream.peek()
		
		// Then
		XCTAssertEqual(output, expected)
	}
	
	func testPeekUnderEndOfStream() {
		// Given
		let stream = Stream([1])
		let expected: Stream<[Int]>.Unit = .endOfStream
		
		// When
		_ = stream.get()
		_ = stream.get()
		let output = stream.peek()
		
		// Then
		XCTAssertEqual(output, expected)
	}
	
	func testPut() {
		// Given
		let stream = Stream([1])
		
		// When
		let value = stream.get()
		
		// Then
		XCTAssertNoThrow(try stream.put(unit: value))
	}
	
	func testPutBeginOfStream() {
		// Given
		let stream = Stream("")
		
		// When
		let unit = stream.unit
		
		// Then
		XCTAssertNoThrow(try stream.put(unit: unit))
	}
	
	func testPutEndOfStream() {
		// Given
		let stream = Stream([1])
		
		// When
		_ = stream.get()
		let unit = stream.get()
		
		// Then
		XCTAssertNoThrow(try stream.put(unit: unit))
	}
	
	func testPositionAtBegin() {
		// Given
		let stream = Stream([1])
		
		// When
		let output = stream.position
		
		// Then
		XCTAssertNil(output)
	}
	
	func testPositionAtEnd() {
		// Given
		let stream = Stream([1])
		let expected = stream.buffer.endIndex
		
		// When
		while !stream.isEnd {
			_ = stream.get()
		}
		
		let output = stream.position
		
		// Then
		XCTAssertEqual(output, expected)
	}
	
	func testPositionIncreases() {
		// Given
		let stream = Stream([1])
		let expected = stream.buffer.startIndex
		
		// When
		_ = stream.get()
		let output = stream.position
		
		// Then
		XCTAssertEqual(output, expected)
	}
	
	func testPositionDecreases() throws {
		// Given
		let stream = Stream([1])
		
		// When
		let value = stream.get()
		try stream.put(unit: value)
		
		let output = stream.position 
		
		// Then
		XCTAssertNil(output)
	}
	
	func testPositionResets() {
		// Given
		let stream = Stream([1])
		
		// When
		_ = stream.get()
		stream.reset()
		
		let output = stream.position
		
		// Then
		XCTAssertNil(output)
	}
	
	func testOffsetAtBegin() {
		// Given
		let stream = Stream([1])
		
		// When
		let output = stream.offset
		
		// Then
		XCTAssertNil(output)
	}
	
	func testOffsetAtEnd() {
		// Given
		let stream = Stream([1])
		let expected = stream.buffer.count
		
		// When
		while !stream.isEnd {
			_ = stream.get()
		}
		
		let output = stream.offset
		
		// Then
		XCTAssertEqual(output, expected)
	}
	
	func testOffsetAdvances() {
		// Given
		let stream = Stream([1])
		let expected = 0
		
		// When
		_ = stream.get()
		let output = stream.offset
		
		// Then
		XCTAssertEqual(output, expected)
	}
	
	func testOffsetResets() {
		// Given
		let stream = Stream([1])
		
		// When
		_ = stream.get()
		stream.reset()
		
		let output = stream.offset
		
		// Then
		XCTAssertNil(output)
	}
	
	func testIsEnd() {
		// Given
		let stream = Stream("1")
		
		// When
		_ = stream.get()
		_ = stream.get()
		
		// Then
		XCTAssertTrue(stream.isEnd)
	}
	
	func testIsNotEnd() {
		// Given
		let stream = Stream([1])
		
		// Then
		XCTAssertFalse(stream.isEnd)
	}
	
	func testHasMoreEmptyBuffer() {
		// Given
		let stream = Stream("")
		
		// Then
		XCTAssertFalse(stream.hasMore)
	}
	
	func testHasMoreNotEmptyBuffer() {
		// Given
		let stream = Stream("1")
		
		// Then
		XCTAssertTrue(stream.hasMore)
	}
	
	func testHasMoreEndOfStream() {
		// Given
		let stream = Stream("1")
		
		// When
		_ = stream.get()
		_ = stream.get()
		
		// Then
		XCTAssertFalse(stream.hasMore)
	}
	
	func testHasMore() {
		// Given
		let stream = Stream("12")
		
		// When
		_ = stream.get()
		
		// Then
		XCTAssertTrue(stream.hasMore)
	}
	
	func testHasNotMore() {
		// Given
		let stream = Stream("1")
		
		// When
		_ = stream.get()
		
		// Then
		XCTAssertFalse(stream.hasMore)
	}
	
	func testUnitIsBeginOfStream() {
		// Given
		let stream = Stream([1, 2, 3])
		let expected: Stream<[Int]>.Unit = .beginOfStream
		
		// Then
		let output = stream.unit
		
		// Then
		XCTAssertEqual(output, expected)
	}
	
	func testUnitEqualsGot() {
		// Given
		let stream = Stream([1, 2, 3])
		
		// Then
		let got = stream.get()
		let output = stream.unit
		
		// Then
		XCTAssertEqual(output, got)
	}
	
	func testUnitIsEndOfStream() {
		// Given
		let stream = Stream("")
		let expected: Stream<String>.Unit = .endOfStream
		
		// Then
		_ = stream.get()
		let output = stream.unit
		
		// Then
		XCTAssertEqual(output, expected)
	}
}
