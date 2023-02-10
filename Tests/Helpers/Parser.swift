//
//  Parser.swift
//  Tests
//
//  Created by Ace Rodstin on 2/9/23.
//  Copyright © 2023 Ace Rodstin. All rights reserved.
//

import Foundation

final class Parser {
	static func parseTokens(string: String) throws -> [Token] {
		let parser = TokenParser()
		return try parser.parse(string: string)
	}
	
	static func parseSymbols(string: String, symbols: [Symbol] = []) throws -> [Symbol] {
		let tokenParser = TokenParser()
		let tokens = try tokenParser.parse(string: string)
		
		let syntacticAnalyzer = SyntacticAnalyzer()
		let syntacticTree = try syntacticAnalyzer.parse(tokens: tokens)
		
		let executor = Executor()
		let delegate = MockExecutorDelegate(symbols: symbols)
		executor.delegate = delegate
		
		try executor.execute(syntacticTree: syntacticTree)
		return delegate.symbols
	}
}
