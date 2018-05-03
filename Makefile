default: main lang
main: main.cpp
	g++ main.cpp -o main.exe -std=c++11

lang: lex.yy.c y.tab.c
	g++ -g lex.yy.c y.tab.c -std=c++11 -o lang

lex.yy.c: y.tab.c lang.l
	lex lang.l

y.tab.c: lang.y
	yacc -d lang.y

clean: 
	rm -rf lex.yy.c y.tab.c y.tab.h lang lang.dSYM

