//
//  main.swift
//  Ace
//
//  Created by Ace Rodstin on 2/10/23.
//  Copyright © 2023 Ace Rodstin. All rights reserved.
//

import Foundation

private func sourceCodePath() -> String? {
	let arguments = CommandLine.arguments
	let sourceFlagIndex = arguments.firstIndex { $0 == "--source" }
	
	if let sourceFlagIndex {
		let filePathIndex = arguments.index(after: sourceFlagIndex)
		return arguments[filePathIndex]
	} else {
		return nil
	}
}

private func compile(file path: String) {
	let compiler = Compiler()

	do {
		let records = try compiler.compile(file: path)
		print(records)
	} catch {
		print("Compilation error")
	}
}

if let path = sourceCodePath() {
	compile(file: path)
} else {
	print("Specify source code path following \"--source\" argument.")
}
