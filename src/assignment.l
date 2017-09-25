/* DEFINITIONS */

%{
#include "assignment.tab.h"

#define TOKEN_MACRO(TYPE) { \
        printf("LEXER FOUND TOKEN: %s\n", yytext); \
        return TYPE; \
    }

#define TOKEN_MACRO_VARIABLE(TYPE) { \
        printf("LEXER FOUND TOKEN: " #TYPE " %s\n", yytext); \
        return TYPE; \
    }
%}

%% /* RULES */

"ARRAY"         TOKEN_MACRO(_ARRAY_)
"BEGIN"         TOKEN_MACRO(_BEGIN_)
"CALL"          TOKEN_MACRO(_CALL_)
"CONST"         TOKEN_MACRO(_CONST_)
"DECLARATION"   TOKEN_MACRO(_DECLARATION_)
"END"           TOKEN_MACRO(_END_)
"END DO"        TOKEN_MACRO(_END_DO_)
"END FOR"       TOKEN_MACRO(_END_FOR_)
"END IF"        TOKEN_MACRO(_END_IF_)
"END WHILE"     TOKEN_MACRO(_END_WHILE_)
"FOR"           TOKEN_MACRO(_FOR_)
"FUNCTION"      TOKEN_MACRO(_FUNCTION_)
"IF"            TOKEN_MACRO(_IF_)
"IMPLEMENATION" TOKEN_MACRO(_IMPLEMENTATION_)
"OF"            TOKEN_MACRO(_OF_)
"PROCEDURE"     TOKEN_MACRO(_PROCEDURE_)
"THEN"          TOKEN_MACRO(_THEN_)
"TYPE"          TOKEN_MACRO(_TYPE_)
"VAR"           TOKEN_MACRO(_VAR_)
"WHILE"         TOKEN_MACRO(_WHILE_)
":="			TOKEN_MACRO(_ASSIGNMENT_)
";"				TOKEN_MACRO(_SEMICOLON_)
".."			TOKEN_MACRO(_DOUBLE_DOT_)

"["				TOKEN_MACRO('[')
"]"				TOKEN_MACRO(']')

"{"				TOKEN_MACRO('{')
"}"				TOKEN_MACRO('}')

"("				TOKEN_MACRO('(')
")"				TOKEN_MACRO(')')

"."				TOKEN_MACRO('.')
","				TOKEN_MACRO(',')
"="				TOKEN_MACRO('=')

"*"				TOKEN_MACRO('*')
"/"				TOKEN_MACRO('/')
"+"				TOKEN_MACRO('+')
"-"				TOKEN_MACRO('-')
":"				TOKEN_MACRO(':')

[0-9]+			TOKEN_MACRO_VARIABLE(_NUMBER_)
[a-z]+  		TOKEN_MACRO_VARIABLE(_IDENT_)
[ \t\n\r]+  /* Ignore all whitespace */

.               {
                    fprintf(stderr, "LEXER ERROR: unexpected token - '%s' at '%d'\n", yytext, *yytext);
                    exit(1);
                }

%% /* USER ROUTINES */
int yywrap(void) { return 1; }
