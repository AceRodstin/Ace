//
//  IdentifiersParser.swift
//  SyntacticAnalyzer
//
//  Created by Ace Rodstin on 2/7/23.
//  Copyright © 2023 Ace Rodstin. All rights reserved.
//

import Foundation

extension SyntacticAnalyzer {
	final class IdentifiersParser {
		
		// MARK: - Methods
		
		func parseIdentifierList(stream: Stream<Buffer>) throws -> SyntacticNode {
			let node = SyntacticNode(kind: .identifierList)
			
			let identifier = try parseIdentifier(stream: stream)
			node.children.append(identifier)
			
			while stream.hasMore {
				let got = try get(from: stream)
				
				guard case .punctuator(let punctuator) = got else {
					try put(element: got, to: stream)
					break
				}
				
				guard case .coma = punctuator else {
					try put(element: got, to: stream)
					break
				}
				
				let comaNode = SyntacticNode(kind: .nonTerminal, value: punctuator.rawValue)
				node.children.append(comaNode)
				
				let identifier = try parseIdentifier(stream: stream)
				node.children.append(identifier)
			}
		
			return node
		}
		
		func parseIdentifier(stream: Stream<Buffer>) throws -> SyntacticNode {
			let got = try get(from: stream)
			
			guard case .identifier(let identifier) = got else {
				try put(element: got, to: stream)
				throw ParsingError.internalError
			}
			
			let stream = Stream(identifier)
			return try parseIdentifier(stream: stream)
		}
		
		private func parseIdentifier(stream: Stream<String>) throws -> SyntacticNode {
			let node = SyntacticNode(kind: .identifier)
			let got = try get(from: stream)
			
			let letter = try parseLetter(character: got)
			node.children.append(letter)
			
			while stream.hasMore {
				let got = try get(from: stream)
				
				if let letter = try? parseLetter(character: got) {
					node.children.append(letter)
				} else if let unicodeDigit = try? parseUnicodeDigit(character: got) {
					node.children.append(unicodeDigit)
				} else {
					throw ParsingError.internalError
				}
			}
			
			return node
		}
		
		private func parseLetter(character: Character) throws -> SyntacticNode {
			let charactersParser = CharactersParser()
			return try charactersParser.parseLetter(character: character)
		}
		
		private func parseUnicodeDigit(character: Character) throws -> SyntacticNode {
			let charactersParser = CharactersParser()
			return try charactersParser.parseUnicodeDigit(character: character)
		}
	}
}
