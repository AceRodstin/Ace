//
//  ExpressionsExecutor.swift
//  Executor
//
//  Created by Ace Rodstin on 2/8/23.
//  Copyright © 2023 Ace Rodstin. All rights reserved.
//

import Foundation

extension Executor {
	final class ExpressionsExecutor {
		
		// MARK: - Properties
		
		weak var delegate: ExecutorDelegate?
		
		// MARK: - Methods
		
		func executeExpression(node: SyntacticNode) throws -> Symbol.Value {
			let unaryExpression = node.children.first { $0.kind == .unaryExpression }
			
			if let unaryExpression {
				return try executeUnaryExpression(node: unaryExpression)
			}
			
			let lhs = node.children.first { $0.kind == .expression }
			let op = node.children.first { $0.kind == .binaryOperator }
			let rhs = node.children.last { $0.kind == .expression }
			
			if let lhs, let op, let rhs {
				return try execute(expression: lhs, operator: op, expression: rhs)
			} else {
				throw ExecutionError.internalError
			}
		}
		
		private func executeUnaryExpression(node: SyntacticNode) throws -> Symbol.Value {
			let primaryExpression = node.children.first { $0.kind == .primaryExpression }

			guard let primaryExpression else {
				throw ExecutionError.internalError
			}
			
			return try executePrimaryExpression(node: primaryExpression)
		}
		
		private func executePrimaryExpression(node: SyntacticNode) throws -> Symbol.Value {
			let operand = node.children.first { $0.kind == .operand }
			
			guard let operand else {
				throw ExecutionError.internalError
			}
			
			return try executeOperand(node: operand)
		}
		
		private func executeOperand(node: SyntacticNode) throws -> Symbol.Value {
			if let literal = node.children.first(where: { $0.kind == .literal }) {
				return try executeLiteral(node: literal)
			}
			
			if let expression = node.children.first(where: { $0.kind == .expression }) {
				return try executeExpression(node: expression)
			}
			
			if let operandName = node.children.first(where: { $0.kind == .operandName }) {
				return try executeOperandName(node: operandName)
			}
			
			throw ExecutionError.internalError
		}
		
		private func executeLiteral(node: SyntacticNode) throws -> Symbol.Value {
			let basicLiteral = node.children.first { $0.kind == .basicLiteral }
			
			guard let basicLiteral else {
				throw ExecutionError.internalError
			}
			
			return try executeBasicLiteral(node: basicLiteral)
		}
		
		private func executeBasicLiteral(node: SyntacticNode) throws -> Symbol.Value {
			let integerLiteral = node.children.first { $0.kind == .integerLiteral }
			let floatLiteral = node.children.first { $0.kind == .floatLiteral }
			
			if let integerLiteral {
				return try executeIntegerLiteral(node: integerLiteral)
			} else if let floatLiteral {
				return try executeFloatLiteral(node: floatLiteral)
			} else {
				throw ExecutionError.internalError
			}
		}
		
		private func executeIntegerLiteral(node: SyntacticNode) throws -> Symbol.Value {
			let executor = IntegerLiteralsExecutor()
			return try executor.executeIntegerLiteral(node: node)
		}
		
		private func executeFloatLiteral(node: SyntacticNode) throws -> Symbol.Value {
			let executor = FloatLiteralsExecutor()
			return try executor.executeFloatLiteral(node: node)
		}
		
		private func executeOperandName(node: SyntacticNode) throws -> Symbol.Value {
			let identifier = node.joined()
			let value = try delegate?.value(of: identifier)
			
			if let value {
				return value
			} else {
				return ExecutionError.internalError
			}
		}
		
		private func executeOperator(node: SyntacticNode) throws -> Operator {
			let string = node.joined()
			
			if let op = Operator(rawValue: string) {
				return op
			} else {
				throw ExecutionError.internalError
			}
		}
		
		private func execute(expression lhs: SyntacticNode, operator op: SyntacticNode, expression rhs: SyntacticNode) throws -> Symbol.Value {
			let lhs = try executeExpression(node: lhs)
			let op = try executeOperator(node: op)
			let rhs = try executeExpression(node: rhs)
			return try execute(lhs: lhs, operator: op, rhs: rhs)
		}
		
		private func execute(lhs: Symbol.Value, operator op: Operator, rhs: Symbol.Value) throws -> Symbol.Value {
			switch op {
			case .addition:
				return try executeAddition(lhs: lhs, rhs: rhs)
			case .subtraction:
				return try executeSubtraction(lhs: lhs, rhs: rhs)
			case .multiplication:
				return try executeMultiplication(lhs: lhs, rhs: rhs)
			case .division:
				return try executeDivision(lhs: lhs, rhs: rhs)
			}
		}
		
		private func executeAddition(lhs: Symbol.Value, rhs: Symbol.Value) throws -> Symbol.Value {
			switch (lhs, rhs) {
			case (let lhs as Int, let rhs as Int):
				return lhs + rhs
			case (let lhs as Double, let rhs as Double):
				return lhs + rhs
			case (let lhs as Int, let rhs as Double):
				return Double(lhs) + rhs
			case (let lhs as Double, let rhs as Int):
				return lhs + Double(rhs)
			default:
				throw ExecutionError.internalError
			}
		}
		
		private func executeSubtraction(lhs: Symbol.Value, rhs: Symbol.Value) throws -> Symbol.Value {
			switch (lhs, rhs) {
			case (let lhs as Int, let rhs as Int):
				return lhs - rhs
			case (let lhs as Double, let rhs as Double):
				return lhs - rhs
			case (let lhs as Int, let rhs as Double):
				return Double(lhs) - rhs
			case (let lhs as Double, let rhs as Int):
				return lhs - Double(rhs)
			default:
				throw ExecutionError.internalError
			}
		}
		
		private func executeMultiplication(lhs: Symbol.Value, rhs: Symbol.Value) throws -> Symbol.Value {
			switch (lhs, rhs) {
			case (let lhs as Int, let rhs as Int):
				return lhs * rhs
			case (let lhs as Double, let rhs as Double):
				return lhs * rhs
			case (let lhs as Int, let rhs as Double):
				return Double(lhs) * rhs
			case (let lhs as Double, let rhs as Int):
				return lhs * Double(rhs)
			default:
				throw ExecutionError.internalError
			}
		}
		
		private func executeDivision(lhs: Symbol.Value, rhs: Symbol.Value) throws -> Symbol.Value {
			switch (lhs, rhs) {
			case (let lhs as Int, let rhs as Int):
				return lhs / rhs
			case (let lhs as Double, let rhs as Double):
				return lhs / rhs
			case (let lhs as Int, let rhs as Double):
				return Double(lhs) / rhs
			case (let lhs as Double, let rhs as Int):
				return lhs / Double(rhs)
			default:
				throw ExecutionError.internalError
			}
		}
	}
}
