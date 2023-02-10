//
//  MockExecutorDelegate.swift
//  Tests
//
//  Created by Ace Rodstin on 2/8/23.
//  Copyright © 2023 Ace Rodstin. All rights reserved.
//

import Foundation

final class MockExecutorDelegate: ExecutorDelegate {
	private(set) var symbols: [Symbol]
	
	init(symbols: [Symbol] = []) {
		self.symbols = symbols
	}
	
	func value(of id: Symbol.Id) -> Symbol.Value? {
		let symbol = symbols.first { $0.id == id }
		return symbol?.value
	}
	
	func declare(symbol: Symbol) throws {
		symbols.append(symbol)
	}
	
	func changeValue(of identifier: Symbol.Id, newValue: Symbol.Value) throws {
		let symbol = symbols.first { $0.id == identifier }
		symbol?.value = newValue
	}
}
