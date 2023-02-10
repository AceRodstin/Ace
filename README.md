# The Ace Programming Language

## Welcome to Ace

Ace is a modern system programming language.

## Getting Started

#### Building

A typical invocation looks like the following:
```
./ace --source $SOURCE_FILE_PATH
```
where ``$SOURCE_FILE_PATH`` is a string that describes full path to the source code file.

## Features

- Constant declaration
- Variable declaration
- Math expressions calculation

#### Example

Compilation of this file ``SourceCode.ace``

```
val value = 0.5

var another = 2.5
another = 3

val result = value + another
```

will produce that output

```
value: Double = 0.5
another: Double = 3
result: Double = 3.5
```

#### Grammar

You can acquainted with ace programming language grammar in the ``Grammar.md`` file.

## Non implemented

#### Error messages

At now the compiler does not support descriptive error messages. So, if you make an error, a trivial error message in the console output to be expected.
