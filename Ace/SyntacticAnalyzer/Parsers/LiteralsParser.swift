//
//  LiteralsParser.swift
//  SyntacticAnalyzer
//
//  Created by Ace Rodstin on 2/7/23.
//  Copyright © 2023 Ace Rodstin. All rights reserved.
//

import Foundation

extension SyntacticAnalyzer {
	final class LiteralsParser {
		
		// MARK: - Methods
		
		func parse(stream: Stream<Buffer>) throws -> SyntacticNode {
			return try parseLiteral(stream: stream)
		}
		
		private func parseLiteral(stream: Stream<Buffer>) throws -> SyntacticNode {
			let node = SyntacticNode(kind: .literal)
			
			let basicLiteral = try parseBasicLiteral(stream: stream)
			node.children.append(basicLiteral)
			
			return node
		}
		
		private func parseBasicLiteral(stream: Stream<Buffer>) throws -> SyntacticNode {
			let peeked = try peek(from: stream)
			
			guard case .literal(let literal) = peeked else {
				throw ParsingError.internalError
			}
			
			let node = SyntacticNode(kind: .basicLiteral)
			
			switch literal.kind {
			case .integer(_):
				let integerLiteral = try parseIntegerLiteral(stream: stream)
				node.children.append(integerLiteral)
			case .float(_):
				let floatLiteral = try parseFloatLiteral(stream: stream)
				node.children.append(floatLiteral)
			default:
				throw ParsingError.internalError
			}
			
			return node
		}
		
		private func parseIntegerLiteral(stream: Stream<Buffer>) throws -> SyntacticNode {
			let parser = IntegerLiteralsParser()
			return try parser.parse(stream: stream)
		}
		
		private func parseFloatLiteral(stream: Stream<Buffer>) throws -> SyntacticNode {
			let parser = FloatingPointLiteralsParser()
			return try parser.parse(stream: stream)
		}
	}
}
