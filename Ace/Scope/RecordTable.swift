//
//  RecordTable.swift
//  Scope
//
//  Created by Ace Rodstin on 2/9/23.
//  Copyright © 2023 Ace Rodstin. All rights reserved.
//

import Foundation

final class RecordTable {
	
	// MARK: - Properties
	
	private var storage: [Record] = []
	
	// MARK: - Lifecycle
	
	init(symbols: [Symbol]) {
		storage = symbols.map(Record.init)
	}
}

// MARK: - CustomStringConvertible

extension RecordTable: CustomStringConvertible {
	var description: String {
		let description = storage.map(\.description)
		return String(description.joined(separator: "\n"))
	}
}
