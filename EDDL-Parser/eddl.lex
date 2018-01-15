%{
#include "eddl_data_type.h"
#define MACROS_DONE
#include "y.tab.h"

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define YYDEBUG     1

extern union YYSTYPE yylval;
int yydebug=1;
%}

%x WHITE WORDS 
%%

"MANUFACTURER"                  {BEGIN(WHITE); 
                                //printf("Manufacturer detected \n");
                                return MANUFACTURER;}
"DEVICE_TYPE"                   {BEGIN(WHITE); 
                                //printf("Device type detected\n");
                                return DEVICE_TYPE;}
"DEVICE_REVISION"               {BEGIN(WHITE); 
                                //printf("Device revision detected\n");
                                return DEVICE_REVISION;}
"DD_REVISION"                   {BEGIN(WHITE); 
                                //printf("DD revision detected\n");
                                return DD_REVISION;}
"VARIABLE"                      {BEGIN(WHITE); 
                                //printf("Variable detected\n");
                                return VARIABLE;}
"LABEL"                         {BEGIN(WHITE); 
                                //printf("Label detected\n");
                                return LABEL;}
"HELP"                          {BEGIN(WHITE); 
                                //printf("Help detected\n");
                                return HELP;}
"CLASS"                         {BEGIN(WHITE); 
                                //printf("Class detected\n");
                                return CLASS;}
"TYPE"                          {BEGIN(WHITE); 
                                //printf("Type detected\n");
                                return TYPE;}
"HANDLING"                      {BEGIN(WHITE); 
                                //printf("Handling detected\n");
                                return HANDLING;}
"DEFAULT_VALUE"                 {BEGIN(WHITE); 
                                //printf("Default value detected\n");
                                return DEFAULT_VALUE;}

"{"                             {BEGIN(INITIAL); 
                                //printf("Bracket detected\n");
                                return BRACKETS;}
"}"                             {BEGIN(INITIAL); 
                                //printf("End bracket detected\n");
                                return END_BRACKETS;} 
[ \t]+                          {;}
.                               {;} 

<WHITE>\n                       {BEGIN(INITIAL);}
<WHITE>[ \t]+                   {BEGIN(WORDS); 
                                //printf("whitespace\n");
                                return WHITESPACE;}
<WHITE>.                        {;} 
<WORDS>"0x"[0-9]+               {BEGIN(INITIAL); 
                                //printf("Hex detected\n");
                                yylval.uint_t = strtol(yytext + (2 * sizeof(char)), NULL, 16);
                                //printf("Hex conversion of \"%s\" to decimal: %d\n", yytext+(2*sizeof(char)), yylval.int_t);
                                return HEX;}
<WORDS>[0-9]"."[0-9]+           {BEGIN(INITIAL);
                                printf("Float detected\n");
                                yylval.double_t = atof(yytext);
                                printf("val: %lf\n", yylval.double_t);
                                return DOUBLE;}
<WORDS>[1-9][0-9]*              {BEGIN(INITIAL); 
                                //printf("Integer detected\n");
                                yylval.int_t = atoi(yytext);
                                return INTEGER;}                 
<WORDS>[a-zA-Z][ .&_a-zA-Z0-9]+ {BEGIN(INITIAL);
                                yylval.string_t = strdup(yytext);
                                //printf("String detected: %s\n", yylval.string_t);
                                return STRING;} 
<WORDS>\n                       {BEGIN(INITIAL);}

%%

int yywrap(void)
{
    return 1;
}
