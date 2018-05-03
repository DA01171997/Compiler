%{
int yylex();
#include <stdio.h>     
#include <stdlib.h>
#include <ctype.h>
#include <iostream>
#include <string>
#include <fstream>
using namespace std;
void yyerror (string message);
int symbols[52];
int hashh(char * a);
void updateTable(char * symbol, int val);
int symbolVal(char * symbol);
fstream outFile;
char * temP;
char * temP2;
string tempStr;
string tempStr2;
%}

%union {int num; char * id;}
%start line
%token PROGRAM
%token VAR
%token BEGIN
%token PRINT
%token END
$token EQUAL
%token SEMICOLON
%token COLON
%token COMMA
%token OSQUOTE
%token CSQUOTE
%token INTEGER
%token OPENPER
%token CLOSEPER
%token ADD
%token MINUS
%token MULTI
%token DIVIDE
%token <id> identifier
%token <num> number
%type <num> line
%type <id> pname
%type <num> expr
%type <num> term
%type <num> factor
%type <id> output
%token <id> STRING

 

%%
line	:	PROGRAM pname SEMICOLON VAR declist SEMICOLON BEGIN statlist END {cout<<"asd"<<endl;}	
		;
pname	:	identifier					{cout<<"pname "<< $1<<endl;
										char * temp = $1;
										string temp2 = string(temp);
										temp2.append(".cpp");
										cout<<temp2<<endl;
										outFile.open(temp2.c_str());
										outFile<<"#include<iostream>";
										outFile<<"using namespacestd;";
										
										}
		;
declist	:	dec COLON type				{;}
		;
dec		:	identifier COMMA dec		{;}
		|	identifier					{;}
		;

statlist:	stat SEMICOLON				{;}
		|	stat SEMICOLON statlist		{;}
		;
stat	:	print						{;}
		|	assign						{;}
		;
print	:	PRINT OPENPER output CLOSEPER		{;}
		;
output	: expr							{tempStr=to_string($1);
										temP = new char [tempStr.length()+1];
										strcpy(temP, tempStr.c_str());
										$$=temP;
										}
		| expr COMMA output				{;}
		| STRING						{;}
		| STRING COMMA expr				{ cout<<$1<<$3<<endl;}
		;
assign	:	identifier EQUAL expr		{updateTable($1,$3);}
		;
expr	:	term						{$$ = $1;}
		|	expr ADD term				{$$ = $1 + $3;}
		|	expr MINUS term				{$$ = $1 - $3;}
		;
term	:	term MULTI factor			{$$ = $1 * $3;}
		|	term DIVIDE factor			{$$ = $1 / $3;}
		|	factor						{$$ = $1;}
		;
factor	:	identifier					{$$ = symbolVal($1);}
		|	'(' expr ')'				{;}
		|	number						{$$ = $1;}
		;
type	:	INTEGER						{;}
		;
%%
int main (void) {
for (int i =0; i<52; i++){
	symbols[i]=0;
}
delete [] temP;
return yyparse ();
outFile.close();
}


void yyerror (string message) {cout<<message<<endl;}
int hashh(char * a) {
	int index = 0;
	for (int i = 0; i < sizeof(a)/sizeof(a[0]); i++) {
		index += a[i] * (i+1);
	}
	return index%99;
}
void updateTable(char * symbol, int val) {
	int hashedIndex = hashh(symbol);
	symbols[hashedIndex] = val;
}
int symbolVal(char * symbol)
{
	int bucket = hashh(symbol);
	return symbols[bucket];
}