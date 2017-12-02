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
                                strcpy(yylval.str, yytext);
                                printf("Manufacturer detected: %s : %s \n", yylval.str, yytext);
                                return MANUFACTURER;}
"DEVICE_TYPE"                   {BEGIN(WHITE); 
                                printf("Device type detected\n");
                                strcpy(yylval.str, yytext);
                                return DEVICE_TYPE;}
"DEVICE_REVISION"               {BEGIN(WHITE); 
                                printf("Device revision detected\n");
                                strcpy(yylval.str, yytext);
                                return DEVICE_REVISION;}
"DD_REVISION"                   {BEGIN(WHITE); 
                                printf("DD revision detected\n");
                                strcpy(yylval.str, yytext);
                                return DD_REVISION;}
"VARIABLE"                      {BEGIN(WHITE); 
                                printf("Variable detected\n");
                                strcpy(yylval.str, yytext);
                                return VARIABLE;}
"LABEL"                         {BEGIN(WHITE); 
                                printf("Label detected\n");
                                strcpy(yylval.str, yytext);
                                return LABEL;}
"HELP"                          {BEGIN(WHITE); 
                                printf("Help detected\n");
                                strcpy(yylval.str, yytext);
                                return HELP;}
"CLASS"                         {BEGIN(WHITE); 
                                printf("Class detected\n");
                                strcpy(yylval.str, yytext);
                                return CLASS;}
"TYPE"                          {BEGIN(WHITE); 
                                printf("Type detected\n");
                                strcpy(yylval.str, yytext);
                                return TYPE;}
"HANDLING"                      {BEGIN(WHITE); 
                                printf("Handling detected\n");
                                strcpy(yylval.str, yytext);
                                return HANDLING;}
"DEFAULT_VALUE"                 {BEGIN(WHITE); 
                                printf("Default value detected\n");
                                strcpy(yylval.str, yytext);
                                return DEFAULT_VALUE;}

"{"                             {BEGIN(INITIAL); return BRACKETS;}
"}"                             {BEGIN(INITIAL); return END_BRACKETS;} 
[ \t]+                          {;}
.                               {;} 

<WHITE>\n                       {BEGIN(INITIAL);}
<WHITE>[ \t]+                   {BEGIN(WORDS); return WHITESPACE;}
<WHITE>.                        {;} 
<WORDS>"0x"[0-9]+               {BEGIN(INITIAL); 
                                printf("Hex detected\n");
                                yylval.num = atoi(yytext + (2 * sizeof(char))); 
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
                                printf("String detected\n");
                                strcpy(yylval.str, yytext);
                                return STRING;} 
<WORDS>\n                       {BEGIN(INITIAL);}

%%

int yywrap(void)
{
    return 1;
}
