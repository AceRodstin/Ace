//
//  CharactersParser.swift
//  SyntacticAnalyzer
//
//  Created by Ace Rodstin on 2/7/23.
//  Copyright © 2023 Ace Rodstin. All rights reserved.
//

import Foundation

extension SyntacticAnalyzer {
	final class CharactersParser {
		
		// MARK: - Methods
		
		func parseLetter(character: Character) throws -> SyntacticNode {
			guard character != "_" else {
				let node = SyntacticNode(kind: .letter)
				
				let underscoreNode = SyntacticNode(kind: .nonTerminal, value: character)
				node.children.append(underscoreNode)
				
				return node
			}
			
			let node = SyntacticNode(kind: .letter)
			
			let unicodeLetter = try parseUnicodeLetter(character: character)
			node.children.append(unicodeLetter)
			
			return node
		}
		
		func parseDecimalDigit(character: Character) throws -> SyntacticNode {
			let allowedCharacters: Characters = .decimalDigits
			
			if allowedCharacters.contains(character) {
				let node = SyntacticNode(kind: .decimalDigit)
				
				let digitNode = SyntacticNode(kind: .nonTerminal, value: String(character))
				node.children.append(digitNode)
				
				return node
			} else {
				throw ParsingError.internalError
			}
		}
		
		func parseBinaryDigit(character: Character) throws -> SyntacticNode {
			let allowedCharacters: Characters = .binaryDigits
			
			if allowedCharacters.contains(character) {
				let node = SyntacticNode(kind: .binaryDigit)
				
				let digitNode = SyntacticNode(kind: .nonTerminal, value: String(character))
				node.children.append(digitNode)
				
				return node
			} else {
				throw ParsingError.internalError
			}
		}
		
		func parseOctalDigit(character: Character) throws -> SyntacticNode {
			let allowedCharacters: Characters = .octalDigits
			
			if allowedCharacters.contains(character) {
				let node = SyntacticNode(kind: .octalDigit)
				
				let digitNode = SyntacticNode(kind: .nonTerminal, value: String(character))
				node.children.append(digitNode)
				
				return node
			} else {
				throw ParsingError.internalError
			}
		}
		
		func parseHexadecimalDigit(character: Character) throws -> SyntacticNode {
			let allowedCharacters: Characters = .hexadecimalDigits
			
			if allowedCharacters.contains(character) {
				let node = SyntacticNode(kind: .hexadecimalDigit)
				
				let digitNode = SyntacticNode(kind: .nonTerminal, value: String(character))
				node.children.append(digitNode)
				
				return node
			} else {
				throw ParsingError.internalError
			}
		}
		
		func parseUnicodeLetter(character: Character) throws -> SyntacticNode {
			if character.isLetter {
				let node = SyntacticNode(kind: .unicodeLetter)
				
				let letterNode = SyntacticNode(kind: .nonTerminal, value: String(character))
				node.children.append(letterNode)
				
				return node
			} else {
				throw ParsingError.internalError
			}
		}
		
		func parseUnicodeDigit(character: Character) throws -> SyntacticNode {
			if character.isNumber {
				let node = SyntacticNode(kind: .unicodeDigit)
				
				let digitNode = SyntacticNode(kind: .nonTerminal, value: String(character))
				node.children.append(digitNode)
				
				return node
			} else {
				throw ParsingError.internalError
			}
		}
	}
}
