scanner: lex.yy.c y.tab.c
		gcc -g lex.yy.c y.tab.c eddlparser.c -o scanner 

lex.yy.c: y.tab.c eddl.lex
		lex eddl.lex

y.tab.c: eddl.y
	   yacc -d eddl.y #--debug #--verbose

clean:
		rm -f lex.yy.c y.tab.c y.tab.h scanner
