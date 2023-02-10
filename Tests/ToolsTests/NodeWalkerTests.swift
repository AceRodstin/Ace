//
//  NodeWalkerTests.swift
//  Tests
//
//  Created by Ace Rodstin on 1/8/23.
//  Copyright © 2023 Ace Rodstin. All rights reserved.
//

import XCTest
@testable import Ace

final class NodeWalkerTests: XCTestCase {
	
	typealias Walker = NodeWalker<TestNode>
	
	func testStop() {
		// Given
		let node = TestNode(kind: .statement)
		
		// When
		var output: TestNode.Kind?
		let walker = Walker()
		walker.stop()
		
		walker.visit(node: node) { node in
			output = node.kind
		}
		
		// Then
		XCTAssertNil(output)
	}
	
	func testSkip() {
		// Given
		let child2 = TestNode(kind: .declaration)
		let child1 = TestNode(kind: .expression)
		
		let node = TestNode(kind: .statement)
		node.children.append(child1)
		node.children.append(child2)
		
		let expected: [TestNode.Kind] = [.statement, .declaration]
		
		// When
		var output: [TestNode.Kind] = []
		let walker = Walker()
		walker.skip(node: child1)
		
		walker.visit(node: node) { node in
			output.append(node.kind)
		}
		
		// Then
		XCTAssertEqual(output, expected)
	}
}
