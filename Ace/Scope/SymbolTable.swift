//
//  SymbolTable.swift
//  Scope
//
//  Created by Ace Rodstin on 2/9/23.
//  Copyright © 2023 Ace Rodstin. All rights reserved.
//

import Foundation

final class SymbolTable {
	
	// MARK: - Types
	
	enum SymbolTableError: Error {
		case internalError
	}
	
	// MARK: - Properties
	
	private var storage: [Symbol] = []
	
	var symbols: [Symbol] {
		return storage
	}
	
	// MARK: - Methods
	
	func insert(_ symbol: Symbol) throws {
		let alreadyExist = storage.contains { $0.id == symbol.id }
		
		if alreadyExist {
			throw SymbolTableError.internalError
		} else {
			storage.append(symbol)
		}
	}
	
	func symbol(with id: Symbol.Id) -> Symbol? {
		return storage.first { $0.id == id }
	}
	
	func changeValue(of id: Symbol.Id, newValue: Symbol.Value) throws {
		guard let symbol = symbol(with: id) else {
			throw SymbolTableError.internalError
		}
		
		guard case .variable = symbol.mutability else {
			throw SymbolTableError.internalError
		}
		
		symbol.value = newValue
	}
}
