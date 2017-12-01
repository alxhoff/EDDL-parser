%{
#include <stdio.h>     /* C declarations used in actions */
#include <stdlib.h>
#include <string.h>

void yyerror (char *s);
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
%token <str> MANUFACTURER
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
%type <num> line 
%type <num> int_term hex_term
%type <dec> float_term
%type <str> str_term

%%

line        : float_term       {printf("float yo\n");}
            | int_term         {printf("integer yo\n");}
            | hex_term         {printf("hex yo\n");}
            | str_term         {printf("string yo\n");}
            | line float_term       {printf("float yo\n");}
            | line int_term         {printf("integer yo\n");}
            | line hex_term         {printf("hex yo\n");}
            | line str_term         {printf("string yo\n");}
            ;

int_term    : INTEGER            {$$ = $1; printf("yaac integer\n");}
            ;

hex_term    : HEX                {$$ = $1; printf("yaac hex\n");}
            ;

float_term  : FLOAT              {$$ = $1; printf("yacc float\n");}
            ;

str_term    : STRING             {strcpy($$,$1); printf("yacc string\n");}
            | MANUFACTURER      {printf("here: %s\n", $1);}  
            ;

%%
#include<stdio.h>
#include <string.h>
int main (void) 
{
    return yyparse( );
}

void yyerror (char *s) {fprintf (stderr, "%s\n", s);} 
