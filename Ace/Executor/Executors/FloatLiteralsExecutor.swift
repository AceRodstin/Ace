//
//  FloatLiteralsExecutor.swift
//  Executor
//
//  Created by Ace Rodstin on 2/8/23.
//  Copyright © 2023 Ace Rodstin. All rights reserved.
//

import Foundation

extension Executor {
	final class FloatLiteralsExecutor {
		
		// MARK: - Methods
		
		func executeFloatLiteral(node: SyntacticNode) throws -> Symbol.Value {
			guard let child = node.children.first else {
				throw ExecutionError.internalError
			}
			
			switch child.kind {
			case .decimalFloatLiteral:
				return try executeLiteral(node: child)
			case .hexadecimalFloatLiteral:
				return try executeLiteral(node: child)
			default:
				throw ExecutionError.internalError
			}
		}
		
		private func executeLiteral(node: SyntacticNode) throws -> Symbol.Value {
			var string = node.joined()
			string = string.filter { $0 != "_" }
			
			if let value = Double(string) {
				return value
			} else {
				throw ExecutionError.internalError
			}
		}
	}
}
