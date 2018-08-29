%{
#include <stdio.h>     /* C float_tlarations used in actions */
#include <stdlib.h>
#include <string.h>

#include "eddlparser.h"

extern eddl_object_t* doc_object;
int yylex(void);
void yyerror (char *s);
%}

%union {
        float               float_t; 
        double              double_t;
        char*               string_t;
        int64_t             long_t;
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
%type <uint_t>      def_val_integer  
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
                                                        #ifdef PARSER_DEBUG_VERBOSE
                                                        printf("Manufacturer term prop: %d\n", $1);
                                                        #endif
                                                        }
                | dev_t_term                            {eddl_parser_set_device_type(doc_object, $1);
                                                        #ifdef PARSER_DEBUG_VERBOSE
                                                        printf("Dev term prop: %d\n", $1);
                                                        #endif
                                                        }
                | dev_rev_term                          {eddl_parser_set_device_revision(doc_object, $1);
                                                        #ifdef PARSER_DEBUG_VERBOSE
                                                        printf("Dev rev term prop: %d\n", $1);
                                                        #endif
                                                        }
                | dd_rev_term                           {eddl_parser_set_dd_revision(doc_object, $1);
                                                        #ifdef PARSER_DEBUG_VERBOSE
                                                        printf("DD rev term prop: %d\n", $1);
                                                        #endif
                                                        }
                | line man_term                         {eddl_parser_set_manufacturer(doc_object, $2);
                                                        #ifdef PARSER_DEBUG_VERBOSE
                                                        printf("Line man term prop: %d\n", $2);
                                                        #endif
                                                        }
                | line dev_t_term                       {eddl_parser_set_device_type(doc_object, $2);
                                                        #ifdef PARSER_DEBUG_VERBOSE
                                                        printf("Line dev term prop: %d\n", $2);
                                                        #endif
                                                        }
                | line dev_rev_term                     {eddl_parser_set_device_revision(doc_object, $2);
                                                        #ifdef PARSER_DEBUG_VERBOSE
                                                        printf("Line dev rev term prop: %d\n", $2);
                                                        #endif
                                                        }
                | line dd_rev_term                      {eddl_parser_set_dd_revision(doc_object, $2);
                                                        #ifdef PARSER_DEBUG_VERBOSE
                                                        printf("Line DD rev term: %d\n", $2);
                                                        #endif
                                                        }
                | line var_term bracket_grp             {
                                                        eddl_parser_set_variable_name(doc_object->current_var, $2);
                                                        #ifdef PARSER_DEBUG_VERBOSE
                                                        printf("Line var term bracket group: %s\n", $2);
                                                        #endif
                                                        }
                ;

bracket_grp     : BRACKETS var_property END_BRACKETS    {
                                                        #ifdef PARSER_DEBUG_VERBOSE
                                                        printf("Brackets group\n");
                                                        #endif
                                                        }
                ;

