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
%}

%union {int num; char * id;}
%start line
%token PROGRAM
%token VAR
%token BEGIN
%TOKEN PRINT
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
%token <id> identifier
%token <num> number
%type <num> line
%type <id> pname
%type <num> expr
%type <num> term
%type <num> factor
%type <num> output;

 

%%
line	:	PROGRAM pname SEMICOLON VAR declist SEMICOLON BEGIN statlist {cout<<"asd"<<endl;}	
		;
pname	:	identifier					{cout<<"pname "<< $1<<endl;
										char * temp = $1;
										string temp2 = string(temp);
										temp2.append(".cpp");
										cout<<temp2<<endl;
										outFile.open(temp2.c_str());
										outFile<<"#include<iostream>";
										outFile<<"using namespacestd;";
										outFile.close();
										}
		;
declist	:	dec COLON type				{cout<<"after INTEGER"<<endl;}
		;
dec		:	identifier COMMA dec		{cout<<"dec"<<endl;}
		|	identifier					{cout<<"decIdentifier"<<endl;}
		;

statlist:	stat SEMICOLON				{cout<<"statlist"<<endl;}
		|	stat SEMICOLON statlist		{cout<<"statlist"<<endl;}
		;
stat	:	print						{cout<<"statprint"<<endl;}
		|	assign						{cout<<"statassign"<<endl;}
		;
print	:	PRINT OPENPER output CLOSEPER		{cout<<"PRINT"<<endl;}
		;
output	: OSQUOTE CSQUOTE				{cout<<"output4"<<endl;}
		| expr							{cout<<"output5"<<endl;}
		| expr COMMA output				{cout<<"output6"<<endl;}
		;
assign	:	identifier EQUAL expr		{updateTable($1,$3);
										cout<<"assign"<<endl;
										}
		;
expr	:	term						{$$ = $1;}
		|	expr '+' term				{$$ = $1 + $3;}
		|	expr '-' term				{$$ = $1 - $3;}
		;
term	:	term '*' factor				{$$ = $1 * $3;}
		|	term '/' factor				{$$ = $1 / $3;}
		|	factor						{$$ = $1;}
		;
factor	:	identifier					{cout<<"here at factorIdentifier"<<endl; $$ = symbolVal($1);}
		|	'(' expr ')'				{cout<<"see factorExpression"<<endl;}
		|	number						{cout<<" here at factor"<<$1<<" "<<$$<<endl; $$ = $1;}
		;
type	:	INTEGER						{;}
		;
%%
int main (void) {
return yyparse ();
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