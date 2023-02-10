//
//  NodeWalker.swift
//  Tools
//
//  Created by Ace Rodstin on 1/10/23.
//  Copyright © 2023 Ace Rodstin. All rights reserved.
//

import Foundation

public final class NodeWalker<T> where T: Node {
	
	// MARK: - Properties
	
	private var skipping: T?
	private var canVisit = true
	
	// MARK: - Methods
	
	public func visit(node: T, closure: @escaping (T) throws -> Void) rethrows {
		try walk(in: node, closure: closure)
		
		skipping = nil
		canVisit = true
	}
	
	public func stop() {
		canVisit = false
	}
	
	public func skip(node: T) {
		skipping = node
	}
	
	private func walk(in node: T, closure: @escaping (T) throws -> Void) rethrows {
		if let skipping, node.isDescendant(of: skipping) {
			return
		}
		
		if canVisit {
			try closure(node)
		}

		try visitChildren(of: node, closure: closure)
	}
	
	private func visitChildren(of node: T, closure: @escaping (T) throws -> Void) rethrows {
		for child in node.children {
			if let skipping, child.isDescendant(of: skipping) {
				continue
			}
			
			if canVisit {
				try closure(child)
				try visitChildren(of: child, closure: closure)
			} else {
				break
			}
		}
	}
}
