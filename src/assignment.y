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
        opt_formal_parameters;
    { GRAMMAR_MACRO(procedure_interface) };

function_interface:
    _FUNCTION_ _IDENT_
        opt_formal_parameters
    { GRAMMAR_MACRO(function_interface) };
