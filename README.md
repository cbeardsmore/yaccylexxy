# yaccylexxy

##### Programming Languages 200: Parser Implementation

##### Purpose

Converts a series of syntax diagrams into an EBNF specification. Then develops a parser using Yacc and Lex for the given language.

##### How To Run

The executable requires both Yacc (or Bison) and Lex (or Flex) to compile. The *-lfl* or *-ll* flag may be required on some systems

```
make
```

This will compile both the Yacc and Lex code into a single executable names *QUENYARGOLINT*. This executable can then be ran against files or standard input to check validity against the EBNF

##### Test Files

The *tests* directory contains a series of both valid and invalid files for testing of the parser