//
//  TypesParser.swift
//  SyntacticAnalyzer
//
//  Created by Ace Rodstin on 2/7/23.
//  Copyright © 2023 Ace Rodstin. All rights reserved.
//

import Foundation

extension SyntacticAnalyzer {
	final class TypesParser {
		
		// MARK: - Methods
		
		func parse(stream: Stream<Buffer>) throws -> SyntacticNode {
			return try parseType(stream: stream)
		}
		
		private func parseType(stream: Stream<Buffer>) throws -> SyntacticNode {
			let node = SyntacticNode(kind: .type)
			
			let typeName = try parseTypeName(stream: stream)
			node.children.append(typeName)
			
			return node
		}
		
		private func parseTypeName(stream: Stream<Buffer>) throws -> SyntacticNode {
			let node = SyntacticNode(kind: .typeName)
			
			let identifiersParser = IdentifiersParser()
			let identifier = try identifiersParser.parseIdentifier(stream: stream)
			node.children.append(identifier)
			
			return node
		}
	}
}
