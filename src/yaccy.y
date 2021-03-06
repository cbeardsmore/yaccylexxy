/***************************************************************************
*	FILE: yaccy.y
*	AUTHOR: Connor Beardsmore - 15504319
*	UNIT: PL200
*	PURPOSE: Yacc file for parser generation
*   LAST MOD: 27/09/17
*   REQUIRES: stdio.h, yaccy.tab.h
***************************************************************************/

/* DEFINITIONS */

%{
#include <stdio.h>
#include "y.tab.h"

int yylex();
int yyparse();

void yyerror(const char* msg) {
        fprintf(stderr, "yyeror: %s\n", msg);
   }

int main(void) {
       yyparse();
       return 0;
}

//MACRO to output the grammar matched
#define GRAMMAR_MACRO(TYPE) { \
        printf("\tYACC MATCHED RULE: " #TYPE "\n"); \
    }

//Enables more in-depth error messages from Yacc
#define YYERROR_VERBOSE
%}

/**************************************************************************/

%token
    _ASSIGNMENT_
    _ARRAY_
    _BEGIN_
    _CALL_
    _CONST_
    _DECLARATION_
    _DO_
    _DOUBLE_DOT_
    _END_
    _END_DO_
    _END_FOR_
    _END_IF_
    _END_WHILE_
    _FOR_
    _FUNCTION_
    _IDENT_
    _IF_
    _IMPLEMENTATION_
    _NUMBER_
    _OF_
    _PROCEDURE_
    _SEMICOLON_
    _THEN_
    _TYPE_
    _VAR_
    _WHILE_

%start basic_program
%%

/**************************************************************************/
/* GRAMMAR RULES - TKN_PRIMARY */

basic_program:
    declaration_unit implementation_unit
    { GRAMMAR_MACRO(basic_program) };

/**************************************************************************/
/* DECLARATION UNIT */

opt_constant_declaration:
    _CONST_ constant_declaration
    { GRAMMAR_MACRO(opt_constant_declaration) }
    | {};

opt_variable_declaration:
    _VAR_ variable_declaration
    { GRAMMAR_MACRO(opt_variable_declaration) }
    | {};

opt_type_declaration:
    type_declaration
    { GRAMMAR_MACRO(opt_type_declaration) }
    | {};

opt_procedure_interface:
    procedure_interface
    { GRAMMAR_MACRO(opt_procedure_interface) }
    | {};

opt_function_interface:
    function_interface
    { GRAMMAR_MACRO(opt_function_interface) }
    | {};

opt_formal_parameters:
    formal_parameters
    { GRAMMAR_MACRO(opt_formal_parameters) }
    | {};

declaration_unit:
    _DECLARATION_ _OF_ _IDENT_
        opt_constant_declaration
        opt_variable_declaration
        opt_type_declaration
        opt_procedure_interface
        opt_function_interface
    _DECLARATION_ _END_
    { GRAMMAR_MACRO(declaration_unit) };

/**************************************************************************/
/* DECLARATIONS AND INTERFACES */

procedure_interface:
    _PROCEDURE_ _IDENT_
        opt_formal_parameters
    { GRAMMAR_MACRO(procedure_interface) };

function_interface:
    _FUNCTION_ _IDENT_
        opt_formal_parameters
    { GRAMMAR_MACRO(function_interface) };

type_declaration:
    _TYPE_ _IDENT_ ':' type _SEMICOLON_
    { GRAMMAR_MACRO(type_declaration) };

ident_loop_semicolon:
    _IDENT_
    | ident_loop_semicolon _SEMICOLON_ _IDENT_
    { GRAMMAR_MACRO(ident_loop_semicolon) };

formal_parameters:
    '(' ident_loop_semicolon ')'
    { GRAMMAR_MACRO(formal_parameters) };

constant_loop:
    _IDENT_ '=' _NUMBER_
    | constant_loop ',' _IDENT_ '=' _NUMBER_
    { GRAMMAR_MACRO(constant_loop) };

constant_declaration:
    constant_loop _SEMICOLON_
    { GRAMMAR_MACRO(constant_declaration) };

variable_loop:
    _IDENT_ ':' _IDENT_
    | variable_loop ',' _IDENT_ ':' _IDENT_
    { GRAMMAR_MACRO(variable_loop) };

variable_declaration:
    variable_loop _SEMICOLON_
    { GRAMMAR_MACRO(variable_declaration) };

/**************************************************************************/
/* TYPES */

type:
    basic_type
    { GRAMMAR_MACRO(type) }
    | array_type
    { GRAMMAR_MACRO(type) };

