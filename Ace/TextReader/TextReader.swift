//
//  TextReader.swift
//  TextReader
//
//  Created by Ace Rodstin on 1/20/23.
//  Copyright © 2023 Ace Rodstin. All rights reserved.
//

import Foundation

final class TextReader {

	// MARK: - Types

	struct Position: Equatable {
		var line = 1
		var column = 0
	}
	
	enum Unit: Equatable {
		case beginOfFile
		case character(Character)
		case endOfFile
	}
	
	enum OperationError: Error {
		case cannotUnread
	}
	
	// MARK: - Properties

	private var stream = Stream("")
	private(set) var position = Position()
	
	var unit: Unit {
		switch stream.unit {
		case .beginOfStream:
			return .beginOfFile
		case .buffered(let character):
			return .character(character)
		case .endOfStream:
			return .endOfFile
		}
	}
	
	// MARK: - Methods
	
	func load(string: String) {
		stream = Stream(string)
	}
	
	func read() -> Unit {
		let got = stream.get()
		
		switch got {
		case .beginOfStream:
			return .beginOfFile
		case .buffered(let character):
			advancePosition(by: character)
			return .character(character)
		case .endOfStream:
			return .endOfFile
		}
	}
	
	func unread(_ unit: Unit) throws {
		switch unit {
		case .beginOfFile:
			throw OperationError.cannotUnread
		case .character(let character):
			do {
				try stream.put(unit: .buffered(character))
			} catch {
				throw OperationError.cannotUnread
			}
		case .endOfFile:
			do {
				try stream.put(unit: .endOfStream)
			} catch {
				throw OperationError.cannotUnread
			}
		}
	}
	
	private func advancePosition(by character: Character) {
		if character == "\n" {
			position.line += 1
			position.column = 0
		} else {
			position.column += 1
		}
	}
}
