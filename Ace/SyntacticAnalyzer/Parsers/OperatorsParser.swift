//
//  OperatorsParser.swift
//  SyntacticAnalyzer
//
//  Created by Ace Rodstin on 2/7/23.
//  Copyright © 2023 Ace Rodstin. All rights reserved.
//

import Foundation

extension SyntacticAnalyzer {
	final class OperatorsParser {
		
		// MARK: - Methods
		
		func parseBinaryOperator(stream: Stream<Buffer>) throws -> SyntacticNode {
			let peeked = try peek(from: stream)
			
			guard case .punctuator(let punctuator) = peeked else {
				throw ParsingError.internalError
			}
			
			let node = SyntacticNode(kind: .binaryOperator)
			
			switch punctuator {
			case .plus, .minus:
				let additionGroupOperator = try parseAdditionGroupOperator(stream: stream)
				node.children.append(additionGroupOperator)
			case .asterisk, .slash:
				let multiplicationGroupOperator = try parseMultiplicationGroupOperator(stream: stream)
				node.children.append(multiplicationGroupOperator)
			default:
				throw ParsingError.internalError
			}
			
			return node
		}
		
		func parseUnaryOperator(stream: Stream<Buffer>) throws -> SyntacticNode {
			let got = try get(from: stream)
			
			guard case .punctuator(let punctuator) = got else {
				try put(element: got, to: stream)
				throw ParsingError.internalError
			}
			
			let allowedPunctuators: [Punctuator] = [.plus, .minus]
			
			if allowedPunctuators.contains(punctuator) {
				let node = SyntacticNode(kind: .unaryOperator)
				
				let punctuatorNode = SyntacticNode(kind: .nonTerminal, value: punctuator.rawValue)
				node.children.append(punctuatorNode)
				
				return node
			} else {
				try put(element: got, to: stream)
				throw ParsingError.internalError
			}
		}
		
		func parseAssignOperator(stream: Stream<Buffer>) throws -> SyntacticNode {
			let got = try get(from: stream)
			
			guard case .punctuator(let punctuator) = got else {
				try put(element: got, to: stream)
				throw ParsingError.internalError
			}
			
			guard case .equal = punctuator else {
				try put(element: got, to: stream)
				throw ParsingError.internalError
			}
			
			let node = SyntacticNode(kind: .assignOperator)
			
			let equalNode = SyntacticNode(kind: .nonTerminal, value: punctuator.rawValue)
			node.children.append(equalNode)
			
			return node
		}
		
		private func parseAdditionGroupOperator(stream: Stream<Buffer>) throws -> SyntacticNode {
			let got = try get(from: stream)
			
			guard case .punctuator(let punctuator) = got else {
				try put(element: got, to: stream)
				throw ParsingError.internalError
			}
			
			switch punctuator {
			case .plus, .minus:
				let node = SyntacticNode(kind: .additionGroupOperator)
				
				let punctuatorNode = SyntacticNode(kind: .nonTerminal, value: punctuator.rawValue)
				node.children.append(punctuatorNode)
				
				return node
			default:
				try put(element: got, to: stream)
				throw ParsingError.internalError
			}
		}
		
		private func parseMultiplicationGroupOperator(stream: Stream<Buffer>) throws -> SyntacticNode {
			let got = try get(from: stream)
			
			guard case .punctuator(let punctuator) = got else {
				try put(element: got, to: stream)
				throw ParsingError.internalError
			}
			
			switch punctuator {
			case .asterisk, .slash:
				let node = SyntacticNode(kind: .multiplicationGroupOperator)
				
				let punctuatorNode = SyntacticNode(kind: .nonTerminal, value: punctuator.rawValue)
				node.children.append(punctuatorNode)
				
				return node
			default:
				try put(element: got, to: stream)
				throw ParsingError.internalError
			}
		}
	}
}
