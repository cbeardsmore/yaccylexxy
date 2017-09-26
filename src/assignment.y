%{
#include <stdio.h>

int yylex();

void yyerror(const char* msg) {
        fprintf(stderr, "%s\n", msg);
   }

#define GRAMMAR_MACRO(TYPE) { \
        printf("YACC MATCHED RULE: " #TYPE "\n"); \
    }
%}

%token
    _ASSIGNMENT_
    _ARRAY_
    _BEGIN_
    _CALL_
    _CONST_
    _DECLARATION_
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

%%

basic_program:
    declaration_unit
        { GRAMMAR_MACRO(basic_program) }
    |	implementation_unit
        { GRAMMAR_MACRO(basic_program) };

declaration_unit:
    _DECLARATION_ _OF_ _IDENT_
        opt_constant_declaration
        opt_variable_declaration
        opt_type_declaration
        opt_procedure_interface
        opt_function_interface
    _DECLARATION_ _END_
    { GRAMMAR_MACRO(declaration_unit) };

opt_constant_declaration:
    _CONST_ constant_declaration
    { GRAMMAR_MACRO(opt_constant_declaration) }
    | {};

opt_variable_declaration:
    _VAR_ constant_declaration
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

formal_parameters:
    '(' ident_loop_semicolon ')'
    { GRAMMAR_MACRO(formal_parameters) };

ident_loop_semicolon:
    _IDENT_
    | ident_loop _SEMICOLON_ _IDENT_
    { GRAMMAR_MACRO(ident_loop_semicolon) };

constant_declaration:
    constant_loop _SEMICOLON_
    { GRAMMAR_MACRO(constant_declaration) };

constant_loop:
    _IDENT_ '=' _NUMBER_
    | constant_loop ',' _IDENT_ '=' _NUMBER_
    { GRAMMAR_MACRO(constant_loop) };

variable_declaration:
    variable_loop _SEMICOLON_
    { GRAMMAR_MACRO(variable_declaration) };

variable_loop:
    _IDENT_ ':' _IDENT_
    | variable_loop ',' _IDENT_ ':' _IDENT_
    { GRAMMAR_MACRO(variable_loop) };

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

enumerated_type:
    '{' ident_loop_comma '}'
    { GRAMMAR_MACRO(enumerated_type) };

ident_loop_comma:
    _IDENT_
    | ident_loop_comma ',' _IDENT_
    { GRAMMAR_MACRO(ident_loop_comma) };

range_type:
    '[' range ']'
    { GRAMMAR_MACRO(range_type) };

array_type:
    _ARRAY_ _IDENT_ '[' range ']' _OF_ type
    { GRAMMAR_MACRO(array_type) };

range:
    _NUMBER_ _DOUBLE_DOT_ _NUMBER_
    { GRAMMAR_MACRO(range) };

implementation_unit:
    _IMPLEMENTATION_ _OF_ _IDENT_ block '.'
    { GRAMMAR_MACRO(implementation_unit) };

block:
    specification_part implementation_part
    { GRAMMAR_MACRO(block) };

specification_part:

procedure_declaration:

function_declaration:

implementation_part:

statement:

assignment:

procedure_call:

if_statement:

while_statement:

do_statement:

for_statement:

compound_statement:

statement_loop:

expression:

term:

id_num:
    _IDENT_
    { GRAMMAR_MACRO(id_num) }
    | _NUMBER_
    { GRAMMAR_MACRO(id_num) };
