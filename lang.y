%{
int yylex();
#include <stdio.h>     
#include <stdlib.h>
#include <ctype.h>
#include <iostream>
#include <string>
using namespace std;
void yyerror (string message);
%}

%union {int num; char * id;}
%start line
%token PROGRAM
%token VAR
%token SEMICOLON
%token <id> identifier
%type <num> line 

%%
line	:	PROGRAM identifier SEMICOLON {cout<<"See PROGRAM "<<$2<<endl;}
			|	VAR {cout<<"hi"<<endl;}
		;

		
%%
int main (void) {
return yyparse ();
}
void yyerror (string message) {cout<<message<<endl;}