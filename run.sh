bison -d -v next.y
flex next.l
g++ -std=c++11 lex.yy.c  next.tab.c next.cpp
./a.out $1 $2
mv latex.tex $2

clean: rm *.tex lex.yy.c next.output next.tab.* 