/* variable properties */
var_property    : label_prop                            {eddl_parser_set_variable_label(doc_object->current_var, $1);
                                                        #ifdef PARSER_DEBUG_VERBOSE
                                                        printf("Label prop\n");
                                                        #endif
                                                        }
                | help_prop                             {eddl_parser_set_variable_help(doc_object->current_var, $1);
                                                        #ifdef PARSER_DEBUG_VERBOSE
                                                        printf("Help prop\n");
                                                        #endif
                                                        }
                | class_prop                            {eddl_parser_set_variable_class_mask(doc_object->current_var, $1);
                                                        #ifdef PARSER_DEBUG_VERBOSE
                                                        printf("Class prop\n");
                                                        #endif
                                                        }
                | type_prop def_val_double              {
                                                        if(doc_object->current_var->type == INVAL_TYPE_e)
                                                            eddl_parser_set_variable_type_mask(doc_object->current_var, $1);
                                                        eddl_parser_set_variable_default_value(doc_object->current_var, &$2);
                                                        #ifdef PARSER_DEBUG_VERBOSE
                                                        printf("Type property followed by default val double %lf\n", $2);
                                                        #endif
                                                        }
                | type_prop def_val_integer             {
                                                        if(doc_object->current_var->type == INVAL_TYPE_e)
                                                            eddl_parser_set_variable_type_mask(doc_object->current_var, $1);
                                                        eddl_parser_set_variable_default_value(doc_object->current_var, &$2);
                                                        #ifdef PARSER_DEBUG_VERBOSE
                                                        printf("Type property followed by default val int %d\n", $2);
                                                        #endif
                                                        }
                | type_prop def_val_neg_integer         {
                                                        if(doc_object->current_var->type == INVAL_TYPE_e)
                                                            eddl_parser_set_variable_type_mask(doc_object->current_var, $1);
                                                        eddl_parser_set_variable_default_value(doc_object->current_var, &$2);
                                                        #ifdef PARSER_DEBUG_VERBOSE
                                                        printf("Type property followed by default val neg int %d\n", $2);
                                                        #endif
                                                        }
                | type_prop                             {
                                                        eddl_parser_set_variable_type_mask(doc_object->current_var, $1);
                                                        #ifdef PARSER_DEBUG_VERBOSE
                                                        printf("Type\n");
                                                        #endif
                                                        }
                | hand_prop                             {
                                                        eddl_parser_set_variable_handling(doc_object->current_var, $1);
                                                        #ifdef PARSER_DEBUG_VERBOSE
                                                        printf("Handling\n");
                                                        #endif
                                                        }
                | var_property label_prop               {
                                                        eddl_parser_set_variable_label(doc_object->current_var, $2);
                                                        #ifdef PARSER_DEBUG_VERBOSE
                                                        printf("Variable followed by label\n");
                                                        #endif
                                                        }
                | var_property help_prop                {
                                                        eddl_parser_set_variable_help(doc_object->current_var, $2);
                                                        #ifdef PARSER_DEBUG_VERBOSE
                                                        printf("Variable followed by help\n");
                                                        #endif
                                                        }
                | var_property class_prop               {
                                                        eddl_parser_set_variable_class_mask(doc_object->current_var, $2);
                                                        #ifdef PARSER_DEBUG_VERBOSE
                                                        printf("Variable followed by class\n");
                                                        #endif
                                                        }
                | var_property type_prop def_val_double {
                                                        if(doc_object->current_var->type == INVAL_TYPE_e)
                                                            eddl_parser_set_variable_type_mask(doc_object->current_var, $2);
                                                        eddl_parser_set_variable_default_value(doc_object->current_var, &$3);
                                                        #ifdef PARSER_DEBUG_VERBOSE
                                                        printf("Variable followed by type double: %lf\n", $3);
                                                        #endif
                                                        }
                | var_property type_prop def_val_integer{
                                                        if(doc_object->current_var->type == INVAL_TYPE_e)
                                                            eddl_parser_set_variable_type_mask(doc_object->current_var, $2);
                                                        eddl_parser_set_variable_default_value(doc_object->current_var, &$3);
                                                        #ifdef PARSER_DEBUG_VERBOSE
                                                        printf("Variable followed by type neg int: %d\n", $3);
                                                        #endif
                                                        }
                | var_property type_prop def_val_neg_integer{
                                                        if(doc_object->current_var->type == INVAL_TYPE_e)
                                                            eddl_parser_set_variable_type_mask(doc_object->current_var, $2);
                                                        eddl_parser_set_variable_default_value(doc_object->current_var, &$3);
                                                        #ifdef PARSER_DEBUG_VERBOSE
                                                        printf("Variable followed by type neg int: %d\n", $3);
                                                        #endif
                                                        }
                | var_property type_prop                {eddl_parser_set_variable_type_mask(doc_object->current_var, $2);
                                                        #ifdef PARSER_DEBUG_VERBOSE
                                                        printf("Variable followed by type\n");
                                                        #endif
                                                        }
                | var_property hand_prop                {eddl_parser_set_variable_handling(doc_object->current_var, $2);
                                                        #ifdef PARSER_DEBUG_VERBOSE
                                                        printf("Variable followed by handling\n");
                                                        #endif
                                                        }
                ;

/* default values */

/*process default*/


def_val_double   : BRACKETS def_val_line_double END_BRACKETS    {
                                                                $$ = $2; 
                                                                #ifdef PARSER_DEBUG_VERBOSE
                                                                printf("Brackets def val line double: %f\n", $2);
                                                                #endif
                                                                }
                ;

def_val_integer : BRACKETS def_val_line_integer END_BRACKETS    {
                                                                $$ = $2;
                                                                #ifdef PARSER_DEBUG_VERBOSE
                                                                printf("Brackets def val line int: %d\n", $2);
                                                                #endif
                                                                }
                ;

def_val_neg_integer : BRACKETS def_val_line_neg_integer END_BRACKETS    {
                                                                        $$ = $2;
                                                                        #ifdef PARSER_DEBUG_VERBOSE
                                                                        printf("Brackets def val line neg int: %d\n", $2);
                                                                        #endif
                                                                        }
                ;

/* Individual lines */
man_term        : MANUFACTURER WHITESPACE uint_term     {
                                                        $$ = $3; 
                                                        #ifdef PARSER_DEBUG_VERBOSE
                                                        printf("Manufacturer with Uint term: %d\n", $3);
                                                        #endif
                                                        }
                ;

dev_t_term      : DEVICE_TYPE WHITESPACE hex_term       {
                                                        $$ = $3; 
                                                        #ifdef PARSER_DEBUG_VERBOSE
                                                        printf("Device type with hex term: %d\n", $3);
                                                        #endif
                                                        }
                ;

