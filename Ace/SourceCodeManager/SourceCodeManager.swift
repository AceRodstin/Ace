//
//  SourceCodeManager.swift
//  SourceCodeManager
//
//  Created by Ace Rodstin on 1/20/23.
//  Copyright © 2023 Ace Rodstin. All rights reserved.
//

import Foundation

final class SourceCodeManager {
	
	// MARK: - Types
	
	enum SourceCodeError: Error {
		case fileDoesNotExist
	}
	
	// MARK: - Properties
	
	private var fileUrl: URL?
	private(set) var sourceCode = ""
	
	var fileName: String {
		if let fileUrl {
			return fileUrl.deletingPathExtension().lastPathComponent
		} else {
			return ""
		}
	}
	
	var fileExtension: String {
		if let fileUrl {
			return fileUrl.pathExtension
		} else {
			return ""
		}
	}
	
	// MARK: - Methods
	
	func open(file path: String) throws {
		guard FileManager.default.fileExists(atPath: path) else {
			throw SourceCodeError.fileDoesNotExist
		}
		
		let url = URL(filePath: path)
		
		fileUrl = url
		sourceCode = try String(contentsOf: url)
	}
	
	func close() {
		fileUrl = nil
		sourceCode.removeAll()
	}
}
