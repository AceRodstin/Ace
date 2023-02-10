//
//  Record.swift
//  Scope
//
//  Created by Ace Rodstin on 2/9/23.
//  Copyright © 2023 Ace Rodstin. All rights reserved.
//

import Foundation

struct Record {
	
	// MARK: - Types
	
	typealias Id = Symbol.Id
	typealias Value = Symbol.Value
	
	// MARK: - Properties
	
	var id: Id
	var type: BaseType
	var value: Value?
	
	// MARK: - Lifecycle
	
	init(symbol: Symbol) {
		self.id = symbol.id
		self.type = symbol.type
		self.value = symbol.value
	}
}

// MARK: - CustomStringConvertible

extension Record: CustomStringConvertible {
	var description: String {
		var description = "\(id): \(type.rawValue)"
		
		if let value {
			description += " = \(value)"
		}
		
		return description
	}
}
