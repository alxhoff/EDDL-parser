%{
#include <stdio.h>     /* C declarations used in actions */
#include <stdlib.h>
#include <string.h>

//#include "eddl_data_type.h"
#include "eddlparser.h"

extern eddl_object_t* doc_object;
int yylex(void);
void yyerror (char *s);
%}

%union {
        float dec; 
        char* str;
        uint16_t uint;
        int num; 
        eddl_variable_t* var;
        class_mask_t class;
        type_mask_t type;
        handling_mask_t hand;
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
%type <num> man_term dev_t_term dev_rev_term dd_rev_term 
%type <str> var_term label_prop help_prop 
%type <class> class_prop 
%type <type> type_prop 
%type <hand> hand_prop
%type <dec> def_val_f def_val_line_f
%type <dec> float_term
%type <num> int_term
%type <num> hex_term
%type <str> str_term
%%

line            : man_term                              {eddl_parser_set_manufacturer(doc_object, $1);
                                                        //printf("man term prop: %d\n", $1);
                                                        }
                | dev_t_term                            {eddl_parser_set_device_type(doc_object, $1);
                                                        //printf("dev t term prop: %d\n", $1);
                                                        }
                | dev_rev_term                          {eddl_parser_set_device_revision(doc_object, $1);
                                                        //printf("dev rev term prop\n");
                                                        }
                | dd_rev_term                           {eddl_parser_set_dd_revision(doc_object, $1);
                                                        //printf("dd rev term prop\n");
                                                        }
                /*| var_term bracket_grp                  {eddl_parser_create_variable_t(doc_object);
                                                        printf("var term brackets\n");}
              */| line man_term                         {eddl_parser_set_manufacturer(doc_object, $2);
                                                        //printf("2 man term prop: %d\n", $2);
                                                        }
                | line dev_t_term                       {eddl_parser_set_device_type(doc_object, $2);
                                                        //printf("2 dev t term prop %d\n", $2);
                                                        }
                | line dev_rev_term                     {eddl_parser_set_device_revision(doc_object, $2);
                                                        //printf("2 dev rev term prop %d\n", $2);
                                                        }
                | line dd_rev_term                      {eddl_parser_set_dd_revision(doc_object, $2);
                                                        //printf("2 dd rev term propi %d\n", $2);
                                                        }
                | line var_term bracket_grp             {/*eddl_parser_create_variable_t(doc_object);*/
                                                        eddl_parser_set_variable_name(doc_object->current_var, $2);
                                                        eddl_parser_print_var(doc_object->current_var);
                                                        //printf("line var term brackets\n");
                                                        }
                ;

bracket_grp     : BRACKETS var_property END_BRACKETS    {
                                                        //printf("bracket group\n");
                                                        }
                ;

/* variable properties */
var_property    : label_prop                            {eddl_parser_set_variable_label(doc_object->current_var, $1);
                                                        //printf("label prop\n");
                                                        }
                | help_prop                             {eddl_parser_set_variable_help(doc_object->current_var, $1);
                                                        //printf("help prop\n");
                                                        }
                | class_prop                            {eddl_parser_set_variable_class_mask(doc_object->current_var, $1);
                                                        //printf("class prop\n");
                                                        }
                | type_prop def_val_f                   {eddl_parser_set_variable_default_value(doc_object->current_var, &$2);
                                                        //printf("3 type prop\n");
                                                        }
                | type_prop                             {eddl_parser_set_variable_type_mask(doc_object->current_var, $1);
                                                        //printf("type prop\n");
                                                        }
                | hand_prop                             {eddl_parser_set_variable_handling(doc_object->current_var, $1);
                                                        //printf("hand prop\n");
                                                        }
                | var_property label_prop               {eddl_parser_set_variable_label(doc_object->current_var, $2);
                                                        //printf("2 label prop\n");
                                                        }
                | var_property help_prop                {eddl_parser_set_variable_help(doc_object->current_var, $2);
                                                        //printf("2 help prop\n");
                                                        }
                | var_property class_prop               {eddl_parser_set_variable_class_mask(doc_object->current_var, $2);
                                                        //printf("2 class prop\n");
                                                        }
                | var_property type_prop def_val_f      {eddl_parser_set_variable_default_value(doc_object->current_var, &$3);
                                                        //printf("3 type prop\n");
                                                        }
                | var_property type_prop                {eddl_parser_set_variable_type_mask(doc_object->current_var, $2);
                                                        //printf("2 type prop\n");
                                                        }
                | var_property hand_prop                {eddl_parser_set_variable_handling(doc_object->current_var, $2);
                                                        //printf("2 hand prop\n");
                                                        }
                ;

/* default values */

def_val_f       : BRACKETS def_val_line_f END_BRACKETS  {$$ = $1; 
                                                        //printf("var prop def\n");
                                                        }
                ;
/*
def_val_i       : BRACKETS def_val_line_i END_BRACKETS  {printf("var prop def\n");}
                ;

def_val_h       : BRACKETS def_val_line_h END_BRACKETS  {printf("var prop def\n");}
                ;
*/
/* Individual lines */
man_term        : MANUFACTURER WHITESPACE int_term      {$$ = $3; 
                                                        //printf("manufacturer: %d\n", $3);
                                                        }
                ;

dev_t_term      : DEVICE_TYPE WHITESPACE hex_term       {$$ = $3; 
                                                        //printf("device type: %d\n", $3);
                                                        }
                ;

dev_rev_term    : DEVICE_REVISION WHITESPACE int_term   {$$ = $3; 
                                                        //printf("device revision: %d\n", $3);
                                                        }
                ;

dd_rev_term     : DD_REVISION WHITESPACE int_term       {$$ = $3; 
                                                        //printf("DD revision: %d\n", $3);
                                                        }
                ;

var_term        : VARIABLE WHITESPACE str_term          {$$ = $3; 
                                                        eddl_parser_create_variable_t(doc_object);
                                                        //printf("variable: %s\n", $3);
                                                        }
                ;

label_prop      : LABEL WHITESPACE str_term             {$$ = $3; 
                                                        //printf("label: %s\n", $3);
                                                        }
                ;

help_prop       : HELP WHITESPACE str_term              {$$ = $3; 
                                                        //printf("help: %s\n", $3);
                                                        }
                ;

class_prop      : CLASS WHITESPACE str_term             {$$ = eddl_parser_get_class_mask($3); 
                                                        //printf("class: %s\n", $3);
                                                        }
                ;

type_prop       : TYPE WHITESPACE str_term              {$$ = eddl_parser_get_type_mask($3); 
                                                        //printf("type: %s\n", $3);
                                                        }
                ;

hand_prop       : HANDLING WHITESPACE str_term          {$$ = eddl_parser_get_handling_mask($3);
                                                        //printf("Handling: %s\n", $3);
                                                        }
                ;

def_val_line_f  : DEFAULT_VALUE WHITESPACE float_term   {$$ = $3; 
                                                        //printf("def val f\n");
                                                        }
                ;
/*
def_val_line_i  : DEFAULT_VALUE WHITESPACE int_term     {printf("def val i\n");}
                ;

def_val_line_h  : DEFAULT_VALUE WHITESPACE hex_term     {printf("def val h\n");}
                ;
*/
/* Fundemental values */

float_term      : FLOAT                                 {$$ = $1; 
                                                        //printf("float: %f\n", $1);
                                                        }
                ;

int_term        : INTEGER                               {$$ = $1; 
                                                        //printf("integer: %d\n", $1);
                                                        }
                ;

hex_term        : HEX                                   {$$ = $1; 
                                                        //printf("hex: %d\n", $1);
                                                        }
                ;

str_term        : STRING                                {$$ = $1; 
                                                        //printf("string: %s\n", $1);
                                                        }
                ;

%%      /* C code */
#include <stdio.h>
#include <string.h>


void yyerror (char *s) {fprintf (stderr, "%s\n", s);} 
