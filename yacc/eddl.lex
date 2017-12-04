%{
#include "eddl_data_type.h"
#include "y.tab.h"

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern union YYSTYPE yylval;
%}

%x WHITE WORDS 
%%

"MANUFACTURER"                  {BEGIN(WHITE); 
                                printf("Manufacturer detected \n");
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
                                printf("Bracket detected\n");
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
                                yylval.num = strtol(yytext + (2 * sizeof(char)), NULL, 16);
                                printf("Hex conversion: %d\n", yylval.num);
                                return HEX;}
<WORDS>[0-9]"."[0-9]+          {BEGIN(INITIAL);
                                printf("Float detected\n");
                                yylval.dec = atof(yytext);
                                return FLOAT;}
<WORDS>[1-9][0-9]*              {BEGIN(INITIAL); 
                                printf("Integer detected\n");
                                yylval.num = atoi(yytext);
                                return INTEGER;}                 
<WORDS>[a-zA-Z][ .&_a-zA-Z0-9]+ {BEGIN(INITIAL);
                                yylval.str = strdup(yytext);
                                printf("String detected: %s\n", yylval.str);
                                return STRING;} 
<WORDS>\n                       {BEGIN(INITIAL);}

%%

int yywrap(void)
{
    return 1;
}
