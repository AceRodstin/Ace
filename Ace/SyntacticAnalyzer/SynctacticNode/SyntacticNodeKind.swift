//
//  SyntacticNodeKind.swift
//  SyntacticAnalyzer
//
//  Created by Ace Rodstin on 2/7/23.
//  Copyright © 2023 Ace Rodstin. All rights reserved.
//

import Foundation

extension SyntacticNode {
	enum Kind: String {
		// Statements
		case statement = "Statement"
		case simpleStatement = "SimpleStatement"
		case assignmentStatement = "AssignmentStatement"
		
		// Declarations
		case declaration = "Declaration"
		case constantDeclaration = "ConstantDeclaration"
		case constantSpecification = "ConstantSpecification"
		case variableDeclaration = "VariableDeclaration"
		case variableSpecification = "VariableSpecification"
		
		// Types
		case type = "Type"
		case typeName = "TypeName"
		
		// Expressions
		case expression = "Expression"
		case unaryExpression = "UnaryExpression"
		case expressionList = "ExpressionList"
		case primaryExpression = "PrimaryExpression"
		case operand = "Operand"
		case operandName = "OperandName"
		
		// Operators
		case binaryOperator = "BinaryOperator"
		case unaryOperator = "UnaryOperator"
		case relationOperator = "RelationOperator"
		case additionGroupOperator = "AdditionGroupOperator"
		case multiplicationGroupOperator = "MultiplicationGroupOperator"
		case assignOperator = "AssignOperator"
		
		// Identifiers
		case identifierList = "IdentifierList"
		case identifier = "Identifier"
		
		// Literals
		case literal = "Literal"
		case basicLiteral = "BasicLiteral"
		case integerLiteral = "IntegerLiteral"
		case floatLiteral = "FloatLiteral"
		case decimalLiteral = "DecimalLiteral"
		case binaryLiteral = "BinaryLiteral"
		case octalLiteral = "OctalLiteral"
		case hexadecimalLiteral = "HexadecimalLiteral"
		case decimalDigits = "DecimalDigits"
		case binaryDigits = "BinaryDigits"
		case octalDigits = "OctalDigits"
		case hexadecimalDigits = "HexadecimalDigits"
		case decimalFloatLiteral = "DecimalFloatLiteral"
		case decimalExponent = "DecimalExponent"
		case hexadecimalFloatLiteral = "HexadecimalFloatLiteral"
		case hexadecimalMantissa = "HexadecimalMantissa"
		case hexadecimalExponent = "HexadecimalExponent"
		
		// Characters
		case letter = "Letter"
		case decimalDigit = "DecimalDigit"
		case binaryDigit = "BinaryDigit"
		case octalDigit = "OctalDigit"
		case hexadecimalDigit = "HexadecimalDigit"
		
		case newline = "Newline"
		case unicodeCharacter = "UnicodeCharacter"
		case unicodeLetter = "UnicodeLetter"
		case unicodeDigit = "UnicodeDigit"
		
		case nonTerminal = "NonTerminal"
	}
}
