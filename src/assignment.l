/* DEFINITIONS */

%{
%}

%% /* RULES */

[ \t\n\r]+  ;
.           {
                fprintf(stderr, "Unexpected Token: '%s' at '%d'\n", yytext, *yytext);
                exit(1);
            }

%% /* USER ROUTINES */

int yywrap(void) { return 1; }
