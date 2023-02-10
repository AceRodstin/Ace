//
//  BinaryNode.swift
//  Tools
//
//  Created by Ace Rodstin on 1/11/23.
//  Copyright © 2023 Ace Rodstin. All rights reserved.
//

import Foundation

public enum BinaryNodeAlignment {
	case left
	case right
}

public protocol BinaryNode: Node {
	var alignment: BinaryNodeAlignment? { get set }
	var leftChild: Self? { get set }
	var rightChild: Self? { get set }
}

extension BinaryNode {
	public var leftChild: Self? {
		get { getChildren(.left) }
		set { setChildren(.left, newValue) }
	}
	
	public var rightChild: Self? {
		get { getChildren(.right) }
		set { setChildren(.right, newValue) }
	}
	
	fileprivate func getChildren(_ alignment: BinaryNodeAlignment) -> Self? {
		return children.first { $0.alignment == alignment }
	}
	
	fileprivate func setChildren(_ alignment: BinaryNodeAlignment, _ newValue: Self?) {
		let index = children.firstIndex { $0.alignment == .left }
		
		if let newValue {
			newValue.alignment = alignment
			
			if let index {
				children[index] = newValue
			} else {
				children.append(newValue)
			}
		} else {
			if let index {
				children.remove(at: index)
			}
		}
	}
}
