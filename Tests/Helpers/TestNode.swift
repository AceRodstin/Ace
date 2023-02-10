//
//  TestNode.swift
//  Tests
//
//  Created by Ace Rodstin on 1/4/23.
//  Copyright © 2023 Ace Rodstin. All rights reserved.
//

import Foundation

final class TestNode: Node {
	
	// MARK: - Properties
	
	let id: UUID
	var children: [TestNode]
	
	let kind: Kind
	let value: String?
	
	// MARK: - Lifecycle
	
	init(kind: Kind, value: String? = nil) {
		self.id = UUID()
		self.children = []
		
		self.kind = kind
		self.value = value
	}
	
	// MARK: - Methods
	
	func joined() -> String {
		var result = ""
		
		let walker = NodeWalker<TestNode>()
		walker.visit(node: self) { terminal in
			if let value = terminal.value {
				result += value
			}
		}
		
		return result
	}
}

// MARK: - CustomStringConvertible

extension TestNode: CustomStringConvertible {
	var description: String {
		var description = ""
		
		description += "\(kind.rawValue)"
		
		if let value {
			description += " \"\(value)\""
		}
		
		return description
	}
}

// MARK: - CustomDebugStringConvertible

extension TestNode: CustomDebugStringConvertible {
	var debugDescription: String {
		let dumper = NodeDumper<TestNode>()
		return dumper.dump(self)
	}
}
