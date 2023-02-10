//
//  ExpressionsParser.swift
//  SyntacticAnalyzer
//
//  Created by Ace Rodstin on 2/7/23.
//  Copyright © 2023 Ace Rodstin. All rights reserved.
//

import Foundation

extension SyntacticAnalyzer {
	final class ExpressionsParser {
		
		// MARK: - Methods
		
		func parse(stream: Stream<Buffer>) throws -> SyntacticNode {
			return try parseExpression(stream: stream)
		}
		
		private func parseExpression(stream: Stream<Buffer>) throws -> SyntacticNode {
			// Parse unary expression
			let expression = try createExpression(stream: stream)
			
			if stream.hasMore {
				return try createExpression(lhs: expression, stream: stream)
			} else {
				// If stream hasn't more, return expression
				return expression
			}
		}
		
		private func createExpression(stream: Stream<Buffer>) throws -> SyntacticNode {
			let unaryExpression = try parseUnaryExpression(stream: stream)
			return createExpression(unaryExpression)
		}
		
		private func createExpression(lhs: SyntacticNode, stream: Stream<Buffer>) throws -> SyntacticNode {
			// Parse operator
			let op = try parseBinaryOperator(stream: stream)
			// Define operator precedence
			let precedenceGroup = try precedenceGroup(of: op)
			
			switch precedenceGroup {
			case .addition:
				// If addition precedence group
				// Imagine unary expression as left hand side operand
				return try createAdditionExpression(lhs: lhs, operator: op, stream: stream)
			case .multiplication:
				// If multiplication precedence group
				// Imagine unary expression as left hand side operand
				return try createMultiplicationExpression(lhs: lhs, operator: op, stream: stream)
			}
		}
		
		private func createAdditionExpression(lhs: SyntacticNode, operator op: SyntacticNode, stream: Stream<Buffer>) throws -> SyntacticNode {
			// Parse stream reminder as right hand side operand
			let rhs = try parseExpression(stream: stream) // Recursion
			// Return result
			return createExpression(lhs: lhs, operator: op, rhs: rhs)
		}
		
		private func createMultiplicationExpression(lhs: SyntacticNode, operator op: SyntacticNode, stream: Stream<Buffer>) throws -> SyntacticNode {
			// Parse unary expression
			// Imagine unary expression as right hand side operand
			let rhs = try createExpression(stream: stream)
			
			if stream.hasMore {
				// Imagine multiplication as left hand side operand
				let lhs = createExpression(lhs: lhs, operator: op, rhs: rhs)
				// Parse operator
				let op = try parseBinaryOperator(stream: stream)
				// Parse stream reminder as right hand side operand
				let rhs = try parseExpression(stream: stream) // Recursion
				// Return result
				return createExpression(lhs: lhs, operator: op, rhs: rhs)
			} else {
				// If stream hasn't more, return expression
				return createExpression(lhs: lhs, operator: op, rhs: rhs)
			}
		}
		
		private func parseUnaryExpression(stream: Stream<Buffer>) throws -> SyntacticNode {
			let node = SyntacticNode(kind: .unaryExpression)
			let peeked = try peek(from: stream)
			
			if case .punctuator(let punctuator) = peeked {
				if let unaryOperator = try parseUnaryOperator(punctuator: punctuator, stream: stream) {
					node.children.append(unaryOperator)
				}
			}
			
			let primaryExpression = try parsePrimaryExpression(stream: stream)
			node.children.append(primaryExpression)
			
			return node
		}
		
		private func parsePrimaryExpression(stream: Stream<Buffer>) throws -> SyntacticNode {
			let node = SyntacticNode(kind: .primaryExpression)
			
			let operand = try parseOperand(stream: stream)
			node.children.append(operand)
			
			return node
		}
		
