%{
#include <stdio.h>     /* C declarations used in actions */
#include <stdlib.h>
#include <string.h>

int yylex(void);
void yyerror (char *s);
%}

%union {
        float dec; 
        char* ptr;
        int num; 
        char str[100];
        }
%start line
%token <num> WHITESPACE
%token <num> BRACKETS
%token <num> END_BRACKETS
%token <str> MANUFACTURER
%token <str> DEVICE_TYPE
%token <str> DEVICE_REVISION
%token <str> DD_REVISION
%token <str> VARIABLE
%token <str> LABEL
%token <str> HELP
%token <str> CLASS
%token <str> TYPE
%token <str> HANDLING
%token <str> DEFAULT_VALUE
%token <str> STRING  
%token <num> INTEGER
%token <num> HEX
%token <dec> FLOAT
%type <num> line 
%type <num> int_term hex_term
%type <dec> float_term
%type <str> set_term
%type <str> string_term

%%

line        : set_term WHITESPACE string_term {printf("line1: %s %d\n", $1, $3);}
            | set_term WHITESPACE int_term {printf("line2: %s %d\n", $1, $3);}
            | set_term WHITESPACE hex_term {printf("line3: %s %d\n", $1, $3);}
            | set_term WHITESPACE float_term {printf("line4: %s %f\n", $1, $3);}
            ;

int_term    : INTEGER            {$$ = $1; printf("integer: %d\n", $1);}
            ;

hex_term    : HEX                {$$ = $1; printf("hex: %d\n", $1);}
            ;

float_term  : FLOAT              {$$ = $1; printf("float: %d\n", $1);}
            ;

set_term    : MANUFACTURER      { printf("set_term: MANUFACTURER\n");}  
            | DEVICE_TYPE       { printf("set_term: DEVICE_TYPE\n");}
            | DEVICE_REVISION   { printf("set_term: DEVICE_REVISION\n");}
            | DD_REVISION       { printf("set_term: DD_REVISION\n");}
            | VARIABLE          { printf("set_term: VARIABLE\n");}
            | LABEL             { printf("set_term: LABEL\n");}
            | HELP              { printf("set_term: HELP\n");}
            | CLASS             { printf("set_term: CLASS\n");}
            | TYPE              { printf("set_term: TYPE\n");}
            | HANDLING          { printf("set_term: HANDLING\n");}
            | DEFAULT_VALUE     { printf("set_term: DEFAULT_VALUE\n");}
            ;

string_term : STRING            {printf("set_term: \n");}
            ;

%%      /* C code */
#include <stdio.h>
#include <string.h>

void yyerror (char *s) {fprintf (stderr, "%s\n", s);} 
