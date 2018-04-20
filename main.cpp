#include <iostream>
#include <fstream>
#include <string>
#include <sstream>
#include <algorithm>
#include <queue>
#include <regex>
using namespace std;
queue<string> tokens;
void parseComment();
void parseSpace();

//regex matchObj("^([A-Za-z_])([A-Za-z0-9_])*"); //Identifier
int main(){
	parseComment();
	parseSpace();
	return 0;
}
void parseComment(){
		ofstream outFile;
		ifstream inFile;
		string line;
		bool comment=false;
		bool colonFlag=false;
		try {
			inFile.open("final.txt"); 
			outFile.open("part1.txt", ofstream::out);
			if (!inFile) {                                   
				throw std::runtime_error("Can't open inFile");
			}
		}
		catch (std::runtime_error &e) {                               
        cout << e.what() << endl;
		}
	    while (!inFile.eof()) {
		getline(inFile, line);
		line.erase(remove(line.begin(), line.end(), '\r'), line.end());
		line.erase(remove(line.begin(), line.end(), '\t'), line.end());
		if (line.empty()) continue; 
		else {
			for(int i =0; i< line.length(); i++) {
				if(line[i]=='('&&line[i+1]=='*') {
					comment=true;
				}
				if(line[i]=='*'&&line[i+1]==')') {
					comment=false;
					i++;
				}
				else if(!comment) {
				outFile<<line[i];
				if(line[i]==';'){colonFlag=true;}
				}
			}
			//if(!comment)outFile<<endl;
			if (colonFlag){
				outFile<<endl;
				colonFlag=false;
			}
			else if(!comment&&line[line.length()-2]!='*'&&line[line.length()-1]!=')') outFile<<endl;

		}
		}
	outFile.close();
	inFile.close();
}
void parseSpace() {
		int head=0;;
		int tail;
		bool flag=false;
		bool add=false;
		bool minus=false;
		bool multi=false;
		bool divide=false;
		bool equal =false;
		bool quote=false;
		int counter=0;
		string temp;
		string temp2;
		string temp3;
		string temp4;
		ofstream outFile2;
		ifstream inFile2;
		string line;
		bool comment=false;
		try {
			inFile2.open("part1.txt"); 
			outFile2.open("part2.txt", ofstream::out);
			if (!inFile2) {                                   
				throw std::runtime_error("Can't open inFile2");
			}
		}
		catch (std::runtime_error &e) {                               
        cout << e.what() << endl;
		}
	    while (!inFile2.eof()) {
		getline(inFile2, line);
		line.erase(remove(line.begin(), line.end(), '\r'), line.end());
		line.erase(remove(line.begin(), line.end(), '\t'), line.end());
		line.erase(remove(line.begin(), line.end(), ' '), line.end());
				if((temp=line.substr(0,7))=="PROGRAM"){
					tokens.push("PROGRAM");
					temp=line.substr(0,7);
					head=7;
				}
				else if((temp=line.substr(0,3))=="VAR"){
					tokens.push("VAR");
					temp=line.substr(0,3);
					head=3;
				}
				else if((temp=line.substr(0,5))=="BEGIN"){
					tokens.push("BEGIN");
					temp=line.substr(0,5);
					head=5;
				}
				else if((temp=line.substr(0,4))=="END."){
					temp=line.substr(0,4);
					tokens.push("END.");
					head=4;
				}
			for (int i=head; i < line.length(); i ++) {
				if(line[i]==','||line[i]==';'||line[i]==':'){
					tail=i;
					temp=line.substr(head, tail-head);
					tokens.push(temp);
					head=tail+1;
					if(line[i]==',') {	tokens.push(","); }
					if(line[i]==';') {	tokens.push(";"); }
					if(line[i]==':') {	tokens.push(":"); }
				}
			}
			head=0;
			tail=0;
		}
		head=0;
		tail=0;
		while(!tokens.empty()){
		temp2=tokens.front();
		if (temp2==","||temp2=="PROGRAM"){
			outFile2<<temp2<<" ";
		}
		else if (temp2=="VAR"||temp2=="BEGIN"||temp2==";"){
			outFile2<<temp2<<endl; 
		}
		else if (temp2==":"){
			outFile2<<" "<<temp2<<" ";
		}
		else if ((temp2.substr(0,5)=="PRINT")){
			outFile2<<temp2;
			}
		else {
			for(int i =0; i <temp2.length(); i++){
				if(temp2[i]=='='&&quote==false){
					tail=i;
					temp3=temp2.substr(head,tail-head);
					temp4=temp2.substr(tail+1,temp2.length()-tail-1);
					equal=true;
				}
			}	
			if(equal){
				temp2=temp3+" = " +temp4;
				equal=false;
			}
			for(int i =0; i <temp2.length(); i++){
				if(temp2[i]=='+'){
					tail=i;
					temp3=temp2.substr(head,tail-head);
					temp4=temp2.substr(tail+1,temp2.length()-tail-1);
					add=true;
				}
			}
			if(add){
				temp2=temp3+" + " +temp4;
				add=false;
			}
			for(int i =0; i <temp2.length(); i++){
				if(temp2[i]=='*'){
					tail=i;
					temp3=temp2.substr(head,tail-head);
					temp4=temp2.substr(tail+1,temp2.length()-tail-1);
					multi=true;
				}
			}
			if(multi){
				temp2=temp3+" * " +temp4;
				multi=false;
			}
			for(int i =0; i <temp2.length(); i++){
				if(temp2[i]=='-'){
					tail=i;
					temp3=temp2.substr(head,tail-head);
					temp4=temp2.substr(tail+1,temp2.length()-tail-1);
					minus=true;
				}
			}
			if(minus){
				temp2=temp3+" - " +temp4;
				minus=false;
			}
			for(int i =0; i <temp2.length(); i++){
				if(temp2[i]=='/'){
					tail=i;
					temp3=temp2.substr(head,tail-head);
					temp4=temp2.substr(tail+1,temp2.length()-tail-1);
					divide=true;
				}
			}
			if(divide){
				temp2=temp3+" / " +temp4;
				divide=false;
			}			
			outFile2<<temp2;
			
		}
		tokens.pop();
		}

	outFile2.close();
	inFile2.close();
}