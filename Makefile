all: program1
program1:
	g++ main.cpp -std=c++11 -o main.exe
clean:
	rm *.exe
