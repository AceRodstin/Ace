//
//  Tests.swift
//  Tests
//
//  Created by Ace Rodstin on 1/20/23.
//  Copyright © 2023 Ace Rodstin. All rights reserved.
//

import XCTest
@testable import Ace

final class SourceCodeManagerTests: XCTestCase {
	
	// MARK: - Types
	
	enum SetupError: Error {
		case sourceFilePathNotSpecified
	}
	
	// MARK: - Properties
	
	private var filePath = ""
	
	// MARK: - Methods
	
	override func setUpWithError() throws {
		let arguments = CommandLine.arguments
		let sourceFlagIndex = arguments.firstIndex { $0 == "--test-source" }

		if let sourceFlagIndex {
			let filePathIndex = arguments.index(after: sourceFlagIndex)
			filePath = arguments[filePathIndex]
		} else {
			throw SetupError.sourceFilePathNotSpecified
		}
	}
	
	func testOpenFileThrowsError() {
		// Given
		let sourceCodeManager = SourceCodeManager()
		
		// Then
		XCTAssertThrowsError(try sourceCodeManager.open(file: ""))
	}
	
	func testOpenFileNameCorrect() throws {
		// Given
		let sourceCodeManager = SourceCodeManager()
		let expected = "TestSourceCode"
		
		// When
		try sourceCodeManager.open(file: filePath)
		let output = sourceCodeManager.fileName
		
		// Then
		XCTAssertEqual(output, expected)
	}
	
	func testOpenFileExtensionCorrect() throws {
		// Given
		let sourceCodeManager = SourceCodeManager()
		let expected = "ace"
		
		// When
		try sourceCodeManager.open(file: filePath)
		let output = sourceCodeManager.fileExtension
		
		// Then
		XCTAssertEqual(output, expected)
	}
	
	func testCloseSourceCodeIsEmpty() throws {
		// Given
		let sourceCodeManager = SourceCodeManager()
		
		// When
		try sourceCodeManager.open(file: filePath)
		sourceCodeManager.close()
		
		// Then
		XCTAssert(sourceCodeManager.sourceCode.isEmpty)
	}
	
	func testCloseSourceFileNameIsEmpty() throws {
		// Given
		let sourceCodeManager = SourceCodeManager()
		
		// When
		try sourceCodeManager.open(file: filePath)
		sourceCodeManager.close()
		
		// Then
		XCTAssert(sourceCodeManager.fileName.isEmpty)
	}
	
	func testCloseSourceFileExtensionIsEmpty() throws {
		// Given
		let sourceCodeManager = SourceCodeManager()
		
		// When
		try sourceCodeManager.open(file: filePath)
		sourceCodeManager.close()
		
		// Then
		XCTAssert(sourceCodeManager.fileExtension.isEmpty)
	}
}
