//
//  SyntacticNode.swift
//  SyntacticAnalyzer
//
//  Created by Ace Rodstin on 2/7/23.
//  Copyright © 2023 Ace Rodstin. All rights reserved.
//

import Foundation

final class SyntacticNode: Node {
	
	// MARK: - Properties
	
	let id: UUID
	var children: [SyntacticNode]
	
	let kind: Kind
	var value: String?
	
	// MARK: - Lifecycle
	
	init(kind: Kind, value: String? = nil) {
		self.id = UUID()
		self.children = []
		
		self.kind = kind
		self.value = value
	}
	
	init(kind: Kind, value: Character) {
		self.id = UUID()
		self.children = []
		
		self.kind = kind
		self.value = String(value)
	}
	
	// MARK: - Methods
	
	func joined() -> String {
		var result = ""
		
		let walker = NodeWalker<SyntacticNode>()
		walker.visit(node: self) { terminal in
			if let value = terminal.value {
				result += value
			}
		}
		
		return result
	}
}

// MARK: - CustomStringConvertible

extension SyntacticNode: CustomStringConvertible {
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

extension SyntacticNode: CustomDebugStringConvertible {
	var debugDescription: String {
		let dumper = NodeDumper<SyntacticNode>()
		return dumper.dump(self)
	}
}
