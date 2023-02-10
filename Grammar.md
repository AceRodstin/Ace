# Grammar

## Notation

- | alternation
- () grouping
- [] option (0 or 1 times)
- {} repetition (0 to n times)
- a...b closed range (from a to b)

Non-terminals are in CamelCase. Terminals are enclosed in double quotes "".

## Statements

```
Statement = Declaration | SimpleStatement .
SimpleStatement = AssignmentStatement .
AssignmentStatement = Identifier AssignOperator Expression .
```

## Declarations

```
Declaration = ConstantDeclaration | VariableDeclaration .

ConstantDeclaration = "val" ConstantSpecification .
ConstantSpecification = IdentifierList ( ":" Type | [ ":" Type ] "=" Expression ) .

VariableDeclaration = "var" VariableSpecification .
VariableSpecification = IdentifierList ( ":" Type | [ ":" Type ] "=" Expression ) .
```

## Types

```
Type = TypeName .
TypeName = Identifier .
```

## Expressions

```
Expression = UnaryExpression | Expression BinaryOperator Expression .
UnaryExpression = [ UnaryOperator ] PrimaryExpression .
PrimaryExpression = Operand .
Operand = Literal | "(" Expression ")" | OperandName .
OperandName = Identifier .
```

## Operators

```
BinaryOperator = AdditionGroupOperator | MultiplicationGroupOperator .
UnaryOperator = "+" | "-" .
AdditionGroupOperator = "+" | "-" .
MultiplicationGroupOperator = "*" | "/" .
AssignOperator = "=" .
```

## Identifiers

```
IdentifierList = Identifier { "," Identifier } .
Identifier = Letter { Letter | UnicodeDigit } .
```

## Literals

```
Literal = BasicLiteral .
BasicLiteral = IntegerLiteral | FloatLiteral .
```

integer literals

```
IntegerLiteral = DecimalLiteral | BinaryLiteral | OctalLiteral | HexadecimalLiteral .
DecimalLiteral = DecimalDigit [ [ "_" ] DecimalDigits ] .
BinaryLiteral = "0b" [ "_" ] BinaryDigits .
OctalLiteral = "0o" [ "_" ] OctalDigits .
HexadecimalLiteral = "0x" [ "_" ] HexadecimalDigits .

DecimalDigits = DecimalDigit { [ "_" ] DecimalDigit } .
BinaryDigits = BinaryDigit { [ "_" ] BinaryDigit } .
OctalDigits = OctalDigit { [ "_" ] OctalDigit } .
HexadecimalDigits = HexadecimalDigit { [ "_" ] HexadecimalDigit } .
```

floatinging-point literals

```
FloatLiteral = DecimalFloatLiteral | HexadecimalFloatLiteral .

DecimalFloatLiteral = DecimalDigits  [ "." DecimalDigits ] [ DecimalExponent ] .
DecimalExponent = ( "e" | "E" ) [ "+" | "-" ] DecimalDigits .

HexadecimalFloatLiteral = "0x" HexadecimalMantissa HexadecimalExponent .
HexadecimalMantissa = [ "_" ] HexadecimalDigits [ "." HexadecimalDigits ] .
HexadecimalExponent = ( "p" | "P" ) [ "+" | "-" ] DecimalDigits .
```

## Characters

```
Letter = UnicodeLetter | "_" .
DecimalDigit = "0" ... "9" .
BinaryDigit = "0" | "1" .
OctalDigit = "0" ... "7" .
HexadecimalDigit = "0" ... "9" | "A" ... "F" | "a" ... "f" .

UnicodeCharacter = /* an arbitrary Unicode code point except newline */ .
UnicodeLetter = /* a Unicode code point categorized as "Letter" */ .
UnicodeDigit = /* a Unicode code point categorized as "Number, decimal digit" */ .
Newline = /* the Unicode code point U+000A */ .
```