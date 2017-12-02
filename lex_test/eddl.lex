%{
#include "eddl_tokens.h"

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern union YYSTYPE yylval;
%}

%x WHITE WORDS 
%%

"MANUFACTURER"                  {BEGIN(WHITE); 
                                printf("Manufacturer detected\n");
                                return MANUFACTURER;}
"DEVICE_TYPE"                   {BEGIN(WHITE); 
                                printf("Device type detected\n");
                                return DEVICE_TYPE;}
"DEVICE_REVISION"               {BEGIN(WHITE); 
                                printf("Device revision detected\n");
                                return DEVICE_REVISION;}
"DD_REVISION"                   {BEGIN(WHITE); 
                                printf("DD revision detected\n");
                                return DD_REVISION;}
"VARIABLE"                      {BEGIN(WHITE); 
                                printf("Variable detected\n");
                                return VARIABLE;}
"LABEL"                         {BEGIN(WHITE); 
                                printf("Label detected\n");
                                return LABEL;}
"HELP"                          {BEGIN(WHITE); 
                                printf("Help detected\n");
                                return HELP;}
"CLASS"                         {BEGIN(WHITE); 
                                printf("Class detected\n");
                                return CLASS;}
"TYPE"                          {BEGIN(WHITE); 
                                printf("Type detected\n");
                                return TYPE;}
"HANDLING"                      {BEGIN(WHITE); 
                                printf("Handling detected\n");
                                return HANDLING;}
"DEFAULT_VALUE"                 {BEGIN(WHITE); 
                                printf("Default value detected\n");
                                return DEFAULT_VALUE;}
"{"                             {BEGIN(INITIAL); 
                                printf("Bracket detected\n");
                                return BRACKETS;}
"}"                             {BEGIN(INITIAL); 
                                printf("End bracket detected\n");
                                return END_BRACKETS;} 
[ \t]+                          {;}
.                               {;} 

<WHITE>\n                       {BEGIN(INITIAL);}
<WHITE>[ \t]+                   {BEGIN(WORDS); 
                                printf("whitespace\n");
                                return WHITESPACE;}
<WHITE>.                        {;} 
<WORDS>"0x"[0-9]+               {BEGIN(INITIAL); 
                                printf("Hex detected\n");
                                return HEX;}
<WORDS>[0-9]"."[0-9]+          {BEGIN(INITIAL);
                                printf("Float detected\n");
                                return FLOAT;}
<WORDS>[1-9][0-9]*              {BEGIN(INITIAL); 
                                printf("Integer detected\n");
                                return INTEGER;}                 
<WORDS>[a-zA-Z][ .&_a-zA-Z0-9]+ {BEGIN(INITIAL);
                                printf("String detected\n");
                                return STRING;} 
<WORDS>\n                       {BEGIN(INITIAL);}

%%

int yywrap(void)
{
    return 1;
}
