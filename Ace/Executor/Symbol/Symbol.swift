//
//  Symbol.swift
//  SemanticAnalyzer
//
//  Created by Ace Rodstin on 2/9/23.
//  Copyright © 2023 Ace Rodstin. All rights reserved.
//

import Foundation

final class Symbol {
	
	// MARK: - Types
	
	typealias Id = String
	typealias Value = Any
	
	enum Mutability {
		case constant
		case variable
	}
	
	// MARK: - Properties
	
	let id: Id
	let type: BaseType
	let mutability: Mutability
	var value: Value?
	
	// MARK: - Lifecycle
	
	init(id: Symbol.Id, type: BaseType, mutability: Symbol.Mutability, value: Symbol.Value? = nil) {
		self.id = id
		self.type = type
		self.mutability = mutability
		self.value = value
	}
}

// MARK: - Equatable

extension Symbol: Equatable {
	static func == (lhs: Symbol, rhs: Symbol) -> Bool {
		guard lhs.id == rhs.id else {
			return false
		}
		
		guard lhs.type == rhs.type else {
			return false
		}
		
		guard lhs.mutability == rhs.mutability else {
			return false
		}
		
		switch lhs.type {
		case .integer:
			return (lhs.value as? Int) == (rhs.value as? Int)
		case .double:
			return (lhs.value as? Double) == (rhs.value as? Double)
		}
	}
}
