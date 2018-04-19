//File:coding2part3.cpp
//Author: Duy Do
//Last Edit: 4/2/2018 4:32PM
//Git :https://github.com/DA01171997
//Note: need to compile with -std=c++11 on linux 
//g++ -std=c++11 coding2part3.cpp -o coding2part3.exe
#include <iostream>
#include <fstream>
#include <string>
#include <sstream>
#include <queue>
#include <regex>
using namespace std;

string checker(string ints);
bool alreadyInQ(string input, queue<string>Q);
void checkTokens(string tk);
int main() {
    ifstream inFile;
	int head=0;
	int tail=0;
    string line;
	string temp;
	string temp2;
	queue<string> tokens;
    queue<string> tokens2;
	queue<string> fs;
	bool intFlag=false;
	bool floatFlag=false;
    try {
        inFile.open("text.txt");                           
        if (!inFile) {                                   
            throw std::runtime_error("can't open inFile");
        }
    }
    catch (std::runtime_error &e) {                               
        cout << e.what() << endl;
    }
    while (!inFile.eof()) {
		getline(inFile, line);
		if(checker(line)=="int"){
			intFlag=true;
			head=4;
			tokens.push("int");
		}
		else if(checker(line)=="float"){
			floatFlag=true;
			head=6;
			tokens.push("float");
		}
		for (int i =head; i < line.length(); i ++) {
			if(line[i]==','||line[i]==';'){
				tail=i;
				temp=line.substr(head, tail-head);
				head=tail+2;
				tokens.push(temp);
				if(line[i]==',') {	tokens.push(","); }
				if(line[i]==';') {	tokens.push(";"); }
			}
		}
		head=0;
		tail=0;
		intFlag=false;
		floatFlag=false;
    }
	while(!tokens.empty()){
		temp2=tokens.front();
		bool equ=false;
		for (int i=0; i <temp2.length(); i++) {
			if(temp2[i]=='='){
				if(!alreadyInQ(temp2.substr(0,i),tokens2)){
				tokens2.push(temp2.substr(0,i));
				}
				if(!alreadyInQ(temp2.substr(i+1,temp2.length()-1),tokens2)){
				tokens2.push(temp2.substr(i+1,temp2.length()-1));
				}
				equ=true;
			}
		}	
		if(!equ){
			if(!alreadyInQ(temp2,tokens2)){
			tokens2.push(temp2);
			}
		}
		tokens.pop();
	}
	
	while(!tokens2.empty()){
		checkTokens(tokens2.front());
		tokens2.pop();
	}
	inFile.close();
}
string checker(string ints){
	string tempcheck;
	if(ints.substr(0,3)=="int") { return "int";}
	else if(ints.substr(0,5)=="float") { return "float";}
	else { return "error identifier";}
}
bool alreadyInQ(string input, queue<string>Q) {
    queue<string> temp = Q;
    while (!temp.empty()) {
        if (input == temp.front()) {
            return true;
        }
        temp.pop();
    }
    return false;
}
void checkTokens(string tk) {
	regex matchObj("^([A-Za-z_])([A-Za-z0-9_])*");
	regex matchObj2("^[0-9]+$");
	regex matchObj3("^[0-9]+.[0-9]+(.[0-9])+$");
	if(tk=="int"||tk=="float") {
		cout<<tk<<"\t RESERVED WORD"<<endl;
	}
	else if (regex_match(tk, matchObj)){
		cout<<tk<<"\t IDENTIFIER"<<endl;
	}
	else if (regex_match(tk, matchObj2)){
		cout<<tk<<"\t INTEGER NUMBER"<<endl;
	}
	else if(regex_match(tk, matchObj3)){
		cout<<tk<<"\t NOT REAL NUMBER"<<endl;
	}
	else if(tk==","||tk==";") {
		cout<<tk<<"\t SPECIAL CHARACTER"<<endl;
	}
	else {
		cout<<tk<<"\t INVALID TOKEN"<<endl;
	}
	
}