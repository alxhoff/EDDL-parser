#include <stdlib.h>
#include <stdio.h>

#include "eddl_data_type.h"

int yylex(void);
int yyparse(void);

eddl_object_t* create_eddl_t(void)
{
    eddl_object_t* ret = (eddl_object_t*)calloc(1, sizeof(eddl_object_t));
    if(ret == NULL) return NULL;
    printf("object created\n");

    ret->variable_head = (eddl_variable_t*)calloc(1, sizeof(eddl_variable_t));
    if(ret->variable_head == NULL) return NULL;
    printf("variable created\n");

    return ret;
}

int main (void) 
{
    return yyparse( );
}