dev_rev_term    : DEVICE_REVISION WHITESPACE uint_term  {
                                                        $$ = $3; 
                                                        #ifdef PARSER_DEBUG_VERBOSE
                                                        printf("Device revision with Uint term: %d\n", $3);
                                                        #endif
                                                        }
                ;

dd_rev_term     : DD_REVISION WHITESPACE uint_term      {
                                                        $$ = $3; 
                                                        #ifdef PARSER_DEBUG_VERBOSE
                                                        printf("DD revision with Uint term: %d\n", $3);
                                                        #endif
                                                        }
                ;

var_term        : VARIABLE WHITESPACE str_term          {
                                                        $$ = $3; 
                                                        eddl_parser_create_variable_t(doc_object);
                                                        #ifdef PARSER_DEBUG_VERBOSE
                                                        printf("Variable with string term: %s\n", $3);
                                                        #endif
                                                        }
                ;

label_prop      : LABEL WHITESPACE str_term             {
                                                        $$ = $3; 
                                                        #ifdef PARSER_DEBUG_VERBOSE
                                                        printf("Label with string term: %s\n", $3);
                                                        #endif
                                                        }
                ;

help_prop       : HELP WHITESPACE str_term              {
                                                        $$ = $3; 
                                                        #ifdef PARSER_DEBUG_VERBOSE
                                                        printf("Help with string term: %s\n", $3);
                                                        #endif
                                                        }
                ;

class_prop      : CLASS WHITESPACE str_term             {
                                                        $$ = eddl_parser_get_class_mask($3); 
                                                        #ifdef PARSER_DEBUG_VERBOSE
                                                        printf("Class with string term: %s\n", $3);
                                                        #endif
                                                        }
                ;

type_prop       : TYPE WHITESPACE str_term              {
                                                        $$ = eddl_parser_get_type_mask($3); 
                                                        #ifdef PARSER_DEBUG_VERBOSE
                                                        printf("Type with string term: %s\n", $3);
                                                        #endif
                                                        }
                ;

hand_prop       : HANDLING WHITESPACE str_term          {
                                                        $$ = eddl_parser_get_handling_mask($3);
                                                        #ifdef PARSER_DEBUG_VERBOSE
                                                        printf("Handling with string term: %s\n", $3);
                                                        #endif
                                                        }
                ;

def_val_line_double     : DEFAULT_VALUE WHITESPACE double_term  {
                                                                $$ = $3; 
                                                                #ifdef PARSER_DEBUG_VERBOSE
                                                                printf("Default value double term %lf\n", $3);
                                                                #endif
                                                                }
                        ;

def_val_line_integer    : DEFAULT_VALUE WHITESPACE uint_term    {
                                                                $$ = $3;
                                                                #ifdef PARSER_DEBUG_VERBOSE
                                                                printf("Default value Uint term: %d\n", $3);
                                                                #endif
                                                                }
                        | DEFAULT_VALUE WHITESPACE hex_term     {
                                                                $$ = $3;
                                                                #ifdef PARSER_DEBUG_VERBOSE
                                                                printf("Default value hex term: %d\n", $3);
                                                                #endif
                                                                }
                        ;

def_val_line_neg_integer: DEFAULT_VALUE WHITESPACE int_term     {
                                                                $$ = $3;
                                                                #ifdef PARSER_DEBUG_VERBOSE
                                                                printf("Default value int term: %d\n", $3);
                                                                #endif
                                                                }
                        ;

/* Fundemental values */



double_term     : DOUBLE                                {
                                                        $$ = $1; 
                                                        #ifdef PARSER_DEBUG_VERBOSE
                                                            printf("Double term: %lf\n", $$);
                                                        #endif
                                                        }
                ;

int_term        : NEG_INTEGER                           {
                                                        $$ = $1; 
                                                        #ifdef PARSER_DEBUG_VERBOSE
                                                            printf("Integer term: %d\n", $1);
                                                        #endif
                                                        }
                ;
uint_term       : INTEGER                               {
                                                        $$ = $1; 
                                                        #ifdef PARSER_DEBUG_VERBOSE
                                                            printf("Integer term: %d\n", $1);
                                                        #endif
                                                        }
                ;

hex_term        : HEX                                   {
                                                        $$ = $1; 
                                                        #ifdef PARSER_DEBUG_VERBOSE
                                                            printf("Hex term: %d\n", $1);
                                                        #endif
                                                        }
                ;

str_term        : STRING                                {
                                                        $$ = $1; 
                                                        #ifdef PARSER_DEBUG_VERBOSE
                                                            printf("String term: %s\n", $1);
                                                        #endif
                                                        }
                ;

%%      /* C code */
#include <stdio.h>
#include <string.h>


void yyerror (char *s) {fprintf (stderr, "%s\n", s);} 
