%{
#include "y.tab.h"
#include <stdlib.h>
#include <iostream>
#include <string>
using std::string;
using namespace std;
void yyerror (string s);
int yylex();
%}

%%
"PROGRAM"									 {return PROGRAM;}
"VAR"										 {return VAR;}
"BEGIN"                                      {return BEGIN;}
"PRINT"                                      {return PRINT;}
"INTEGER"                                    {return INTEGER;}
([A-Za-z_])([A-Za-z0-9_])*				 	 {yylval.id = yytext; return identifier;}
[0-9]+                                       {yylval.num= atoi(yytext); cout<<"number found"<<endl; return number;}
[ \t\n]                						 ;
=                                            {return EQUAL;}
'.*'                                         {return STRING;}
;											 {return SEMICOLON;}
:                                            {return COLON;}
,                                            {return COMMA;}
.						                     {ECHO; yyerror("unexpected character");}
%%
int yywrap (void) 		                     {return 1;}