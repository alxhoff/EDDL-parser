#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#include "eddl_data_type.h"

eddl_object_t* doc_object;

int yylex(void);
int yyparse(void);

eddl_object_t* eddl_parser_create_eddl_t(void)
{
    eddl_object_t* ret = (eddl_object_t*)calloc(1, sizeof(eddl_object_t));
    if(ret == NULL) return NULL;
    printf("object created\n");
    return ret;
}

EDDL_PARSE_ERR_t eddl_parser_create_variable_t(eddl_object_t* object)
{
    object->variable_head = (eddl_variable_t*)calloc(1, sizeof(eddl_variable_t));
    if(object->variable_head == NULL) return EDDL_PARSE_MEM;
    printf("variable created\n");
    return EDDL_PARSE_OK;
}

//SET
EDDL_PARSE_ERR_t eddl_parser_set_manufacturer(eddl_object_t* object,
        int val)
{
    object->manufacturer = val; 
    return EDDL_PARSE_OK;
}

EDDL_PARSE_ERR_t eddl_parser_set_device_type(eddl_object_t* object,
        long val)
{
    object->device_type = val;
    return EDDL_PARSE_OK;
}

EDDL_PARSE_ERR_t eddl_parser_set_device_revision(eddl_object_t* object,
        int val)
{
    object->device_revision = val;
    return EDDL_PARSE_OK;
}

EDDL_PARSE_ERR_t eddl_parser_set_dd_revision(eddl_object_t* object,
        int val)
{
    object->dd_revision = val;
    return EDDL_PARSE_OK;
}

EDDL_PARSE_ERR_t eddl_parser_set_variable_name(eddl_variable_t* var,
        char* name)
{
    var->__name = name;
    return EDDL_PARSE_OK;
}

EDDL_PARSE_ERR_t eddl_parser_set_variable_label(eddl_variable_t* var,
        char* label)
{
    var->__label = label;
    return EDDL_PARSE_OK;
}

EDDL_PARSE_ERR_t eddl_parser_set_variable_help(eddl_variable_t* var,
        char* help)
{
    var->__help = help;
    return EDDL_PARSE_OK;
}

EDDL_PARSE_ERR_t eddl_parser_set_variable_class_mask(
        eddl_variable_t* var, class_mask_t mask)
{
    var->__class = mask;
    return EDDL_PARSE_OK;
}

EDDL_PARSE_ERR_t eddl_parser_set_variable_type_mask(
        eddl_variable_t* var, type_mask_t mask)
{
    var->__type = mask;
    return EDDL_PARSE_OK;
}

EDDL_PARSE_ERR_t eddl_parser_set_variable_default_value(
        eddl_variable_t* var, void* value)
{
    if(var->__type == 0) return EDDL_PARSE_INVAL;
    switch(var->__type){
        case FLOAT_e:{
            var->__default_value = (float*)malloc(sizeof(float));
            float tmp = *((float*)value);
            memcpy(var->__default_value, &tmp, sizeof(float));
            }
            break;
        case INTEGER_e:{
            var->__default_value = (int*)malloc(sizeof(int));
            int tmp = *((int*)value);
            memcpy(var->__default_value, &tmp, sizeof(int));
            }
            break; 
        default:
            break;
    }
    return EDDL_PARSE_OK;
}

EDDL_PARSE_ERR_t eddl_parser_set_handling(eddl_variable_t* var,
        handling_mask_t val)
{
    var->__handling = val;
    return EDDL_PARSE_OK;
}

int main (void) 
{
    doc_object = eddl_parser_create_eddl_t();
    
    return yyparse( );
}
