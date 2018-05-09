%{

#include <stdlib.h>
#include <iostream>
#include <string>
#include <fstream>
#include "y.tab.h"
using std::string;
using namespace std;
void yyerror (string s);
void run(string name);
int yylex();
char * temp;
char * temp2;
char * cstr;
char * temppp;
char * temppp2;
char * cstrrr;
bool flag=true;
fstream outputFile;
string decType;
string decList;
bool VARFlag = false;
bool BEGINFlag = false;
bool PRINTFlag = false;
string breakIt(string a);
%}

%%
"PROGRAM"									{flag = true;return PROGRAM;}
"VAR"										{VARFlag = true; return VAR;}
"BEGIN"                                     {VARFlag = false; BEGINFlag = true; return BEGIN;}
"END\."                                       {outputFile<<"return 0;\n";yywrap(); return END;}
"PRINT"                                     {outputFile<<"cout << ";
											PRINTFlag = true;
											return PRINT;
											}
"INTEGER"                                   {decType = "int"; 
											decList.pop_back();
											decList.pop_back();
											outputFile<<"int " << decList;
											decList.clear();
											return INTEGER;}
([A-Za-z_])([A-Za-z0-9_])*				    {temp=yytext; 					
											string str(temp);
											cstr = new char[str.length() + 1];
						                	strcpy(cstr, str.c_str());
						                    temp2=cstr; yylval.id=temp2; 
											if(flag){
												string nameString = string(temp2);
												nameString.append(".cpp");
												run(nameString);
												flag = false;
											}
											else if(VARFlag){
												decList.append(yytext);
												decList.append(", ");
											}
											else {
												outputFile<<yytext;
											}
											return identifier;}
[0-9]+                                      {yylval.num= atoi(yytext);
											outputFile<<yytext;
											return number;}
[ \t\n]                						;
=                                           {outputFile<<" = "; return EQUAL;}
\(											{return OPENPER;}
\)											{return CLOSEPER;}
\‘											{return OSQUOTE;}
\’											{return CSQUOTE;}
;											{if(VARFlag || BEGINFlag){
												outputFile<<";\n";
												}
											PRINTFlag = false;
											return SEMICOLON;}
:                                           {return COLON;}
,                                           {
												if(PRINTFlag){
													outputFile<<" << ";
												}
												else if(!VARFlag){
													outputFile<<", ";
												}
											
											return COMMA;
											}
[+]           	   						    {outputFile<<" + ";return ADD;}
[-]           	   						 	{outputFile<<" - ";return MINUS;}
[*]           	   						    {outputFile<<" * ";return MULTI;}
[/]           	   						    {outputFile<<" / ";return DIVIDE;}
(‘.+\’)                                     {temppp=yytext;
											string str2(temppp);
											str2 = breakIt(str2);
											cstrrr = new char[str2.length() +1];
											strcpy(cstrrr, str2.c_str());
											temppp2=cstrrr; 
											yylval.id=temppp2; 
											outputFile <<"\""<<temppp2<<"\"";
											return STRING;}
\.											{return PERIOD;}
.						                    {ECHO; yyerror("unexpected character");}
%%
void run(string fileName){
	cout<<"Making cpp file "<<fileName<<endl;
	outputFile.open(fileName, fstream::out);
	outputFile<<   "#include <iostream>\nusing namespace std;\nint main(){\n";
}
string breakIt(string a) {
	string temptemp;
	for (int i =0; i <a.length(); i++) {
		if (i!=0&&i!=a.length()-1){
		temptemp+=a[i];
		}
	}
	return temptemp;
}
int yywrap (void) {delete [] cstr; delete [] cstrrr; outputFile<<"}\n";outputFile.close();return 1;}
