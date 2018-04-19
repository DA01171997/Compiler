all: program1
program1:
	g++ main.cpp -o main.exe
clean:
	rm *.exe
