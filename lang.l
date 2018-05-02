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
([A-Za-z_])([A-Za-z0-9_])*				 	 {yylval.id = yytext;cout<<"identifier found"<<endl; return identifier;}
[0-9]+                                       {yylval.num= atoi(yytext); cout<<"number found"<<endl; return number;}
[ \t\n]                						 ;
=                                            {return EQUAL;}
\(											 {cout<<"OPENPERfound"<<endl; return OPENPER;}
\)											 {cout<<"CLOSEPER found"<<endl; return CLOSEPER;}
\‘											 {cout<<"OSQUOTE found"<<endl; return OSQUOTE;}
\’											 {cout<<"CSQUOTE found"<<endl; return CSQUOTE;}
;											 {return SEMICOLON;}
:                                            {return COLON;}
,                                            {return COMMA;}
.						                     {ECHO; yyerror("unexpected character");}
%%
int yywrap (void) 		                     {return 1;}