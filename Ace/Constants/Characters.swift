//
//  Characters.swift
//  Constants
//
//  Created by Ace Rodstin on 2/7/23.
//  Copyright © 2023 Ace Rodstin. All rights reserved.
//

import Foundation

struct Characters {
	
	// MARK: - Properties
	
	private let storage: CharacterSet
	
	// MARK: - Lifecycle
	
	init(characterSet: CharacterSet) {
		self.storage = characterSet
	}
	
	// MARK: - Methods
	
	func contains(_ character: Character) -> Bool {
		return character.unicodeScalars.allSatisfy(storage.contains)
	}
}

extension Characters {
	static let hexadecimalDigits: Characters = {
		var hexadecimalDigits = CharacterSet(charactersIn: "0"..."9")
		hexadecimalDigits.insert(charactersIn: "A"..."F")
		hexadecimalDigits.insert(charactersIn: "a"..."f")
		return Characters(characterSet: hexadecimalDigits)
	}()
	
	static let octalDigits: Characters = {
		let octalDigits = CharacterSet(charactersIn: "0"..."7")
		return Characters(characterSet: octalDigits)
	}()
	
	static let binaryDigits: Characters = {
		let binaryDigits = CharacterSet(charactersIn: "0"..."1")
		return Characters(characterSet: binaryDigits)
	}()
	
	static let decimalDigits: Characters = {
		let decimalDigits = CharacterSet(charactersIn: "0"..."9")
		return Characters(characterSet: decimalDigits)
	}()
	
	static let spaces: Characters = {
		var spaces = CharacterSet()
		spaces.insert(" ")
		spaces.insert("\t")
		spaces.insert("\n")
		spaces.insert("\r")
		return Characters(characterSet: spaces)
	}()
}
