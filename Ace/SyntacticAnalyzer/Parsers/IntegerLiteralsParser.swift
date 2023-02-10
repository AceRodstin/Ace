//
//  IntegerLiteralsParser.swift
//  SyntacticAnalyzer
//
//  Created by Ace Rodstin on 2/7/23.
//  Copyright © 2023 Ace Rodstin. All rights reserved.
//

import Foundation

extension SyntacticAnalyzer {
	final class IntegerLiteralsParser {
		
		// MARK: - Methods
		
		func parse(stream: Stream<Buffer>) throws -> SyntacticNode {
			let got = try get(from: stream)
			
			guard case .literal(let literal) = got else {
				try put(element: got, to: stream)
				throw ParsingError.internalError
			}
			
			guard case .integer(let base) = literal.kind else {
				try put(element: got, to: stream)
				throw ParsingError.internalError
			}
			
			let stream = Stream(literal.value)
			return try parseIntegerLiteral(base: base, stream: stream)
		}
		
		private func parseIntegerLiteral(base: DigitBase, stream: Stream<String>) throws -> SyntacticNode {
			let node = SyntacticNode(kind: .integerLiteral)
			
			switch base {
			case .decimal:
				let decimalLiteral = try parseDecimalLiteral(stream: stream)
				node.children.append(decimalLiteral)
			default:
				let literal = try parseLiteral(base: base, stream: stream)
				node.children.append(literal)
			}
			
			return node
		}
		
		private func parseDecimalLiteral(stream: Stream<String>) throws -> SyntacticNode {
			let got = try get(from: stream)
			let node = SyntacticNode(kind: .decimalLiteral)
			
			let digit = try parseDigit(character: got, base: .decimal, stream: stream)
			node.children.append(digit)
			
			if stream.hasMore {
				let got = try get(from: stream)
				
				if isUnderscore(character: got) {
					let underscore = try parseUnderscore(character: got, stream: stream)
					node.children.append(underscore)
				} else {
					try put(element: got, to: stream)
				}
				
				let decimalDigits = try parseDigits(base: .decimal, stream: stream)
				node.children.append(decimalDigits)
			}
			
			return node
		}
		
		private func parseLiteral(base: DigitBase, stream: Stream<String>) throws -> SyntacticNode {
			let kind: SyntacticNode.Kind
			let node: SyntacticNode
			
			switch base {
			case .decimal:
				kind = .decimalLiteral
			case .binary:
				kind = .binaryLiteral
			case .octal:
				kind = .octalLiteral
			case .hexadecimal:
				kind = .hexadecimalLiteral
			}
			
			node = SyntacticNode(kind: kind)
			
			let head = try parseHead(base: base, stream: stream)
			node.children.append(head)
			
			let got = try get(from: stream)
			
			if isUnderscore(character: got) {
				let underscore = try parseUnderscore(character: got, stream: stream)
				node.children.append(underscore)
			} else {
				try put(element: got, to: stream)
			}
			
			let digits = try parseDigits(base: base, stream: stream)
			node.children.append(digits)
			
			return node
		}
		
		func parseDigits(base: DigitBase, stream: Stream<String>) throws -> SyntacticNode {
			let kind: SyntacticNode.Kind
			let node: SyntacticNode
			
			switch base {
			case .decimal:
				kind = .decimalDigits
			case .binary:
				kind = .binaryDigits
			case .octal:
				kind = .octalDigits
			case .hexadecimal:
				kind = .hexadecimalDigits
			}
		
			node = SyntacticNode(kind: kind)
			
			let got = try get(from: stream)
			let digit = try parseDigit(character: got, base: base, stream: stream)
			node.children.append(digit)
			
			while stream.hasMore {
				let got = try get(from: stream)
				
				if isUnderscore(character: got) {
					let underscore = try parseUnderscore(character: got, stream: stream)
					node.children.append(underscore)
					continue
				}
				
				let digit = try parseDigit(character: got, base: base, stream: stream)
				node.children.append(digit)
			}
			
			return node
		}
		
		private func parseUnderscore(character: Character, stream: Stream<String>) throws -> SyntacticNode {
			try validateUnderscore(character: character, stream: stream)
			return SyntacticNode(kind: .nonTerminal, value: character)
		}
		
		private func parseDigit(character: Character, base: DigitBase, stream: Stream<String>) throws -> SyntacticNode {
			let parser = CharactersParser()
			
			do {
				switch base {
				case .decimal:
					return try parser.parseDecimalDigit(character: character)
				case .binary:
					return try parser.parseBinaryDigit(character: character)
				case .octal:
					return try parser.parseOctalDigit(character: character)
				case .hexadecimal:
					return try parser.parseHexadecimalDigit(character: character)
				}
			} catch {
				try put(element: character, to: stream)
				throw ParsingError.internalError
			}
		}
		
		private func validateUnderscore(character: Character, stream: Stream<String>) throws {
			let peeked = stream.peek()
			let isValid: Bool
			
			switch peeked {
			case .beginOfStream:
				isValid = false
			case .buffered(let character):
				// Second character cannot be underscore
				isValid = !isUnderscore(character: character)
			case .endOfStream:
				// Last character cannot be underscore
				isValid = false
			}
			
			if !isValid {
				try put(element: character, to: stream)
				throw ParsingError.internalError
			}
		}
		
		private func parseHead(base: DigitBase, stream: Stream<String>) throws -> SyntacticNode {
			let character = try get(from: stream)
			
			guard character == "0" else {
				try put(element: character, to: stream)
				throw ParsingError.internalError
			}
			
			let nextCharacter = try get(from: stream)
			let isValid: Bool
			
			switch base {
			case .binary:
				isValid = nextCharacter == "b"
			case .octal:
				isValid = nextCharacter == "o"
			case .hexadecimal:
				isValid = nextCharacter == "x"
			case .decimal:
				isValid = false
			}
			
			if isValid {
				let head = String([character, nextCharacter])
				return SyntacticNode(kind: .nonTerminal, value: head)
			} else {
				try put(element: character, to: stream)
				throw ParsingError.internalError
			}
		}
		
		private func isUnderscore(character: Character) -> Bool {
			return character == "_"
		}
	}
}
