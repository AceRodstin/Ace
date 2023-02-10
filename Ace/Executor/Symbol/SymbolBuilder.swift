//
//  SymbolBuilder.swift
//  SemanticAnalyzer
//
//  Created by Ace Rodstin on 2/9/23.
//  Copyright © 2023 Ace Rodstin. All rights reserved.
//

import Foundation

final class SymbolBuilder {
	
	// MARK: - Types
	
	enum BuildingError: Error {
		case internalError
	}
	
	// MARK: - Methods
	
	func build(collector: SemanticCollector) throws -> Symbol {
		guard let id = collector.id, let mutability = collector.mutability else {
			throw BuildingError.internalError
		}
		
		let type = try defineType(collector: collector)
		return Symbol(id: id, type: type, mutability: mutability, value: collector.value)
	}
	
	private func defineType(collector: SemanticCollector) throws -> BaseType {
		switch (collector.type, collector.value) {
		case (nil, let value?):
			return try inferredType(value: value)
		case (let type?, nil):
			return type
		case (let type?, let value?):
			let inferredType = try inferredType(value: value)
			
			if type == inferredType {
				return type
			} else {
				throw BuildingError.internalError
			}
		case (nil, nil):
			throw BuildingError.internalError
		}
	}
	
	private func inferredType(value: Symbol.Value) throws -> BaseType {
		switch value {
		case is Int:
			return .integer
		case is Double:
			return .double
		default:
			throw BuildingError.internalError
		}
	}
}
