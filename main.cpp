#include <iostream>
#include <fstream>
#include <string>
#include <sstream>

using namespace std;

int main(){
	string line;
	ofstream outFile;
	ifstream inFile;
	int tempHead;
	int tempTail;
	bool flag=false;
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
		outFile<<"hello"<<endl;
		getline(inFile, line);
		for(int i =0; i< line.length(); i++) {
			if(line[i]=='(') {
				if (line[i+1]=='*'){
				flag=true;
				}
			}
			else if(line[i]=='*') {
				if (line[i+1]==')'){
				flag=false;
				}
			}
			if(!flag) {
			outFile<<line[i];
			}
		}
		
	}
	outFile.close();
	inFile.close();
	return 0;
}