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
        char* str;
        int num; 
        eddl_variable_t* var;
        }
/*%start line*/
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
/*%type <dec> float_term*/
%type <num> int_term
%type <num> hex_term
/*%type <str> str_term*/
%%


line        : MANUFACTURER  WHITESPACE int_term          {printf("manufacturer: %d\n", $3);}
            | DEVICE_TYPE   WHITESPACE hex_term           {printf("device type: %d\n", $3);}
            | DEVICE_REVISION WHITESPACE int_term       {printf("device revision: %d\n", $3);}
            | line DEVICE_TYPE   WHITESPACE hex_term           {printf("device type: %d\n", $3);}
            | line DEVICE_REVISION WHITESPACE int_term       {printf("device revision: %d\n", $3);}
/*            | DD_REVISION WHITESPACE int_term           {printf("DD revision: %d\n", $3);}
            | HANDLING WHITESPACE str_term              {printf("Handling: %s", $3);}
            | var_term BRACKETS def_val                 {printf("var term\n");}*/
            ;
/*
def_val     : DEFAULT_VALUE WHITESPACE int_term         {printf("default value f: %f\n", $3);}
            ;

var_term    : VARIABLE WHITESPACE str_term              {printf("variable: %s", $3);}
            ;
*/
/*float_term  : FLOAT             {$$ = $1; printf("float: %f\n", $1);}*/
            ;

int_term    : INTEGER           {$$ = $1; printf("integer: %d\n", $1);}
            ;

hex_term    : HEX               {$$ = $1; printf("hex: %d\n", $1);}
            ;
/*
str_term    : STRING            {$$ = $1; printf("string: %s\n", $1);}
            ;
*/

%%      /* C code */
#include <stdio.h>
#include <string.h>

void yyerror (char *s) {fprintf (stderr, "%s\n", s);} 
