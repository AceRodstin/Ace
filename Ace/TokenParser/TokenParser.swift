//
//  TokenParser.swift
//  TokenParser
//
//  Created by Ace Rodstin on 1/19/23.
//  Copyright © 2023 Ace Rodstin. All rights reserved.
//

import Foundation

final class TokenParser {

	// MARK: - Types
	
	enum ParsingError: Error {
		case internalError
	}
	
	// MARK: - Properties
	
	private let reader = TextReader()
	private var builder = TokenBuilder()
	private var buffer = CharacterBuffer()
	private var tokens: [Token] = []

	// MARK: - Methods
	
	func parse(string: String) throws -> [Token] {
		builder.reset()
		buffer.reset()
		tokens.removeAll()
		
		reader.load(string: string)
		
		while true {
			if let character = readCharacter() {
				try handle(character: character)
			} else {
				break
			}
		}
		
		try flushBuffer()
		
		return tokens
	}
	
	private func readCharacter() -> Character? {
		let got = reader.read()
		
		switch got {
		case .character(let character):
			return character
		case .beginOfFile, .endOfFile:
			return nil
		}
	}
	
	private func unreadCharacter(_ character: Character) throws {
		try reader.unread(.character(character))
	}
	
	private func currentCharacter() throws -> Character {
		guard case .character(let character) = reader.unit else {
			throw ParsingError.internalError
		}
		
		return character
	}
	
	private func currentLexem() throws -> String {
		var lexem = buffer.string
		
		while true {
			guard let character = readCharacter() else {
				break
			}
			
			if !isQuoteMark(character: character) {
				lexem.append(character)
			}
		}
		
		if lexem.isEmpty {
			throw ParsingError.internalError
		} else {
			return lexem
		}
	}
	
	private func handle(character: Character) throws {
		if isLetter(character: character) || isUnderscore(character: character) {
			buffer.append(character: character)
			return
		}
		
		if isDelimiter(character: character) {
			try flushBuffer()
			return
		}
		
		if isDecimal(character: character) {
			buffer.append(character: character)
			
			if buffer.isFirst(character: character) {
				let literal = try parseNumberLiteral()
				try createLiteralToken(literal)
			}
			
			return
		}
		
		if isQuoteMark(character: character) {
			let literal = try parseCharacterLiteral()
			try createLiteralToken(literal)
			return 
		}
		
		if isDoubleQuoteMark(character: character) {
			let literal = try parseStringLiteral()
			try createLiteralToken(literal)
			return 
		}
		
		if let punctuator = parsePunctuator(character: character) {
			try flushBuffer()
			try createPunctuatorToken(punctuator)
			return
		}
	}
	
	private func flushBuffer() throws {
		if !buffer.isEmpty {
			try parseKeywordOrIdentifier()
		}
	}
	
	private func parseKeywordOrIdentifier() throws {
		let string = buffer.string
		
		if let keyword = parseKeyword(string: string) {
			try createKeywordToken(keyword)
		} else {
			try createIdentifierToken(string)
		}
	}
	
	private func parseNumberLiteral() throws -> Literal {
		let character = try currentCharacter()

		if character == "0", let nextCharacter = readCharacter() {
			buffer.append(character: nextCharacter)
			return try parseNumberLiteralAndBase(prefix: nextCharacter)
		} else {
			return try parseNumberLiteral(base: .decimal)
		}
	}
	
	private func parseNumberLiteralAndBase(prefix character: Character) throws -> Literal {
		var base: DigitBase = .decimal
		
		if isDelimiter(character: character) {
			return numberLiteral(base: base, isFloat: false)
		}
		
		if isDot(character: character) {
			try parseFraction(base: base)
			return numberLiteral(base: base, isFloat: true)
		}
		
		if isExponentPrefix(character: character, base: base) {
			try parseExponent(base: base)
			return numberLiteral(base: base, isFloat: true)
		}
		
		base = parseDigitBase(character: character)
		return try parseNumberLiteral(base: base)
	}
	
	private func parseNumberLiteral(base: DigitBase) throws -> Literal {
		var isFloat = false
		
		while true {
			guard let character = readCharacter() else {
				break
			}
			
			guard !isDelimiter(character: character) else {
				break
			}
			
			guard !isParenthesis(character: character) else {
				try unreadCharacter(character)
				break
			}
			
			buffer.append(character: character)
			
			if isDot(character: character) {
				isFloat = true
				try parseFraction(base: base)
				break
			}
			
			if isExponentPrefix(character: character, base: base) {
				isFloat = true
				try parseExponent(base: base)
				break
			}
			
			if isUnderscore(character: character) {
				continue
			}
			
			try validateDigit(character: character, base: base)
		}
		
		return numberLiteral(base: base, isFloat: isFloat)
	}
	
