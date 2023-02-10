//
//  Scope.swift
//  Scope
//
//  Created by Ace Rodstin on 2/9/23.
//  Copyright © 2023 Ace Rodstin. All rights reserved.
//

import Foundation

final class Scope: ExecutorDelegate {
	
	// MARK: - Types
	
	enum ScopeError: Error {
		case internalError
	}
	
	// MARK: - Properties
	
	private let symbolTable = SymbolTable()
	
	var recordTable: RecordTable {
		let symbols = symbolTable.symbols
		return RecordTable(symbols: symbols)
	}
	
	// MARK: - Methods
	
	func declare(symbol: Symbol) throws {
		do {
			try symbolTable.insert(symbol)
		} catch {
			throw ScopeError.internalError
		}
	}
	
	func value(of identifier: Symbol.Id) throws -> Symbol.Value? {
		let symbol = symbolTable.symbol(with: identifier)
		
		if let symbol {
			return symbol.value
		} else {
			throw ScopeError.internalError
		}
	}
	
	func changeValue(of identifier: Symbol.Id, newValue: Symbol.Value) throws {
		do {
			try symbolTable.changeValue(of: identifier, newValue: newValue)
		} catch {
			throw ScopeError.internalError
		}
	}
}
