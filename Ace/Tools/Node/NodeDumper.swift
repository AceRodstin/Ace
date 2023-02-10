//
//  NodeDumper.swift
//  Tools
//
//  Created by Ace Rodstin on 1/5/23.
//  Copyright © 2023 Ace Rodstin. All rights reserved.
//

import Foundation

public final class NodeDumper<T> where T: Node, T: CustomStringConvertible {
	
	// MARK: - Properties
	
	private var path: [T] = []
	private var result = ""
	
	// MARK: - Methods

	public func dump(_ node: T) -> String {
		prepare()
		gather(node: node)
		return result
	}
	
	private func prepare() {
		path.removeAll()
		result.removeAll()
	}
	
	private func gather(node: T) {
		path.append(node)
		
		dumpTree()
		
		let depth = path.count
		
		for (index, child) in node.children.enumerated() {
			let isFirst = index == node.children.startIndex
			
			if !isFirst {
				path = path.dropLast(path.count - depth)
			}
				
			gather(node: child)
		}
	}
	
	private func dumpTree() {
		guard !path.isEmpty else {
			return
		}
		
		guard path.count > 1 else {
			let node = path[path.startIndex]
			result += node.description
			return
		}
		
		let indent = createIndent()
		let mark = createMark()
		
		if let node = path.last {
			let description = node.description
			result += "\n\(indent)\(mark)\(description)"
		}
	}
	
	private func createIndent() -> String {
		var indent: String = ""
		
		for (index, node) in path.enumerated() {
			guard index + 1 != path.endIndex - 1 else {
				break
			}
			
			let nextNode = path[index + 1]
			
			let childrenIndex = node.children.firstIndex { $0.id == nextNode.id }
			let childrenCount = node.children.count
			let isLastChild = childrenIndex == childrenCount - 1
			
			if isLastChild {
				indent += "   "
			} else {
				indent += "│  "
			}
		}
		
		return indent
	}
	
	private func createMark() -> String {
		let lastNode = path[path.endIndex - 1]
		let prevNode = path[path.endIndex - 2]
		
		let childrenIndex = prevNode.children.firstIndex { $0.id == lastNode.id }
		let childrenCount = prevNode.children.count
		
		let isLastChild = childrenIndex == childrenCount - 1
		
		return isLastChild ? "└─ " : "├─ "
	}
}
