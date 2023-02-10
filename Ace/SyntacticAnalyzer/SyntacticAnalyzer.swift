//
//  SyntacticAnalyzer.swift
//  SyntacticAnalyzer
//
//  Created by Ace Rodstin on 2/7/23.
//  Copyright © 2023 Ace Rodstin. All rights reserved.
//

import Foundation

final class SyntacticAnalyzer {
	
	// MARK: - Types
	
	typealias Buffer = [Token]
	
	enum ParsingError: Error {
		case internalError
	}
	
	// MARK: - Methods
	
	func parse(tokens buffer: Buffer) throws -> SyntacticNode {
		let statementsParser = StatementsParser()
		let stream = Stream(buffer)
		return try statementsParser.parse(stream: stream)
	}
}

// MARK: - Extensions

extension SyntacticAnalyzer {
	static func get<T>(from stream: Stream<T>) throws -> T.Element {
		guard case .buffered(let element) = stream.get() else {
			throw ParsingError.internalError
		}
		
		return element
	}
	
	static func peek<T>(from stream: Stream<T>) throws -> T.Element {
		guard case .buffered(let element) = stream.peek() else {
			throw ParsingError.internalError
		}
		
		return element
	}
	
	static func put<T>(element: T.Element, to stream: Stream<T>) throws {
		try stream.put(unit: .buffered(element))
	}
}
