%{

#include <stdlib.h>
#include <iostream>
#include <string>
#include "y.tab.h"
using std::string;
using namespace std;
void yyerror (string s);
int yylex();
char * temp;
char * temp2;
char * cstr;
char * temppp;
char * temppp2;
char * cstrrr;
bool flag=false;
%}

%%
"PROGRAM"									 {return PROGRAM;}
"VAR"										 {return VAR;}
"BEGIN"                                      {return BEGIN;}
END\.                                        {return END;}
"PRINT"                                      {return PRINT;}
"INTEGER"                                    {return INTEGER;}
([A-Za-z_])([A-Za-z0-9_])*				     {temp=yytext; 					
											 string str(temp);
											 cstr = new char[str.length() + 1];
						                     strcpy(cstr, str.c_str());
						                     temp2=cstr; yylval.id=temp2; return identifier;}
[0-9]+                                       {yylval.num= atoi(yytext); return number;}
[ \t\n]                						 ;
=                                            {return EQUAL;}
\(											 {return OPENPER;}
\)											 {return CLOSEPER;}
\‘											 {return OSQUOTE;}
\’											 {return CSQUOTE;}
;											 {return SEMICOLON;}
:                                            {return COLON;}
,                                            {return COMMA;}
[+]           	   						     {return ADD;}
[-]           	   						 	 {return MINUS;}
[*]           	   						     {return MULTI;}
[/]           	   						     {return DIVIDE;}
(‘.+\’)                                      {temppp=yytext;
											  string str2(temppp);
										      cstrrr = new char[str2.length() +1];
											  strcpy(cstrrr, str2.c_str());
											  temppp2=cstrrr; yylval.id=temppp2; return STRING;}
.						                     {ECHO; yyerror("unexpected character");}
%%
int yywrap (void) 		                     {delete [] cstr; delete [] cstrrr; return 1;}
