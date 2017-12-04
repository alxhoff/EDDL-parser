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
%type <dec> float_term
%type <num> int_term
%type <num> hex_term
%type <str> str_term
%%

line            : man_term                              {printf("man term prop\n");}
                | dev_t_term                            {printf("dev t term prop\n");}
                | dev_rev_term                          {printf("dev rev term prop\n");}
                | dd_rev_term                           {printf("dd rev term prop\n");}
                | var_term bracket_grp                  {printf("var term brackets\n");}
                | line man_term                         {printf("2 man term prop\n");}
                | line dev_t_term                       {printf("2 dev t term prop\n");}
                | line dev_rev_term                     {printf("2 dev rev term prop\n");}
                | line dd_rev_term                      {printf("2 dd rev term prop\n");}
                | line var_term bracket_grp             {printf("line var term brackets\n");}
                ;

bracket_grp     : BRACKETS var_property END_BRACKETS    {printf("bracket group\n");}
                | 
                ;

/* variable properties */
var_property    : label_prop                            {printf("label prop\n");}
                | help_prop                             {printf("help prop\n");}
                | class_prop                            {printf("class prop\n");}
                | type_prop                             {printf("type prop\n");}
                | hand_prop                             {printf("hand prop\n");}
                | def_val                               {printf("def val prop\n");} 
                | var_property label_prop               {printf("2 label prop\n");}
                | var_property help_prop                {printf("2 help prop\n");}
                | var_property class_prop               {printf("2 class prop\n");}
                | var_property type_prop                {printf("2 type prop\n");}
                | var_property hand_prop                {printf("2 hand prop\n");}
                | var_property def_val                  {printf("2 def val prop\n");} 
                ;

/* default values */

def_val         : BRACKETS def_val_line END_BRACKETS    {printf("var prop def\n");}
                ;

/* Individual lines */
man_term        : MANUFACTURER WHITESPACE int_term      {printf("manufacturer: %d\n", $3);}
                ;

dev_t_term      : DEVICE_TYPE WHITESPACE hex_term       {printf("device type: %d\n", $3);}
                ;

dev_rev_term    : DEVICE_REVISION WHITESPACE int_term   {printf("device revision: %d\n", $3);}
                ;

dd_rev_term     : DD_REVISION WHITESPACE int_term       {printf("DD revision: %d\n", $3);}
                ;

var_term        : VARIABLE WHITESPACE str_term          {printf("variable: %s\n", $3);}
                ;

label_prop      : LABEL WHITESPACE str_term             {printf("label: %s\n", $3);}
                ;

help_prop       : HELP WHITESPACE str_term              {printf("help: %s\n", $3);}
                ;

class_prop      : CLASS WHITESPACE str_term             {printf("class: %s\n", $3);}
                ;

type_prop       : TYPE WHITESPACE str_term              {printf("type: %s\n", $3);}
                ;

hand_prop       : HANDLING WHITESPACE str_term          {printf("Handling: %s\n", $3);}
                ;

def_val_line    : DEFAULT_VALUE WHITESPACE float_term         {printf("def val f\n");}
                | DEFAULT_VALUE WHITESPACE int_term           {printf("def val i\n");}
                | DEFAULT_VALUE WHITESPACE hex_term           {printf("def val h\n");}
                ;

/* Fundemental values */

float_term      : FLOAT                                 {$$ = $1; printf("float: %f\n", $1);}
                ;

int_term        : INTEGER                               {$$ = $1; printf("integer: %d\n", $1);}
                ;

hex_term        : HEX                                   {$$ = $1; printf("hex: %d\n", $1);}
                ;

str_term        : STRING                                {$$ = $1; printf("string: %s\n", $1);}
                ;

%%      /* C code */
#include <stdio.h>
#include <string.h>

void yyerror (char *s) {fprintf (stderr, "%s\n", s);} 