basic_type:
    _IDENT_
    { GRAMMAR_MACRO(basic_type) }
    | enumerated_type
    { GRAMMAR_MACRO(basic_type) }
    | range_type
    { GRAMMAR_MACRO(basic_type) };

ident_loop_comma:
    _IDENT_
    | ident_loop_comma ',' _IDENT_
    { GRAMMAR_MACRO(ident_loop_comma) };

enumerated_type:
    '{' ident_loop_comma '}'
    { GRAMMAR_MACRO(enumerated_type) };

range_type:
    '[' range ']'
    { GRAMMAR_MACRO(range_type) };

array_type:
    _ARRAY_ _IDENT_ '[' range ']' _OF_ type
    { GRAMMAR_MACRO(array_type) };

range:
    _NUMBER_ _DOUBLE_DOT_ _NUMBER_
    { GRAMMAR_MACRO(range) };

/**************************************************************************/
/* IMPLEMENTATION AND SPECIFICATION */

implementation_unit:
    _IMPLEMENTATION_ _OF_ _IDENT_ block '.'
    { GRAMMAR_MACRO(implementation_unit) };

block:
    specification_part implementation_part
    { GRAMMAR_MACRO(block) };

specification_part:
    _CONST_ constant_declaration
    { GRAMMAR_MACRO(specification_part) }
    | _VAR_ variable_declaration
    { GRAMMAR_MACRO(specification_part) }
    | procedure_declaration
    { GRAMMAR_MACRO(specification_part) }
    | function_declaration
    { GRAMMAR_MACRO(specification_part) }
    | {}

procedure_declaration:
    _PROCEDURE_ _IDENT_ _SEMICOLON_ block _SEMICOLON_
    { GRAMMAR_MACRO(procedure_declaration) };

function_declaration:
    _FUNCTION_ _IDENT_ _SEMICOLON_ block _SEMICOLON_
    { GRAMMAR_MACRO(function_declaration) };

implementation_part:
    statement
    { GRAMMAR_MACRO(implementation_part) };

/**************************************************************************/
/* STATEMENTS */

statement:
    assignment
    { GRAMMAR_MACRO(statement) }
    | procedure_call
    { GRAMMAR_MACRO(statement) }
    | if_statement
    { GRAMMAR_MACRO(statement) }
    | while_statement
    { GRAMMAR_MACRO(statement) }
    | do_statement
    { GRAMMAR_MACRO(statement) }
    | for_statement
    { GRAMMAR_MACRO(statement) }
    | compound_statement
    { GRAMMAR_MACRO(statement) };

assignment:
    _IDENT_ _ASSIGNMENT_ expression
    { GRAMMAR_MACRO(assignment) };

procedure_call:
    _CALL_ _IDENT_
    { GRAMMAR_MACRO(procedure_call) };

if_statement:
    _IF_ expression _THEN_ statement _END_IF_
    { GRAMMAR_MACRO(if_statement) };

while_statement:
    _WHILE_ expression _DO_ statement_loop _END_WHILE_
    { GRAMMAR_MACRO(while_statement) };

do_statement:
    _DO_ statement_loop _WHILE_ expression _END_DO_
    { GRAMMAR_MACRO(do_statement) };

for_statement:
    _FOR_ _IDENT_ _ASSIGNMENT_ expression _DO_ statement_loop _END_FOR_
    { GRAMMAR_MACRO(for_statement) };

compound_statement:
    _BEGIN_ statement_loop _END_
    { GRAMMAR_MACRO(compound_statement) };

statement_loop:
    statement
    | statement_loop _SEMICOLON_ statement
    { GRAMMAR_MACRO(statement_loop) };

/**************************************************************************/
/* EXPRESSIONS, TERMS AND IDENTIFIERS */

expression :
    expression_loop
    { GRAMMAR_MACRO(expression) };

expression_loop:
    term
    | expression_loop
    '+'
    term
    { GRAMMAR_MACRO(expression_loop) }
    | expression_loop
    '-'
    term
    { GRAMMAR_MACRO(expression_loop) };

term:
    term_loop
    { GRAMMAR_MACRO(term) };

term_loop:
    id_num
    | term_loop
    '*'
    id_num
    { GRAMMAR_MACRO(term_loop) }
    | term_loop
    '/'
    id_num
    { GRAMMAR_MACRO(term_loop) };

id_num:
    _IDENT_
    { GRAMMAR_MACRO(id_num) }
    | _NUMBER_
    { GRAMMAR_MACRO(id_num) };

/**************************************************************************/
