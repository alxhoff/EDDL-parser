%{
#include "eddl_tokens.h"
%}

%x WHITE WORDS 
%%

"MANUFACTURER"                  {BEGIN(WHITE); return MANUFACTURER;}
"DEVICE_TYPE"                   {BEGIN(WHITE); return DEVICE_TYPE;}
"DEVICE_REVISION"               {BEGIN(WHITE); return DEVICE_REVISION;}
"DD_REVISION"                   {BEGIN(WHITE); return DD_REVISION;}
"VARIABLE"                      {BEGIN(WHITE); return VARIABLE;}
"LABEL"                         {BEGIN(WHITE); return LABEL;}
"HELP"                          {BEGIN(WHITE); return HELP;}
"CLASS"                         {BEGIN(WHITE); return CLASS;}
"TYPE"                          {BEGIN(WHITE); return TYPE;}
"HANDLING"                      {BEGIN(WHITE); return HANDLING;}
"DEFAULT_VALUE"                 {BEGIN(WHITE); return DEFAULT_VALUE;}
"{"                             {BEGIN(INITIAL); return BRACKETS;}
"}"                             {BEGIN(INITIAL); return END_BRACKETS;} 
[ \t]+                          {;}
.                               {;} 

<WHITE>\n                       {BEGIN(INITIAL);}
<WHITE>[ \t]+                   {BEGIN(WORDS);}
<WHITE>.                        {;} 
<WORDS>"0x"[0-9]+               {BEGIN(INITIAL); return HEX;}
<WORDS>[0-9]+"."[0-9]+          {BEGIN(INITIAL); return FLOAT;}
<WORDS>[1-9][0-9]*              {BEGIN(INITIAL); return INTEGER;}                 
<WORDS>[a-zA-Z][ .&_a-zA-Z0-9]+ {BEGIN(INITIAL); return IDENTIFIER;} 
<WORDS>\n                       {BEGIN(INITIAL); return OTHER;}

%%

int yywrap(void)
{
    return 1;
}
