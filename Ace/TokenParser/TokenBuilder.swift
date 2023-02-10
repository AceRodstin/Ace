//
//  TokenBuilder.swift
//  TokenParser
//
//  Created by Ace Rodstin on 1/20/23.
//  Copyright © 2023 Ace Rodstin. All rights reserved.
//

import Foundation

final class TokenBuilder {
	
	// MARK: - Types
	
	enum BuildingError: Error {
		case builderNotConfigured
	}
	
	// MARK: - Properties
	
	var keyword: Keyword?
	var punctuator: Punctuator?
	var literal: Literal?
	var identifier: String?
	
	// MARK: - Methods
	
	func build() throws -> Token {
		if let keyword {
			return .keyword(keyword)
		} else if let punctuator {
			return .punctuator(punctuator)
		} else if let literal {
			return .literal(literal)
		} else if let identifier {
			return .identifier(identifier)
		} else {
			throw BuildingError.builderNotConfigured
		}
	}
	
	func reset() {
		keyword = nil
		punctuator = nil
		literal = nil
		identifier = nil
	}
}
