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
bool valid = true;
bool alreadySmells = false;
%}

%union {int num; char * id;}
%start line
%token PROGRAM
%token VAR
%token BEGIN
%token PRINT
%token END
%token PERIOD
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
line	:	PROGRAM pname SEMICOLON error declist SEMICOLON BEGIN statlist END {cout<<"VAR is expected"<<endl; valid = false; ifValid();}
		|	error pname SEMICOLON VAR declist SEMICOLON BEGIN statlist END		{cout<<"PROGRAM is expected"<<endl;  valid = false; ifValid();}
		|	PROGRAM pname SEMICOLON VAR declist SEMICOLON error statlist END	{cout<<"BEGIN is expected"<<endl;  valid = false; ifValid();}
		|	PROGRAM pname SEMICOLON VAR declist SEMICOLON BEGIN statlist error	{cout<<"END. is expected"<<endl;  valid = false;ifValid();}
		|	PROGRAM pname error VAR declist SEMICOLON BEGIN statlist END {cout<<"; is missing"<<endl;  valid = false; ifValid();}
		|	PROGRAM pname SEMICOLON VAR declist error BEGIN statlist END {cout<<"; is missing"<<endl;  valid = false; ifValid();}
		|	PROGRAM pname SEMICOLON VAR declist SEMICOLON BEGIN statlist END {ifValid();}
		;
pname	:	identifier					{cout<<"Program name: "<< $1<<endl<<endl;}
		|	error						{cout<<"UNKNOWN IDENTIFIER"<<endl; valid = false;ifValid();}
		;
declist	:	dec COLON type				{;}
		;
dec		:	identifier COMMA dec		{;}
		|	identifier					{;}
		|	identifier error dec		{cout<<", is missing"<<endl; valid = false;ifValid();}
		;

statlist:	stat SEMICOLON				{;}
		|	stat SEMICOLON statlist		{;}
		| 	stat error statlist			{cout<<"; is missing"<<endl; valid = false;ifValid();}
		|	stat error					{cout<<"; is missing"<<endl; valid = false;ifValid();}
		;
stat	:	print						{;}
		|	assign						{;}
		;
print	:	PRINT OPENPER output CLOSEPER {cout<<"Printing: "<<$3<<endl;}
		|	PRINT output CLOSEPER		{cout<<"( is missing"<<endl;}
		|	PRINT OPENPER output 		{cout<<") is missing"<<endl;}
		;
output	: expr							{tempStr=to_string($1);
										temP = new char [tempStr.length()+1];
										strcpy(temP, tempStr.c_str());
										$$=temP;
										}
		| expr COMMA STRING				{tempStr=to_string($1);
										string tempStr2($3);
										tempStr+=tempStr2;
										temP = new char [tempStr.length()+1];
										strcpy(temP, tempStr.c_str());
										$$=temP;
										}
		
		| STRING						{$$=$1;}
		| output COMMA output			{tempStr=(string) $1;
										 tempStr2=(string) $3;
										 tempStr+=tempStr2;
										 temP = new char [tempStr.length()+1];
										 strcpy(temP, tempStr.c_str());
										 $$=temP;
										}
		
		| STRING COMMA expr				{tempStr=to_string($3);
										string tempStr2($1);
										tempStr2+=tempStr;
										temP = new char [tempStr2.length()+1];
										strcpy(temP, tempStr2.c_str());
										$$=temP;
										}
		
		| expr error output				{cout<<", is missing"<<endl; valid = false;ifValid();}
		| STRING error expr				{cout<<", is missing"<<endl; valid = false;ifValid();}
		;
assign	:	identifier EQUAL expr		{updateTable($1,$3); cout<<"Assignment: "<<$1<<"="<<$3<<endl;}
		|	identifier error expr		{cout<<"= is missing"<<endl; valid = false;ifValid();}
		|	error EQUAL expr			{cout<<"UNKNOWN IDENTIFIER"; valid = false;ifValid();}
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
		|	error						{cout<<"UNKNOWN IDENTIFIER"; valid = false;ifValid();}
		;
%%
int main (void) {
	for (int i =0; i<52; i++){
		symbols[i]=0;
	}
	delete [] temP;
	return yyparse();
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
void ifValid(){
	if(!alreadySmells){
		alreadySmells = true;
		if(valid){
			cout<<endl<<"VALID LANGUAGE"<<endl;
		}
		else cout<<endl<<"INVALID LANGUAGE"<<endl;
	}
}