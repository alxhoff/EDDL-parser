%{
#include <stdio.h>     /* C declarations used in actions */
#include <stdlib.h>
#include <string.h>

#include "eddl_data_type.h"

int yylex(void);
void yyerror (char *s);
%}

%union {
        float dec; 
        char* ptr;
        int num; 
        char str[100];
        eddl_variable_t* var;
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
%type <dec> float_term

%%

line        : MANUFACTURER  WHITESPACE float_term        {printf("line1: %s %l\n", $1, $3);}
            ;

float_term  : FLOAT              {$$ = $1; printf("float: %f\n", $1);}
            ;

%%      /* C code */
#include <stdio.h>
#include <string.h>

void yyerror (char *s) {fprintf (stderr, "%s\n", s);} 
