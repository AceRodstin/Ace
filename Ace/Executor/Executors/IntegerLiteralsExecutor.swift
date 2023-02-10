//
//  IntegerLiteralsExecutor.swift
//  Executor
//
//  Created by Ace Rodstin on 2/8/23.
//  Copyright © 2023 Ace Rodstin. All rights reserved.
//

import Foundation

extension Executor {
	final class IntegerLiteralsExecutor {
		
		// MARK: - Methods
		
		func executeIntegerLiteral(node: SyntacticNode) throws -> Symbol.Value {
			guard let child = node.children.first else {
				throw ExecutionError.internalError
			}
			
			switch child.kind {
			case .decimalLiteral:
				return try executeDecimalLiteral(node: child)
			case .binaryLiteral:
				return try executeBinaryLiteral(node: child)
			case .octalLiteral:
				return try executeOctalLiteral(node: child)
			case .hexadecimalLiteral:
				return try executeHexadecimalLiteral(node: child)
			default:
				throw ExecutionError.internalError
			}
		}
		
		private func executeDecimalLiteral(node: SyntacticNode) throws -> Symbol.Value {
			return try executeLiteral(base: .decimal, node: node)
		}
		
		private func executeBinaryLiteral(node: SyntacticNode) throws -> Symbol.Value {
			let binaryDigits = node.children.first { $0.kind == .binaryDigits }
			
			guard let binaryDigits else {
				throw ExecutionError.internalError
			}
			
			return try executeLiteral(base: .binary, node: binaryDigits)
		}
		
		private func executeOctalLiteral(node: SyntacticNode) throws -> Symbol.Value {
			let octalDigits = node.children.first { $0.kind == .octalDigits }
			
			guard let octalDigits else {
				throw ExecutionError.internalError
			}
			
			return try executeLiteral(base: .octal, node: octalDigits)
		}
		
		private func executeHexadecimalLiteral(node: SyntacticNode) throws -> Symbol.Value {
			let hexadecimalDigits = node.children.first { $0.kind == .hexadecimalDigits }
			
			guard let hexadecimalDigits else {
				throw ExecutionError.internalError
			}
			
			return try executeLiteral(base: .hexadecimal, node: hexadecimalDigits)
		}
		
		private func executeLiteral(base: DigitBase, node: SyntacticNode) throws -> Symbol.Value {
			let literal = try plainLiteral(node: node)
			let baseValue = baseValue(base)
			var result = 0
			
			for (index, character) in literal.reversed().enumerated() {
				let numberValue = try numberValue(character: character, base: base)
				let decimalMultiplier = pow(Decimal(baseValue), index)
				let multiplier = Int(truncating: decimalMultiplier as NSNumber)
				result += numberValue * multiplier
			}
			
			return result
		}
		
		private func plainLiteral(node: SyntacticNode) throws -> String {
			var string = node.joined()
			string = string.filter { $0 != "_" }
			
			if string.isEmpty {
				throw ExecutionError.internalError
			} else {
				return string
			}
		}
		
		private func baseValue(_ base: DigitBase) -> Int {
			switch base {
			case .decimal:
				return 10
			case .binary:
				return 2
			case .octal:
				return 8
			case .hexadecimal:
				return 16
			}
		}
		
		private func numberValue(character: Character, base: DigitBase) throws -> Int {
			var value: Int?
			
			if base == .hexadecimal {
				value = character.hexDigitValue
			} else {
				value = character.wholeNumberValue
			}
			
			if let value {
				return value
			} else {
				throw ExecutionError.internalError
			}
		}
	}
}
