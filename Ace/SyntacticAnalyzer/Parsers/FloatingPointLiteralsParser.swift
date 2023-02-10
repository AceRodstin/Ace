//
//  FloatingPointLiteralsParser.swift
//  SyntacticAnalyzer
//
//  Created by Ace Rodstin on 2/7/23.
//  Copyright © 2023 Ace Rodstin. All rights reserved.
//

import Foundation

extension SyntacticAnalyzer {
	final class FloatingPointLiteralsParser {
		
		// MARK: - Methods
		
		func parse(stream: Stream<Buffer>) throws -> SyntacticNode {
			let got = try get(from: stream)
			
			guard case .literal(let literal) = got else {
				try put(element: got, to: stream)
				throw ParsingError.internalError
			}
			
			guard case .float(let base) = literal.kind else {
				try put(element: got, to: stream)
				throw ParsingError.internalError
			}
			
			let stream = Stream(literal.value)
			return try parseFloatLiteral(base: base, stream: stream)
		}
		
		private func parseFloatLiteral(base: DigitBase, stream: Stream<String>) throws -> SyntacticNode {
			let node = SyntacticNode(kind: .floatLiteral)
			
			switch base {
			case .decimal:
				let decimalFloatLiteral = try parseDecimalFloatLiteral(stream: stream)
				node.children.append(decimalFloatLiteral)
			case .hexadecimal:
				let hexadecimalFloatLiteral = try parseHexadecimalFloatLiteral(stream: stream)
				node.children.append(hexadecimalFloatLiteral)
			default:
				throw ParsingError.internalError
			}
			
			return node
		}
		
		private func parseDecimalFloatLiteral(stream: Stream<String>) throws -> SyntacticNode {
			let node = SyntacticNode(kind: .decimalFloatLiteral)
			
			let decimalDigits = try parseDigits(base: .decimal, stream: stream)
			node.children.append(decimalDigits)
			
			if stream.hasMore {
				let peeked = try peek(from: stream)
				
				if isDot(character: peeked) {
					try parseFraction(for: node, base: .decimal, stream: stream)
				}
				
				if stream.hasMore {
					let decimalExponent = try parseExponent(base: .decimal, stream: stream)
					node.children.append(decimalExponent)
				}
			}
			
			return node
		}
		
		private func parseHexadecimalFloatLiteral(stream: Stream<String>) throws -> SyntacticNode {
			let node = SyntacticNode(kind: .hexadecimalFloatLiteral)
			
			let head = try parseHead(stream: stream)
			node.children.append(head)
			
			let mantissa = try parseMantissa(stream: stream)
			node.children.append(mantissa)
			
			let exponent = try parseExponent(base: .hexadecimal, stream: stream)
			node.children.append(exponent)
			
			return node
		}
		
		private func parseHead(stream: Stream<String>) throws -> SyntacticNode {
			let character = try get(from: stream)
			
			guard character == "0" else {
				try put(element: character, to: stream)
				throw ParsingError.internalError
			}
			
			let nextCharacter = try get(from: stream)
			
			guard nextCharacter == "x" else {
				try put(element: character, to: stream)
				throw ParsingError.internalError
			}
			
			let head = String([character, nextCharacter])
			let node = SyntacticNode(kind: .nonTerminal, value: head)
			return node
		}
		
		private func parseMantissa(stream: Stream<String>) throws -> SyntacticNode {
			let node = SyntacticNode(kind: .hexadecimalMantissa)
			let peeked = try peek(from: stream)
			
			if isUnderscore(character: peeked) {
				let got = try get(from: stream)
				let underscore = SyntacticNode(kind: .nonTerminal, value: got)
				node.children.append(underscore)
			}
			
			let hexadecimalDigits = try parseDigits(base: .hexadecimal, stream: stream)
			node.children.append(hexadecimalDigits)
			
			if stream.hasMore {
				let peeked = try peek(from: stream)
				
				if isDot(character: peeked) {
					try parseFraction(for: node, base: .hexadecimal, stream: stream)
				}
			}
			
			return node
		}
		
		private func parseDigits(base: DigitBase, stream: Stream<String>) throws -> SyntacticNode {
			var decimalPart = ""
			
			while stream.hasMore {
				let got = try get(from: stream)
				
				if isDot(character: got) {
					try put(element: got, to: stream)
					break
				}
				
				if isExponent(character: got, base: base) {
					try put(element: got, to: stream)
					break
				}
				
				decimalPart.append(got)
			}
			
			let stream = Stream(decimalPart)
			let parser = IntegerLiteralsParser()
			return try parser.parseDigits(base: base, stream: stream)
		}
		
		private func parseFraction(for node: SyntacticNode, base: DigitBase, stream: Stream<String>) throws {
			let got = try get(from: stream)
			
			guard isDot(character: got) else {
				try put(element: got, to: stream)
				throw ParsingError.internalError
			}
			
			let dot = SyntacticNode(kind: .nonTerminal, value: got)
			node.children.append(dot)
			
			let digits = try parseDigits(base: base, stream: stream)
			node.children.append(digits)
		}
		
		private func parseExponent(base: DigitBase, stream: Stream<String>) throws -> SyntacticNode {
			let got = try get(from: stream)
			
			guard isExponent(character: got, base: base) else {
				try put(element: got, to: stream)
				throw ParsingError.internalError
			}
			
			let kind: SyntacticNode.Kind
			let node: SyntacticNode
			
			switch base {
			case .decimal:
				kind = .decimalExponent
			case .hexadecimal:
				kind = .hexadecimalExponent
			default:
				throw ParsingError.internalError
			}
			
			node = SyntacticNode(kind: kind)
			
			let exponent = SyntacticNode(kind: .nonTerminal, value: got)
			node.children.append(exponent)
			
			let peeked = try peek(from: stream)
			
			if isSign(character: peeked) {
				let got = try get(from: stream)
				let sign = SyntacticNode(kind: .nonTerminal, value: got)
				node.children.append(sign)
			}
			
			let decimalDigits = try parseDigits(base: .decimal, stream: stream)
			node.children.append(decimalDigits)
			
			return node
		}
		
		private func isUnderscore(character: Character) -> Bool {
			return character == "_"
		}
		
		private func isDot(character: Character) -> Bool {
			return character == "."
		}
		
		private func isExponent(character: Character, base: DigitBase) -> Bool {
			let lower = character.lowercased()
			
			switch base {
			case .decimal:
				return lower == "e"
			case .hexadecimal:
				return lower == "p"
			default:
				return false
			}
		}
		
		private func isSign(character: Character) -> Bool {
			return character == "+" || character == "-"
		}
	}
}
