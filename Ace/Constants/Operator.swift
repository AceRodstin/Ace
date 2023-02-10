//
//  Operator.swift
//  Constants
//
//  Created by Ace Rodstin on 1/18/23.
//  Copyright © 2023 Ace Rodstin. All rights reserved.
//

import Foundation

enum Operator: String {
	case addition = "+"
	case subtraction = "-"
	case multiplication = "*"
	case division = "/"
	
	init?(punctuator: Punctuator) {
		switch punctuator {
		case .plus:
			self = .addition
		case .minus:
			self = .subtraction
		case .asterisk:
			self = .multiplication
		case .slash:
			self = .division
		default:
			return nil
		}
	}
	
	var precedenceGroup: PrecedenceGroup {
		switch self {
		case .addition, .subtraction:
			return .addition
		case .multiplication, .division:
			return .multiplication
		}
	}
}

// MARK: - PrecedenceGroup

extension Operator {
	enum PrecedenceGroup {
		case addition
		case multiplication
	}
}
