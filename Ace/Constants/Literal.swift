//
//  Literal.swift
//  Constants
//
//  Created by Ace Rodstin on 1/18/23.
//  Copyright © 2023 Ace Rodstin. All rights reserved.
//

import Foundation

struct Literal: Equatable {
	
	// MARK: - Types
	
	enum Kind: Equatable {
		case integer(DigitBase)
		case float(DigitBase)
		case character
		case string
	}
	
	// MARK: - Properties
	
	var kind: Kind
	var value: String
}
