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
    return ret;
}

int main (void) 
{
    return yyparse( );
}
