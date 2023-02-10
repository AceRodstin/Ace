//
//  Node.swift
//  Tools
//
//  Created by Ace Rodstin on 1/10/23.
//  Copyright © 2023 Ace Rodstin. All rights reserved.
//

import Foundation

public protocol Node: AnyObject {
	var id: UUID { get }
	var children: [Self] { get set }
	
	func isDescendant(of node: Self) -> Bool
}

extension Node {
	public func isDescendant(of node: Self) -> Bool {
		var isDescendant = false
		let walker = NodeWalker<Self>()
		
		walker.visit(node: node) { [weak self] node in
			guard let self else {
				return
			}
			
			if node.id == self.id {
				isDescendant = true
				walker.stop()
			}
		}
		
		return isDescendant
	}
}
