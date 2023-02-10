//
//  NodeDumperTests.swift
//  Tests
//
//  Created by Ace Rodstin on 1/5/23.
//  Copyright © 2023 Ace Rodstin. All rights reserved.
//

import XCTest
@testable import Ace

final class NodeDumperTests: XCTestCase {
	
	func testTerminalDump_1() {
		// Given
		let root = TestNode(kind: .statement)
		
		let expected = """
		statement
		"""
		
		// When
		let output = root.debugDescription
		
		// Then
		XCTAssertEqual(output, expected)
	}
	
	func testTerminalDump_2() {
		// Given
		let child1_level1 = TestNode(kind: .expression)
		let root = TestNode(kind: .statement)
		root.children.append(child1_level1)
		
		let expected = """
		statement
		└─ expression
		"""
		
		// When
		let output = root.debugDescription
		
		// Then
		XCTAssertEqual(output, expected)
	}
	
	func testTerminalDump_3() {
		// Given
		let child2_level1 = TestNode(kind: .expression)
		let child1_level1 = TestNode(kind: .declaration)
		
		let root = TestNode(kind: .statement)
		root.children.append(child1_level1)
		root.children.append(child2_level1)
		
		let expected = """
		statement
		├─ declaration
		└─ expression
		"""
		
		// When
		let output = root.debugDescription
		
		// Then
		XCTAssertEqual(output, expected)
	}
	
	func testTerminalDump_4() {
		// Given
		let child2_level2 = TestNode(kind: .constantDeclaration)
		let child1_level2 = TestNode(kind: .pattern)
		
		let child2_level1 = TestNode(kind: .expression)
		child2_level1.children.append(child2_level2)
		
		let child1_level1 = TestNode(kind: .declaration)
		child1_level1.children.append(child1_level2)
		
		let root = TestNode(kind: .statement)
		root.children.append(child1_level1)
		root.children.append(child2_level1)
		
		let expected = """
		statement
		├─ declaration
		│  └─ pattern
		└─ expression
		   └─ constant-declaration
		"""
		
		// When
		let output = root.debugDescription
		
		// Then
		XCTAssertEqual(output, expected)
	}
	
	func testTerminalDump_5() {
		// Given
		let child1_level3 = TestNode(kind: .constantDeclaration)
		let child1_level2 = TestNode(kind: .declaration)
		child1_level2.children.append(child1_level3)
		
		let child1_level1 = TestNode(kind: .expression)
		child1_level1.children.append(child1_level2)
		
		let root = TestNode(kind: .statement)
		root.children.append(child1_level1)
		
		let expected = """
		statement
		└─ expression
		   └─ declaration
		      └─ constant-declaration
		"""
		
		// When
		let output = root.debugDescription
		
		// Then
		XCTAssertEqual(output, expected)
	}
	
	func testTerminalDump_6() {
		// Given
		let child2_level3 = TestNode(kind: .pattern)
		let child1_level3 = TestNode(kind: .constantDeclaration)
		
		let child1_level2 = TestNode(kind: .declaration)
		child1_level2.children.append(child1_level3)
		child1_level2.children.append(child2_level3)
		
		let child1_level1 = TestNode(kind: .expression)
		child1_level1.children.append(child1_level2)
		
		let root = TestNode(kind: .statement)
		root.children.append(child1_level1)
		
		let expected = """
		statement
		└─ expression
		   └─ declaration
		      ├─ constant-declaration
		      └─ pattern
		"""
		
		// When
		let output = root.debugDescription
		
		// Then
		XCTAssertEqual(output, expected)
	}
	
	func testTerminalDump_7() {
		// Given
		let child2_level3 = TestNode(kind: .literal)
		let child1_level3 = TestNode(kind: .initializer)
		
		let child2_level2 = TestNode(kind: .pattern)
		let child1_level2 = TestNode(kind: .constantDeclaration)
		
		let child2_level1 = TestNode(kind: .declaration)
		child2_level1.children.append(child1_level3)
		child2_level1.children.append(child2_level3)
		
		let child1_level1 = TestNode(kind: .expression)
		child1_level1.children.append(child1_level2)
		child1_level1.children.append(child2_level2)
		
		let root = TestNode(kind: .statement)
		root.children.append(child1_level1)
		root.children.append(child2_level1)
		
		let expected = """
		statement
		├─ expression
		│  ├─ constant-declaration
		│  └─ pattern
		└─ declaration
		   ├─ initializer
		   └─ literal
		"""
		
		// When
		let output = root.debugDescription
		
		// Then
		XCTAssertEqual(output, expected)
	}

	func testTerminalDump_8() {
		// Given
		let child2_level3 = TestNode(kind: .literal)
		let child1_level3 = TestNode(kind: .initializer)
		
		let child2_level2 = TestNode(kind: .pattern)
		let child2_level1 = TestNode(kind: .declaration)
		
		let child1_level2 = TestNode(kind: .constantDeclaration)
		child1_level2.children.append(child1_level3)
		child1_level2.children.append(child2_level3)
		
		let child1_level1 = TestNode(kind: .expression)
		child1_level1.children.append(child1_level2)
		child1_level1.children.append(child2_level2)
		
		let root = TestNode(kind: .statement)
		root.children.append(child1_level1)
		root.children.append(child2_level1)
		
		let expected = """
		statement
		├─ expression
		│  ├─ constant-declaration
		│  │  ├─ initializer
		│  │  └─ literal
		│  └─ pattern
		└─ declaration
		"""
		
		// When
		let output = root.debugDescription
		
		// Then
		XCTAssertEqual(output, expected)
	}
}
