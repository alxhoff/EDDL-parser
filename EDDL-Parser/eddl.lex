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
#ifdef PARSER_DEBUG_VERBOSE
                                printf("Manufacturer detected \n");
#endif
                                return MANUFACTURER;}
"DEVICE_TYPE"                   {BEGIN(WHITE); 
#ifdef PARSER_DEBUG_VERBOSE
                                printf("Device type detected\n");
#endif
                                return DEVICE_TYPE;}
"DEVICE_REVISION"               {BEGIN(WHITE); 
#ifdef PARSER_DEBUG_VERBOSE
                                printf("Device revision detected\n");
#endif
                                return DEVICE_REVISION;}
"DD_REVISION"                   {BEGIN(WHITE); 
#ifdef PARSER_DEBUG_VERBOSE
                                printf("DD revision detected\n");
#endif
                                return DD_REVISION;}
"VARIABLE"                      {BEGIN(WHITE); 
#ifdef PARSER_DEBUG_VERBOSE
                                printf("Variable detected\n");
#endif
                                return VARIABLE;}
"LABEL"                         {BEGIN(WHITE); 
#ifdef PARSER_DEBUG_VERBOSE
                                printf("Label detected\n");
#endif
                                return LABEL;}
"HELP"                          {BEGIN(WHITE); 
#ifdef PARSER_DEBUG_VERBOSE
                                printf("Help detected\n");
#endif
                                return HELP;}
"CLASS"                         {BEGIN(WHITE); 
#ifdef PARSER_DEBUG_VERBOSE
                                printf("Class detected\n");
#endif
                                return CLASS;}
"TYPE"                          {BEGIN(WHITE); 
#ifdef PARSER_DEBUG_VERBOSE
                                printf("Type detected\n");
#endif
                                return TYPE;}
"HANDLING"                      {BEGIN(WHITE); 
#ifdef PARSER_DEBUG_VERBOSE
                                printf("Handling detected\n");
#endif
                                return HANDLING;}
"DEFAULT_VALUE"                 {BEGIN(WHITE); 
#ifdef PARSER_DEBUG_VERBOSE
                                printf("Default value detected\n");
#endif
                                return DEFAULT_VALUE;}

"{"                             {BEGIN(INITIAL); 
#ifdef PARSER_DEBUG_VERBOSE
                                printf("Bracket detected\n");
#endif
                                return BRACKETS;}
"}"                             {BEGIN(INITIAL); 
#ifdef PARSER_DEBUG_VERBOSE
                                printf("End bracket detected\n");
#endif
                                return END_BRACKETS;} 
[ \t]+                          {;}
.                               {;} 
[ \t\r\n]                       {;}

<WHITE>\n                       {BEGIN(INITIAL);}
<WHITE>[ \t]+                   {BEGIN(WORDS); 
#ifdef PARSER_DEBUG_VERBOSE
                                printf("whitespace\n");
#endif
                                return WHITESPACE;}
<WHITE>.                        {;} 
<WORDS>"0x"[0-9]+               {BEGIN(INITIAL); 
#ifdef PARSER_DEBUG_VERBOSE
                                printf("Hex detected\n");
#endif
                                yylval.uint_t = strtol(yytext + (2 * sizeof(char)), NULL, 16);
                                return HEX;}
<WORDS>[0-9]"."[0-9]+           {BEGIN(INITIAL);
#ifdef PARSER_DEBUG_VERBOSE
                                printf("Float detected\n");
#endif
                                yylval.double_t = atof(yytext);
#ifdef PARSER_DEBUG_VERBOSE
                                printf("val: %lf\n", yylval.double_t);
#endif
                                return DOUBLE;}
<WORDS>[-][1-9][0-9]*           {BEGIN(INITIAL); 
#ifdef PARSER_DEBUG_VERBOSE
                                printf("neg Integer detected\n");
#endif
                                yylval.int_t = atoi(yytext);
                                return NEG_INTEGER;}                 
<WORDS>[1-9][0-9]*              {BEGIN(INITIAL); 
#ifdef PARSER_DEBUG_VERBOSE
                                printf("Integer detected\n");
#endif
                                yylval.uint_t = atoi(yytext);
                                return INTEGER;}                 
<WORDS>[a-zA-Z][ .&_a-zA-Z0-9]+ {BEGIN(INITIAL);
                                yylval.string_t = strdup(yytext);
#ifdef PARSER_DEBUG_VERBOSE
                                printf("String detected: %s\n", yylval.string_t);
#endif
                                return STRING;} 
<WORDS>\n                       {BEGIN(INITIAL);}

%%

int yywrap(void)
{
    return 1;
}
