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
		for(int i =0; i< line.length(); i++) {
			if(line[i]=='(') {
				if (line[i+1]=='*'){
				comment=true;
				}
			}
			if(!comment) {
			outFile<<line[i];
			}
			if(line[i]=='*') {
				if (line[i+1]==')'){
				comment=false;
				i++;
				}
			}
		}
		if(!comment){outFile<<endl;}	
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