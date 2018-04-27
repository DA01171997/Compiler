%{
#include "y.tab.h"
#include <string>
using std::string;
void yyerror (string s);
int yylex();
%}

%%
"PROGRAM"									 {return PROGRAM;}
"VAR"										 {return VAR;}
([A-Za-z_])([A-Za-z0-9_])*				 	 {yylval.id = yytext; return identifier;}
[ \t\n]                						 ;
;											 {return SEMICOLON;}
.						                     {ECHO; yyerror("unexpected character");}
%%
int yywrap (void) 		                     {return 1;}