//
//  Compiler.swift
//  Compiler
//
//  Created by Ace Rodstin on 2/9/23.
//  Copyright © 2023 Ace Rodstin. All rights reserved.
//

import Foundation

final class Compiler {
	
	// MARK: - Methods
	
	func compile(file path: String) throws -> RecordTable {
		let sourceCodeManager = SourceCodeManager()
		try sourceCodeManager.open(file: path)
		
		let sourceCode = sourceCodeManager.sourceCode
		let lines = sourceCode.split(separator: "\n")
		
		let scope = Scope()
		let tokenParser = TokenParser()
		let syntacticAnalyzer = SyntacticAnalyzer()
		
		let executor = Executor()
		executor.delegate = scope
		
		for line in lines {
			let tokens = try tokenParser.parse(string: String(line))
			let syntacticTree = try syntacticAnalyzer.parse(tokens: tokens)
			try executor.execute(syntacticTree: syntacticTree)
		}
		
		return scope.recordTable
	}
}
