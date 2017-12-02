scanner: eddl_parser_main.c eddl_tokens.h lex.yy.c
		cc eddl_parser_main.c lex.yy.c -o scanner 

lex.yy.c: eddl.lex
		lex eddl.lex

clean:
		rm scanner
		rm lex.yy.c
