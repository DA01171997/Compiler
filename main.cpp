#include <iostream>
#include <fstream>
#include <string>
#include <sstream>
#include <vector>

using namespace std;

int main(){
	string line;
	ofstream outFile;
	ifstream inFile;
	int tempHead;
	int tempTail;
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
    while (getline(inFile, line)) {
		vector<char> vec(line.c_str(), line.c_str() + line.size() + 1);
		string input;
		for (int i = 0; i < vec.size(); i++) {
			if(vec[i] == '(' && vec[i+1] =='*'){
				comment = true;
			}
			if(!comment){
				outFile<<vec[i];
			}
			if(vec[i] == '*' && vec[i+1] ==')'){
				comment = false;
				i++;
			}
		}
		if(!comment){outFile<<endl;}
	}
	outFile.close();
	inFile.close();
	return 0;
}