%{
void yyerror (char *s);
#include <stdio.h>     /* C declarations used in actions */
#include <stdlib.h>


%}

%union {
        float dec; 
        char* ptr;
        int num; 
        char str[100];
        }
%start line
%token WHITESPACE
%token BRACKETS
%token END_BRACKETS
%token MANUFACTURER
%token DEVICE_TYPE
%token DEVICE_REVISION
%token DD_REVISION
%token VARIABLE
%token LABEL
%token HELP
%token CLASS
%token TYPE
%token HANDLING
%token DEFAULT_VALUE
%token <str> STRING  
%token <num> INTEGER
%token <num> HEX
%token <dec> FLOAT
/*
%type <num> line 
%type <num> int_term hex_term
%type <dec> float_term
%type <str> str_term
*/
%%

line        : STRING WHITESPACE FLOAT     {printf("line yo\n");}
            ;
/*
int_term    : INTEGER            {$$ = $1; printf("yaac integer\n");}
            ;

hex_term    : HEX                {$$ = $1; printf("yaac hex\n");}
            ;

float_term  : FLOAT              {$$ = $1; printf("yacc float\n");}
            ;

str_term    : STRING             {$$ = $1; printf("yacc string\n");}
            ;
*/
%%
#include<stdio.h>
#include <string.h>
int main (void) 
{
    return yyparse( );
}

void yyerror (char *s) {fprintf (stderr, "%s\n", s);} 
