//
//  StatementsParser.swift
//  SyntacticAnalyzer
//
//  Created by Ace Rodstin on 2/7/23.
//  Copyright © 2023 Ace Rodstin. All rights reserved.
//

import Foundation

extension SyntacticAnalyzer {
	final class StatementsParser {
		
		// MARK: - Methods
		
		func parse(stream: Stream<Buffer>) throws -> SyntacticNode {
			return try parseStatement(stream: stream)
		}
		
		private func parseStatement(stream: Stream<Buffer>) throws -> SyntacticNode {
			let peeked = try peek(from: stream)
			let node = SyntacticNode(kind: .statement)
			
			switch peeked {
			case .keyword(_):
				let declaration = try parseDeclaration(stream: stream)
				node.children.append(declaration)
			case .identifier(_):
				let simpleStatement = try parseSimpleStatement(stream: stream)
				node.children.append(simpleStatement)
			default:
				throw ParsingError.internalError
			}
			
			return node
		}
		
		private func parseDeclaration(stream: Stream<Buffer>) throws -> SyntacticNode {
			let parser = DeclarationsParser()
			return try parser.parse(stream: stream)
		}
		
		private func parseSimpleStatement(stream: Stream<Buffer>) throws -> SyntacticNode {
			let node = SyntacticNode(kind: .simpleStatement)
			
			let assignmentStatement = try parseAssignmentStatement(stream: stream)
			node.children.append(assignmentStatement)
			
			return node
		}
		
		private func parseAssignmentStatement(stream: Stream<Buffer>) throws -> SyntacticNode {
			let node = SyntacticNode(kind: .assignmentStatement)
			
			let identifier = try parseIdentifier(stream: stream)
			node.children.append(identifier)
			
			let assignOperator = try parseAssignOperator(stream: stream)
			node.children.append(assignOperator)
			
			let expression = try parseExpression(stream: stream)
			node.children.append(expression)
			
			return node
		}
		
		private func parseIdentifier(stream: Stream<Buffer>) throws -> SyntacticNode {
			let parser = IdentifiersParser()
			return try parser.parseIdentifier(stream: stream)
		}
		
		private func parseAssignOperator(stream: Stream<Buffer>) throws -> SyntacticNode {
			let got = try get(from: stream)
			let buffer = [got]
			let stream = Stream(buffer)
			
			let parser = OperatorsParser()
			return try parser.parseAssignOperator(stream: stream)
		}
		
		private func parseExpression(stream: Stream<Buffer>) throws -> SyntacticNode {
			let parser = ExpressionsParser()
			return try parser.parse(stream: stream)
		}
	}
}
