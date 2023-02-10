//
//  TestNodeKind.swift
//  Tests
//
//  Created by Ace Rodstin on 1/6/23.
//  Copyright © 2023 Ace Rodstin. All rights reserved.
//

import Foundation

extension TestNode {
	enum Kind: String {
		case statement
		
		// Declarations
		case declaration
		case constantDeclaration = "constant-declaration"
		case variableDeclaration = "variable-declaration"
		case variableDeclarationHead = "variable-declaration-head"
		
		// Pattern
		case patternInitializerList = "pattern-initializer-list"
		case patternInitializer = "pattern-initializer"
		case pattern
		
		case initializer
		
		// Identifier
		case identifierPattern = "identifier-pattern"
		case identifier
		case identifierCharacters = "identifier-characters"
		case identifierCharacter = "identifier-character"
		case identifierHead = "identifier-head"
		
		// Expression
		case expression
		case prefixExpression = "prefix-expression"
		case infixExpressions = "infix-expressions"
		case infixExpression = "infix-expression"
		case postfixExpression = "postfix-expression"
		case primaryExpression = "primary-expression"
		case literalExpression = "literal-expression"
		case parenthesizedExpression = "parenthesized-expression"
		
		// Literal
		case literal
		case numericLiteral = "numeric-literal"
		case integerLiteral = "integer-literal"
		
		case decimalLiteral = "decimal-literal"
		case hexadecimalLiteral = "hexadecimal-literal"
		case octalLiteral = "octal-literal"
		case binaryLiteral = "binary-literal"
		
		case hexadecimalHead = "hexadecimal-head"
		case octalHead = "octal-head"
		case binaryHead = "binary-head"
		
		case decimalLiteralCharacters = "decimal-literal-characters"
		case hexadecimalLiteralCharacters = "hexadecimal-literal-characters"
		case octalLiteralCharacters = "octal-literal-characters"
		case binaryLiteralCharacters = "binary-literal-characters"
		
		case decimalLiteralCharacter = "decimal-literal-character"
		case hexadecimalLiteralCharacter = "hexadecimal-literal-character"
		case octalLiteralCharacter = "octal-literal-character"
		case binaryLiteralCharacter = "binary-literal-character"
		
		case decimalDigit = "decimal-digit"
		case hexadecimalDigit = "hexadecimal-digit"
		case octalDigit = "octal-digit"
		case binaryDigit = "binary-digit"
		
		case floatingPointLiteral = "floating-point-literal"
		case decimalFraction = "decimal-fraction"
		
		// Operator
		case `operator`
		case operatorHead = "operator-head"
		case operatorCharacters = "operator-characters"
		case operatorCharacter = "operator-character"
		
		case prefixOperator = "prefix-operator"
		case infixOperator = "infix-operator"
		
		// Type
		case typeAnnotation = "type-annotation"
		case type = "type"
		case typeIdentifier = "type-identifier"
		case typeName = "type-name"
	}
}
