%{
#include <stdio.h>     /* C float_tlarations used in actions */
#include <stdlib.h>
#include <string.h>

#include "eddl_data_type.h"
#include "eddlparser.h"

extern eddl_object_t* doc_object;
int yylex(void);
void yyerror (char *s);
%}

%union {
        float               float_t; 
        double              double_t;
        char*               string_t;
        unsigned int        uint_t;
        int                 int_t; 
        eddl_variable_t*    var;
        class_mask_t        class;
        type_mask_t         type;
        handling_mask_t     hand;
        }

/*%start line*/
%token <int_t>      WHITESPACE
%token <int_t>      BRACKETS
%token <int_t>      END_BRACKETS
%token <string_t>   MANUFACTURER
%token <string_t>   DEVICE_TYPE
%token <string_t>   DEVICE_REVISION
%token <string_t>   DD_REVISION
%token <string_t>   VARIABLE
%token <string_t>   LABEL
%token <string_t>   HELP
%token <string_t>   CLASS
%token <string_t>   TYPE
%token <string_t>   HANDLING
%token <string_t>   DEFAULT_VALUE
%token <string_t>   STRING  
%token <int_t>      NEG_INTEGER
%token <uint_t>     INTEGER
%token <uint_t>     HEX
%token <double_t>   DOUBLE

%type <int_t>       line 
%type <int_t>       man_term dev_t_term dev_rev_term dd_rev_term 
%type <string_t>    var_term label_prop help_prop 
%type <class>       class_prop 
%type <type>        type_prop 
%type <hand>        hand_prop
%type <double_t>    def_val_double 
%type <int_t>       def_val_integer  
%type <int_t>       def_val_neg_integer  
%type <double_t>    def_val_line_double 
%type <uint_t>      def_val_line_integer
%type <int_t>       def_val_line_neg_integer
/*%type <float_t>     float_term*/
%type <double_t>    double_term
%type <int_t>       int_term
%type <uint_t>      uint_term
%type <uint_t>      hex_term
%type <string_t>    str_term

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
                                                        //eddl_parser_print_var(doc_object->current_var);
                                                        printf("line var term brackets: %s\n", $2);
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
                | type_prop def_val_double              {
                                                        if(doc_object->current_var->type == INVAL_TYPE_e)
                                                            eddl_parser_set_variable_type_mask(doc_object->current_var, $1);
                                                        eddl_parser_set_variable_default_value(doc_object->current_var, &$2);
                                                        printf("def val %f\n", $2);
                                                        //printf("3 type prop\n");
                                                        }
                | type_prop def_val_integer             {
                                                        if(doc_object->current_var->type == INVAL_TYPE_e)
                                                            eddl_parser_set_variable_type_mask(doc_object->current_var, $1);
                                                        eddl_parser_set_variable_default_value(doc_object->current_var, &$2);
                                                        printf("def val %d\n", $2);
                                                        //printf("3 type prop\n");
                                                        }
                | type_prop def_val_neg_integer             {
                                                        if(doc_object->current_var->type == INVAL_TYPE_e)
                                                            eddl_parser_set_variable_type_mask(doc_object->current_var, $1);
                                                        eddl_parser_set_variable_default_value(doc_object->current_var, &$2);
                                                        printf("def val %d\n", $2);
                                                        //printf("3 type prop\n");
                                                        }
                | type_prop                             {
                                                        eddl_parser_set_variable_type_mask(doc_object->current_var, $1);
                                                        //printf("type prop\n");
                                                        }
                | hand_prop                             {
                                                        eddl_parser_set_variable_handling(doc_object->current_var, $1);
                                                        //printf("hand prop\n");
                                                        }
                | var_property label_prop               {
                                                        eddl_parser_set_variable_label(doc_object->current_var, $2);
                                                        //printf("2 label prop\n");
                                                        }
                | var_property help_prop                {
                                                        eddl_parser_set_variable_help(doc_object->current_var, $2);
                                                        //printf("2 help prop\n");
                                                        }
                | var_property class_prop               {
                                                        eddl_parser_set_variable_class_mask(doc_object->current_var, $2);
                                                        //printf("2 class prop\n");
                                                        }
                | var_property type_prop def_val_double {
                                                        if(doc_object->current_var->type == INVAL_TYPE_e)
                                                            eddl_parser_set_variable_type_mask(doc_object->current_var, $2);
                                                        eddl_parser_set_variable_default_value(doc_object->current_var, &$3);
                                                        printf("def val %f\n", $3);
                                                        }
                | var_property type_prop def_val_integer{
                                                        if(doc_object->current_var->type == INVAL_TYPE_e)
                                                            eddl_parser_set_variable_type_mask(doc_object->current_var, $2);
                                                        eddl_parser_set_variable_default_value(doc_object->current_var, &$3);
                                                        printf("def val %d\n", $3);
                                                        }
                | var_property type_prop def_val_neg_integer{
                                                        if(doc_object->current_var->type == INVAL_TYPE_e)
                                                            eddl_parser_set_variable_type_mask(doc_object->current_var, $2);
                                                        eddl_parser_set_variable_default_value(doc_object->current_var, &$3);
                                                        printf("def val %d\n", $3);
                                                        }
                | var_property type_prop                {eddl_parser_set_variable_type_mask(doc_object->current_var, $2);
                                                        //printf("2 type prop\n");
                                                        }
                | var_property hand_prop                {eddl_parser_set_variable_handling(doc_object->current_var, $2);
                                                        //printf("2 hand prop\n");
                                                        }
                ;

