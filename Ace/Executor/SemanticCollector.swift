//
//  SemanticCollector.swift
//  Executor
//
//  Created by Ace Rodstin on 2/9/23.
//  Copyright © 2023 Ace Rodstin. All rights reserved.
//

import Foundation

final class SemanticCollector {
	
	// MARK: - Types
	
	enum Operation {
		case declaration
		case assignment
	}
	
	// MARK: - Properties
	
	var operation: Operation?
	var id: Symbol.Id?
	var type: BaseType?
	var value: Symbol.Value?
	var mutability: Symbol.Mutability?
}