	private func parseDigitBase(character: Character) -> DigitBase {
		switch character {
		case "b":
			return .binary
		case "o":
			return .octal
		case "x":
			return .hexadecimal
		default:
			return .decimal
		}
	}
	
	private func parseFraction(base: DigitBase) throws {
		while true {
			guard let character = readCharacter() else {
				break
			}
			
			guard !isDelimiter(character: character) else {
				break
			}
			
			buffer.append(character: character)
			
			if isExponentPrefix(character: character, base: base) {
				try parseExponent(base: base)
				break
			}
			
			if isUnderscore(character: character) {
				continue
			}
			
			try validateDigit(character: character, base: base)
		}
	}
	
	private func parseExponent(base: DigitBase) throws {
		var isSignOccur = false
		
		while true {
			guard let character = readCharacter() else {
				break
			}
			
			guard !isDelimiter(character: character) else {
				break
			}
			
			buffer.append(character: character)
			
			if isSign(character: character) {
				if isSignOccur {
					throw ParsingError.internalError
				} else {
					isSignOccur = true
				}
				
				continue
			}
			
			try validateDigit(character: character, base: .decimal)
		}
	}
	
	private func numberLiteral(base: DigitBase, isFloat: Bool) -> Literal {
		let kind: Literal.Kind = isFloat ? .float(base) : .integer(base)
		return Literal(kind: kind, value: buffer.string)
	}
	
	private func validateDigit(character: Character, base: DigitBase) throws {
		let isValid: Bool
		
		switch base {
		case .decimal:
			isValid = isDecimal(character: character) 
		case .binary:
			isValid = isBinary(character: character)
		case .octal:
			isValid = isOctal(character: character)
		case .hexadecimal:
			isValid = isHexadecimal(character: character)
		}
		
		if !isValid {
			throw ParsingError.internalError
		}
	}
	
	private func parseCharacterLiteral() throws -> Literal {
		while true {
			guard let character = readCharacter() else {
				break
			}
			
			guard !isQuoteMark(character: character) else {
				break
			}
			
			if buffer.isEmpty {
				buffer.append(character: character)
			} else {
				buffer.append(character: character)
				throw ParsingError.internalError
			}
		}
		
		return Literal(kind: .character, value: buffer.string)
	}
	
	private func parseStringLiteral() throws -> Literal {
		while true {
			guard let character = readCharacter() else {
				break
			}
			
			if isDoubleQuoteMark(character: character) {
				break
			} else {
				buffer.append(character: character)
			}
		}
		
		return Literal(kind: .string, value: buffer.string)
	}
	
	private func parseKeyword(string: String) -> Keyword? {
		return Keyword(rawValue: string)
	}
	
	private func parsePunctuator(character: Character) -> Punctuator? {
		let rawValue = String(character)
		return Punctuator(rawValue: rawValue)
	}
	
	private func createKeywordToken(_ keyword: Keyword) throws {
		builder.keyword = keyword
		try createToken()
	}
	
	private func createPunctuatorToken(_ punctuator: Punctuator) throws {
		builder.punctuator = punctuator
		try createToken()
	}
	
	private func createLiteralToken(_ literal: Literal) throws {
		builder.literal = literal
		try createToken()
	}
	
	private func createIdentifierToken(_ identifier: String) throws {
		builder.identifier = identifier
		try createToken()
	}
	
	private func createToken() throws {
		let token = try builder.build()
		tokens.append(token)
		
		builder.reset()
		buffer.reset()
	}
	
	private func isLetter(character: Character) -> Bool {
		return character.isLetter
	}
	
	private func isQuoteMark(character: Character) -> Bool {
		return character == "'"
	}
	
	private func isDoubleQuoteMark(character: Character) -> Bool {
		return character == "\""
	}
	
	private func isDot(character: Character) -> Bool {
		return character == "."
	}
	
	private func isUnderscore(character: Character) -> Bool {
		return character == "_"
	}
	
	private func isSign(character: Character) -> Bool {
		return character == "+" || character == "-"
	}
	
	private func isParenthesis(character: Character) -> Bool {
		return character == "(" || character == ")"
	}
	
	private func isExponentPrefix(character: Character, base: DigitBase) -> Bool {
		let lowercased = character.lowercased()
		
		switch base {
		case .decimal:
			return lowercased == "e"
		case .binary, .octal:
			return false
		case .hexadecimal:
			return lowercased == "p"
		} 
	}
	
	private func isDelimiter(character: Character) -> Bool {
		return Characters.spaces.contains(character)
	}
	
	private func isDecimal(character: Character) -> Bool {
		return Characters.decimalDigits.contains(character)
	}
	
	private func isBinary(character: Character) -> Bool {
		return Characters.binaryDigits.contains(character)
	}
	
	private func isOctal(character: Character) -> Bool {
		return Characters.octalDigits.contains(character)
	}
	
	private func isHexadecimal(character: Character) -> Bool {
		return Characters.hexadecimalDigits.contains(character)
	}
}
