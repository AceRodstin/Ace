//
//  SemanticAnalyzer.swift
//  SemanticAnalyzer
//
//  Created by Ace Rodstin on 2/9/23.
//  Copyright © 2023 Ace Rodstin. All rights reserved.
//

import Foundation

protocol ExecutorDelegate: AnyObject {
	func declare(symbol: Symbol) throws
	func value(of identifier: Symbol.Id) throws -> Symbol.Value?
	func changeValue(of identifier: Symbol.Id, newValue: Symbol.Value) throws
}

final class Executor {
	
	// MARK: - Types
	
	enum ExecutionError: Error {
		case internalError
	}
	
	// MARK: - Properties
	
	weak var delegate: ExecutorDelegate?
	
	// MARK: - Methods
	
	func execute(syntacticTree root: SyntacticNode) throws {
		let collector = SemanticCollector()
		
		switch root.kind {
		case .statement:
			try analyzeStatement(node: root, collector: collector)
		default:
			break
		}
		
		try execute(collector: collector)
	}
	
	private func execute(collector: SemanticCollector) throws {
		guard let operation = collector.operation else {
			throw ExecutionError.internalError
		}
		
		guard let delegate else {
			throw ExecutionError.internalError
		}
		
		switch operation {
		case .declaration:
			let builder = SymbolBuilder()
			let symbol = try builder.build(collector: collector)
			try delegate.declare(symbol: symbol)
		case .assignment:
			if let id = collector.id, let value = collector.value {
				try delegate.changeValue(of: id, newValue: value)
			} else {
				throw ExecutionError.internalError
			}
		}
	}
	
	private func analyzeStatement(node: SyntacticNode, collector: SemanticCollector) throws {
		guard let child = node.children.first else {
			throw ExecutionError.internalError
		}
		
		switch child.kind {
		case .declaration:
			collector.operation = .declaration
			try analyzeDeclaration(node: child, collector: collector)
		case .simpleStatement:
			try analyzeSimpleStatement(node: child, collector: collector)
		default:
			throw ExecutionError.internalError
		}
	}
	
	private func analyzeDeclaration(node: SyntacticNode, collector: SemanticCollector) throws {
		guard let child = node.children.first else {
			return
		}
		
		switch child.kind {
		case .constantDeclaration:
			collector.mutability = .constant
			try analyzeConstantDeclaration(node: child, collector: collector)
		case .variableDeclaration:
			collector.mutability = .variable
			try analyzeVariableDeclaration(node: child, collector: collector)
		default:
			break
		}
	}
	
	private func analyzeSimpleStatement(node: SyntacticNode, collector: SemanticCollector) throws {
		guard let child = node.children.first else {
			throw ExecutionError.internalError
		}
		
		switch child.kind {
		case .assignmentStatement:
			collector.operation = .assignment
			try analyzeAssignmentStatement(node: child, collector: collector)
		default:
			throw ExecutionError.internalError
		}
	}
	
	private func analyzeConstantDeclaration(node: SyntacticNode, collector: SemanticCollector) throws {
		let constantSpecification = node.children.first { $0.kind == .constantSpecification }
		
		if let constantSpecification {
			try analyzeSpecification(node: constantSpecification, collector: collector)
		}
	}
	
	private func analyzeVariableDeclaration(node: SyntacticNode, collector: SemanticCollector) throws {
		let variableSpecification = node.children.first { $0.kind == .variableSpecification }
		
		if let variableSpecification {
			try analyzeSpecification(node: variableSpecification, collector: collector)
		}
	}
	
	private func analyzeAssignmentStatement(node: SyntacticNode, collector: SemanticCollector) throws {
		let identifier = node.children.first { $0.kind == .identifier }
		let expression = node.children.last { $0.kind == .expression }
		
		if let identifier, let expression {
			executeIdentifier(node: identifier, collector: collector)
			try executeExpression(node: expression, collector: collector)
		} else {
			throw ExecutionError.internalError
		}
	}
	
	private func analyzeSpecification(node: SyntacticNode, collector: SemanticCollector) throws {
		let identifierList = node.children.first { $0.kind == .identifierList }
		let type = node.children.first { $0.kind == .type }
		let expression = node.children.first { $0.kind == .expression }
		
		guard let identifierList else {
			throw ExecutionError.internalError
		}
		
		try executeIdentifierList(node: identifierList, collector: collector)
		
		if let type {
			try executeType(node: type, collector: collector)
		}
		
		if let expression {
			try executeExpression(node: expression, collector: collector)
		}
	}
	
	private func executeIdentifierList(node: SyntacticNode, collector: SemanticCollector) throws {
		// TODO: implement full list parsing
		let identifier = node.children.first { $0.kind == .identifier }
		
		if let identifier {
			return executeIdentifier(node: identifier, collector: collector)
		} else {
			throw ExecutionError.internalError
		}
	}
	
	private func executeIdentifier(node: SyntacticNode, collector: SemanticCollector) {
		collector.id = node.joined()
	}
	
	private func executeType(node: SyntacticNode, collector: SemanticCollector) throws {
		let typeIdentifier = node.joined()
		
		if let baseType = BaseType(rawValue: typeIdentifier) {
			collector.type = baseType
		} else {
			throw ExecutionError.internalError
		}
	}
	
	private func executeExpression(node: SyntacticNode, collector: SemanticCollector) throws {
		let executor = ExpressionsExecutor()
		executor.delegate = delegate
		collector.value = try executor.executeExpression(node: node)
	}
}