/* default values */

/*process default*/


def_val_double   : BRACKETS def_val_line_double END_BRACKETS    {
                                                                $$ = $2; 
                                                                printf("var prop def %f\n", $$);
                                                                }
                ;

def_val_integer : BRACKETS def_val_line_integer END_BRACKETS    {
                                                                $$  = $2;
                                                                }
                ;

def_val_neg_integer : BRACKETS def_val_line_neg_integer END_BRACKETS    {
                                                                        $$  = $2;
                                                                        }
                ;

/* Individual lines */
man_term        : MANUFACTURER WHITESPACE uint_term     {
                                                        $$ = $3; 
                                                        //printf("manufacturer: %d\n", $3);
                                                        }
                ;

dev_t_term      : DEVICE_TYPE WHITESPACE hex_term       {
                                                        $$ = $3; 
                                                        //printf("device type: %d\n", $3);
                                                        }
                ;

dev_rev_term    : DEVICE_REVISION WHITESPACE uint_term  {
                                                        $$ = $3; 
                                                        //printf("device revision: %d\n", $3);
                                                        }
                ;

dd_rev_term     : DD_REVISION WHITESPACE uint_term      {
                                                        $$ = $3; 
                                                        //printf("DD revision: %d\n", $3);
                                                        }
                ;

var_term        : VARIABLE WHITESPACE str_term          {
                                                        $$ = $3; 
                                                        eddl_parser_create_variable_t(doc_object);
                                                        printf("variable: %s\n", $3);
                                                        }
                ;

label_prop      : LABEL WHITESPACE str_term             {
                                                        $$ = $3; 
                                                        //printf("label: %s\n", $3);
                                                        }
                ;

help_prop       : HELP WHITESPACE str_term              {
                                                        $$ = $3; 
                                                        //printf("help: %s\n", $3);
                                                        }
                ;

class_prop      : CLASS WHITESPACE str_term             {
                                                        $$ = eddl_parser_get_class_mask($3); 
                                                        //printf("class: %s\n", $3);
                                                        }
                ;

type_prop       : TYPE WHITESPACE str_term              {
                                                        $$ = eddl_parser_get_type_mask($3); 
                                                        //printf("type: %s\n", $3);
                                                        }
                ;

hand_prop       : HANDLING WHITESPACE str_term          {
                                                        $$ = eddl_parser_get_handling_mask($3);
                                                        //printf("Handling: %s\n", $3);
                                                        }
                ;

def_val_line_double     : DEFAULT_VALUE WHITESPACE double_term  {
                                                                $$ = $3; 
                                                                printf("def val f %f\n", $3);
                                                                }
                        ;

def_val_line_integer    : DEFAULT_VALUE WHITESPACE uint_term    {
                                                                $$ = $3;
                                                                printf("def val i\n");
                                                                }
                        | DEFAULT_VALUE WHITESPACE hex_term     {
                                                                $$ = $3;
                                                                printf("def val h\n");
                                                                }
                        ;

def_val_line_neg_integer: DEFAULT_VALUE WHITESPACE int_term     {
                                                                $$ = $3;
                                                                printf("def val i\n");
                                                                }
                        ;

/* Fundemental values */



double_term     : DOUBLE                                {
                                                        $$ = $1; 
                                                        printf("double: %lf\n", $$);
                                                        }
                ;

int_term        : NEG_INTEGER                           {
                                                        $$ = $1; 
                                                        printf("integer: %d\n", $1);
                                                        }
                ;
uint_term       : INTEGER                               {
                                                        $$ = $1; 
                                                        //printf("integer: %d\n", $1);
                                                        }
                ;

hex_term        : HEX                                   {
                                                        $$ = $1; 
                                                        //printf("hex: %d\n", $1);
                                                        }
                ;

str_term        : STRING                                {
                                                        $$ = $1; 
                                                        //printf("string: %s\n", $1);
                                                        }
                ;

%%      /* C code */
#include <stdio.h>
#include <string.h>


void yyerror (char *s) {fprintf (stderr, "%s\n", s);} 
