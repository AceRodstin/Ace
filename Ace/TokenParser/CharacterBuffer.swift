//
//  CharacterBuffer.swift
//  TokenParser
//
//  Created by Ace Rodstin on 2/7/23.
//  Copyright © 2023 Ace Rodstin. All rights reserved.
//

import Foundation

final class CharacterBuffer {
	
	// MARK: - Properties
	
	private var storage: [Character] = []
	
	var isEmpty: Bool {
		return storage.isEmpty
	}
	
	var count: Int {
		return storage.count
	}
	
	var string: String {
		return String(storage)
	}
	
	// MARK: - Methods
	
	func append(character: Character) {
		storage.append(character)
	}
	
	func isFirst(character: Character) -> Bool {
		return character == storage.first
	}
	
	func reset() {
		storage.removeAll()
	}
}
