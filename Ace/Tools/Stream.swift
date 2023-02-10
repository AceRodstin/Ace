//
//  Stream.swift
//  Tools
//
//  Created by Ace Rodstin on 1/3/23.
//  Copyright © 2023 Ace Rodstin. All rights reserved.
//

import Foundation

final class Stream<T> where T: BidirectionalCollection, T.Element : Equatable {
	
	// MARK: - Types
	
	typealias Buffer = T
	typealias Element = Buffer.Element
	typealias Index = Buffer.Index
	
	enum StreamError: Error {
		case cannotPut
	}
	
	enum Unit: Equatable {
		case beginOfStream
		case buffered(Element)
		case endOfStream
	}
	
	// MARK: - Properties
	
	private(set) var buffer: Buffer
	private(set) var position: Index?
	
	var offset: Int? {
		if let position {
			return buffer.distance(from: buffer.startIndex, to: position)
		} else {
			return nil
		}
	}
	
	var hasMore: Bool {
		guard !buffer.isEmpty else {
			return false
		}
		
		guard let position else {
			return true
		}
		
		let lastIndex = buffer.index(before: buffer.endIndex)
		return position < lastIndex
	}
	
	var isEnd: Bool {
		return position == buffer.endIndex
	}
	
	var unit: Unit {
		guard let index = position else {
			return .beginOfStream
		}
		
		if index < buffer.endIndex {
			return .buffered(buffer[index])
		} else {
			return .endOfStream
		}
	}
	
	// MARK: - Lifecycle
	
	init(_ buffer: Buffer) {
		self.buffer = buffer
	}
	
	// MARK: - Methods
	
	func get() -> Unit {
		let index = nextIndex()
		position = index
		
		if index == buffer.endIndex {
			return .endOfStream
		} else {
			return .buffered(buffer[index])
		}
	}
	
	func peek() -> Unit {
		let index = nextIndex()
		
		if index == buffer.endIndex {
			return .endOfStream
		} else {
			return .buffered(buffer[index])
		}
	}
	
	func put(unit: Unit) throws {
		switch unit {
		case .beginOfStream:
			return
		case .buffered(let element):
			guard let index = position else {
				throw StreamError.cannotPut
			}
			
			if element == buffer[index] {
				position = prevIndex()
			} else {
				throw StreamError.cannotPut
			}
		case .endOfStream:
			position = prevIndex()
		}
	}
	
	func reset() {
		position = nil
	}
	
	private func nextIndex() -> Index {
		guard let index = position else {
			return buffer.startIndex
		}
		
		if index < buffer.endIndex {
			return buffer.index(after: index)
		} else {
			return buffer.endIndex
		}
	}
	
	private func prevIndex() -> Index? {
		guard let index = position else {
			return nil
		}
		
		if position == buffer.startIndex {
			return nil
		} else {
			return buffer.index(before: index)
		}
	}
}

// MARK: - CustomStringConvertible

extension Stream: CustomStringConvertible {
	var description: String {
		return buffer.map { "\($0)" }.joined(separator: "\n")
	}
}
