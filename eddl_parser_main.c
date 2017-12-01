#include <stdio.h>
#include "eddl_tokens.h"

extern int yylex();
extern int yylineno;
extern char* yytext;

char *eddl_tags[] = {
    NULL,
    "STRING",
    "INTEGER",
    "HEX",
    "FLOAT",
    "WHITESPACE",
    "BRACKETS",
    "END_BRACKETS",
    "MANUFACTURER",
    "DEVICE_TYPE",
    "DEVICE_REVISION",
    "DD_REVISION",
    "VARIABLE",
    "LABEL",
    "HELP",
    "CLASS",
    "TYPE",
    "HANDLING",
    "DEFAULT_VALUE",
    "OTHER",
};

void get_identifier(void){
    int tmp = 0;
    while(!(tmp == STRING || tmp == INTEGER || tmp == HEX || tmp == FLOAT)) 
        tmp = yylex();
    printf("%s found with value: %s\n", eddl_tags[tmp], yytext);
    return;
}

int main(int argc, char **argv)
{
    int name_token, value_token;
    int nested_couint = 0;
    int tmp;
    name_token =  yylex();
    while(name_token){
        printf("Token : %s with contents: %s\n", 
                eddl_tags[name_token], yytext);
         
        switch(name_token){
        case MANUFACTURER:
            get_identifier();
            printf("Manufacturer: %s\n", yytext);
            break;
        case DEVICE_TYPE:
            get_identifier();
            printf("Device type: %s\n", yytext);
            break;
        case DEVICE_REVISION:
            get_identifier();
            printf("Device revision: %s\n", yytext);
            break;
        case DD_REVISION:
            get_identifier();
            printf("DD revision: %s\n", yytext);
            break;
        case VARIABLE:
            get_identifier();
            printf("Variable name: %s\n", yytext);
            break;
        case LABEL:
            get_identifier();
            printf("Label: %s\n", yytext);
            break;
        case HELP:
            get_identifier();
            printf("Help: %s\n", yytext);
            break;
        case CLASS:
            get_identifier();
            printf("Class: %s\n", yytext);
            break;
        case TYPE:
            get_identifier();
            printf("Type: %s\n", yytext);
            break;
        case HANDLING:
            get_identifier();
            printf("Handling: %s\n", yytext);
            break;
        case DEFAULT_VALUE:
            get_identifier();
            printf("Default value: %s\n", yytext);
            break;
        default:
            break;
        }
        
        name_token = yylex();
    }
    return 0;
}
