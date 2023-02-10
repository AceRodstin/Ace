//
//  Token.swift
//  TokenParser
//
//  Created by Ace Rodstin on 1/4/23.
//  Copyright © 2023 Ace Rodstin. All rights reserved.
//

import Foundation

enum Token: Equatable {
	case keyword(Keyword)
	case punctuator(Punctuator)
	case literal(Literal)
	case identifier(String)
}
