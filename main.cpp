#include <iostream>
#include <fstream>
#include <string>
#include <sstream>
#include <algorithm>
using namespace std;

void parseComment();
void parseSpace();
int main(){
	int tempHead;
	int tempTail;
	parseComment();
	
	return 0;
}
void parseComment(){
	ofstream outFile;
	ifstream inFile;
	string line;
	bool comment=false;
	bool readingToken = true;
	bool emptyLine = true;
	bool beginningOfLine;
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
		line.erase(remove(line.begin(), line.end(), '\t'), line.end());
		//line.erase(remove(line.begin(), line.end(), '\n'), line.end());
		beginningOfLine = true;
		for(int i =0; i< line.length(); i++) {
			if(line[i]=='(') {
				if (line[i+1]=='*'){
				comment=true;
				}
			}
			if(!comment) {
				if(line[i] != ' ' && line[i] != ',' && line[i] != ';' &&
					line[i] != '='&&line[i] != '+'&&line[i] != '-'&&line[i] != '*'&&line[i] != ':' ){			//readingToken is true when line[i] != ' '
					if(!readingToken && !beginningOfLine){														// 				  false when line[i] hits a ' '
						outFile<<' ';
					}
					outFile<<line[i];
					beginningOfLine = false;
					readingToken = true;
					emptyLine = false;
				}
				if(line[i] == ';'){
					outFile<<';';
				}
				if(line[i] ==','){
					outFile<<',';
				}
				if((line[i] == '='||line[i] == '+'||line[i] == '-'||line[i] == '*'||line[i] == ':' )){
					outFile<<' '<<line[i];
					if(line[i+1]!=' '){outFile<<' ';}
				}
				if(line[i] == ' ' && readingToken == true){
					readingToken = false;
				}
			}
			if(line[i]=='*') {
				if (line[i+1]==')'){
				comment=false;
				i++;
				}
			}
		}
		if(!comment && !emptyLine){
			outFile<<endl;
			emptyLine = true;
		}	
	}
	outFile.close();
	inFile.close();
}
void parseSpace() {
		ofstream outFile2;
		ifstream inFile2;
		string line;
		bool comment=false;
		try {
			inFile2.open("partl.txt"); 
			outFile2.open("part2.txt", ofstream::out);
			if (!inFile2) {                                   
				throw std::runtime_error("Can't open inFile2");
			}
		}
		catch (std::runtime_error &e) {                               
        cout << e.what() << endl;
		}
	    while (!inFile2.eof()) {
			
		}
	
}