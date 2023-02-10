//
//  DeclarationsParser.swift
//  SyntacticAnalyzer
//
//  Created by Ace Rodstin on 2/7/23.
//  Copyright © 2023 Ace Rodstin. All rights reserved.
//

import Foundation

extension SyntacticAnalyzer {
	final class DeclarationsParser {
		
		// MARK: - Types
		
		private enum DeclarationKind {
			case constant
			case variable
		}
		
		// MARK: - Methods
		
		func parse(stream: Stream<Buffer>) throws -> SyntacticNode {
			return try parseDeclaration(stream: stream)
		}
		
		private func parseDeclaration(stream: Stream<Buffer>) throws -> SyntacticNode {
			let got = try get(from: stream)
			
			guard case .keyword(let keyword) = got else {
				try put(element: got, to: stream)
				throw ParsingError.internalError
			}
			
			let node = SyntacticNode(kind: .declaration)
			
			switch keyword {
			case .val:
				let constantDeclaration = SyntacticNode(kind: .constantDeclaration)
				
				let valNode = SyntacticNode(kind: .nonTerminal, value: keyword.rawValue)
				constantDeclaration.children.append(valNode)
				
				let specification = try parseSpecification(of: .constant, stream: stream)
				constantDeclaration.children.append(specification)
				
				node.children.append(constantDeclaration)
			case .var:
				let variableDeclaration = SyntacticNode(kind: .variableDeclaration)
				
				let varNode = SyntacticNode(kind: .nonTerminal, value: keyword.rawValue)
				variableDeclaration.children.append(varNode)
				
				let specification = try parseSpecification(of: .variable, stream: stream)
				variableDeclaration.children.append(specification)
				
				node.children.append(variableDeclaration)
			}
			
			return node
		}
		
		private func parseSpecification(of kind: DeclarationKind, stream: Stream<Buffer>) throws -> SyntacticNode {
			let nodeKind: SyntacticNode.Kind
			let node: SyntacticNode
			
			switch kind {
			case .constant:
				nodeKind = .constantSpecification
			case .variable:
				nodeKind = .variableSpecification
			}
			
			node = SyntacticNode(kind: nodeKind)
			
			let identifierList = try parseIdentifierList(stream: stream)
			node.children.append(identifierList)
			
			try parseTypeAnnotation(for: node, stream: stream)
			try parseInitialization(for: node, stream: stream)
			
			return node
		}
		
		private func parseTypeAnnotation(for node: SyntacticNode, stream: Stream<Buffer>) throws {
			let got = try get(from: stream)
			
			guard case .punctuator(let punctuator) = got else {
				try put(element: got, to: stream)
				throw ParsingError.internalError
			}
			
			switch punctuator {
			case .colon:
				let colonNode = SyntacticNode(kind: .nonTerminal, value: punctuator.rawValue)
				node.children.append(colonNode)
				
				let type = try parseType(stream: stream)
				node.children.append(type)
			default:
				try put(element: got, to: stream)
			}
		}
		
		private func parseInitialization(for node: SyntacticNode, stream: Stream<Buffer>) throws {
			guard stream.hasMore else {
				return
			}
			
			let got = try get(from: stream)
			
			guard case .punctuator(let punctuator) = got else {
				try put(element: got, to: stream)
				throw ParsingError.internalError
			}
			
			switch punctuator {
			case .equal:
				let equalNode = SyntacticNode(kind: .nonTerminal, value: punctuator.rawValue)
				node.children.append(equalNode)
				
				let expression = try parseExpression(stream: stream)
				node.children.append(expression)
			default:
				try put(element: got, to: stream)
			}
		}
		
		private func parseIdentifierList(stream: Stream<Buffer>) throws -> SyntacticNode {
			let identifiersParser = IdentifiersParser()
			return try identifiersParser.parseIdentifierList(stream: stream)
		}
		
		private func parseType(stream: Stream<Buffer>) throws -> SyntacticNode {
			let typesParser = TypesParser()
			return try typesParser.parse(stream: stream)
		}
		
		private func parseExpression(stream: Stream<Buffer>) throws -> SyntacticNode {
			let expressionsParser = ExpressionsParser()
			return try expressionsParser.parse(stream: stream)
		}
	}
}