		private func parseOperand(stream: Stream<Buffer>) throws -> SyntacticNode {
			let node = SyntacticNode(kind: .operand)
			let peeked = try peek(from: stream)
			
			switch peeked {
			case .literal(_):
				let literal = try parseLiteral(stream: stream)
				node.children.append(literal)
			case .punctuator(.leftParenthesis):
				try parserParenthesizedExpression(for: node, stream: stream)
			case .identifier(_):
				let operandName = try parseOperandName(stream: stream)
				node.children.append(operandName)
			default:
				throw ParsingError.internalError
			}
			
			return node
		}
		
		private func parserParenthesizedExpression(for node: SyntacticNode, stream: Stream<Buffer>) throws {
			var leftParenthesisCount = 0
			var rightParenthesisCount = 0
			var buffer: Buffer = []
			
		loop: while stream.hasMore {
				let got = try get(from: stream)
				
				guard case .punctuator(let punctuator) = got else {
					buffer.append(got)
					continue
				}
				
				switch punctuator {
				case .leftParenthesis:
					if leftParenthesisCount == 0 {
						let leftParenthesisNode = SyntacticNode(kind: .nonTerminal, value: punctuator.rawValue)
						node.children.append(leftParenthesisNode)
					}
					
					leftParenthesisCount += 1
				case .rightParenthesis:
					rightParenthesisCount += 1
					
					if leftParenthesisCount == rightParenthesisCount {
						let stream = Stream(buffer)
						let expression = try parseExpression(stream: stream)
						node.children.append(expression)
						
						let rightParenthesisNode = SyntacticNode(kind: .nonTerminal, value: punctuator.rawValue)
						node.children.append(rightParenthesisNode)
						
						break loop
					}
				default:
					buffer.append(got)
				}
			}
			
			if leftParenthesisCount != rightParenthesisCount {
				throw ParsingError.internalError
			}
		}
		
		private func parseOperandName(stream: Stream<Buffer>) throws -> SyntacticNode {
			let node = SyntacticNode(kind: .operandName)
			
			let identifier = try parseIdentifier(stream: stream)
			node.children.append(identifier)
			
			return node
		}
		
		private func parseUnaryOperator(punctuator: Punctuator, stream: Stream<Buffer>) throws -> SyntacticNode? {
			switch punctuator {
			case .plus, .minus, .asterisk, .slash:
				return try parseUnaryOperator(stream: stream)
			default:
				return nil
			}
		}
		
		private func parseLiteral(stream: Stream<Buffer>) throws -> SyntacticNode {
			let parser = LiteralsParser()
			return try parser.parse(stream: stream)
		}
		
		private func parseUnaryOperator(stream: Stream<Buffer>) throws -> SyntacticNode {
			let operatorsParser = OperatorsParser()
			return try operatorsParser.parseUnaryOperator(stream: stream)
		}
		
		private func parseBinaryOperator(stream: Stream<Buffer>) throws -> SyntacticNode {
			let operatorsParser = OperatorsParser()
			return try operatorsParser.parseBinaryOperator(stream: stream)
		}
		
		private func parseIdentifier(stream: Stream<Buffer>) throws -> SyntacticNode {
			let parser = IdentifiersParser()
			return try parser.parseIdentifier(stream: stream)
		}
		
		private func createExpression(_ unaryExpression: SyntacticNode) -> SyntacticNode {
			let node = SyntacticNode(kind: .expression)
			node.children.append(unaryExpression)
			return node
		}
		
		private func createExpression(lhs lhsExpression: SyntacticNode, operator binaryOperator: SyntacticNode, rhs rhsExpression: SyntacticNode) -> SyntacticNode {
			let node = SyntacticNode(kind: .expression)
			node.children.append(lhsExpression)
			node.children.append(binaryOperator)
			node.children.append(rhsExpression)
			return node
		}
		
		private func precedenceGroup(of binaryOperator: SyntacticNode) throws -> Operator.PrecedenceGroup {
			let string = binaryOperator.joined()
			
			if let op = Operator(rawValue: string) {
				return op.precedenceGroup
			} else {
				throw ParsingError.internalError
			}
		}
	}
}
