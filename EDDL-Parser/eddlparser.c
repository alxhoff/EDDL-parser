#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#include "eddl_data_type.h"

eddl_object_t* doc_object;

int yylex(void);
int yyparse(void);

const char* edd_type_strings[] = {TYPE_MASKS(TYPE_STRING)};
const char* edd_handling_strings[] = {HANDLING_MASKS(HANDLING_STRING)};


//LL
eddl_variable_t* eddl_parser_get_last_ll_var(eddl_object_t* object)
{
    if(object->variable_head == NULL) return NULL;
    eddl_variable_t* var_head = object->variable_head;
    while(var_head->next != NULL) var_head = var_head->next;
    return var_head;
}

//CREATION
eddl_object_t* eddl_parser_create_eddl_t(void)
{
    eddl_object_t* ret = (eddl_object_t*)calloc(1, sizeof(eddl_object_t));
    if(ret == NULL) return NULL;
    printf("object created\n");
    return ret;
}

EDDL_PARSE_ERR_t eddl_parser_create_variable_t(eddl_object_t* object)
{
    eddl_variable_t* ret = (eddl_variable_t*)calloc(1, sizeof(eddl_variable_t));
    if(ret == NULL) return EDDL_PARSE_MEM;
    
    if(object->variable_head == NULL){
        object->variable_head = ret;
        object->current_var = ret;
        printf("head variable created\n");
        return EDDL_PARSE_OK;
    }else{
        //TODO can this line be removed VVVV
        eddl_variable_t* tail_var = eddl_parser_get_last_ll_var(object);
        tail_var->next = ret;
        printf("tail variable created\n");
    }

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
    var->name = name;
    return EDDL_PARSE_OK;
}

EDDL_PARSE_ERR_t eddl_parser_set_variable_label(eddl_variable_t* var,
        char* label)
{
    var->label = label;
    return EDDL_PARSE_OK;
}

EDDL_PARSE_ERR_t eddl_parser_set_variable_help(eddl_variable_t* var,
        char* help)
{
    var->help = help;
    return EDDL_PARSE_OK;
}

EDDL_PARSE_ERR_t eddl_parser_set_variable_class_mask(
        eddl_variable_t* var, class_mask_t mask)
{
    var->_class = mask;
    return EDDL_PARSE_OK;
}

EDDL_PARSE_ERR_t eddl_parser_set_variable_type_mask(
        eddl_variable_t* var, type_mask_t mask)
{
    var->type = mask;
    return EDDL_PARSE_OK;
}

EDDL_PARSE_ERR_t eddl_parser_set_variable_default_value(
        eddl_variable_t* var, void* value)
{
    if(var->type == INVAL_TYPE_e) return EDDL_PARSE_INVAL;
    switch(var->type){
        case FLOAT_TYPE_e:{
            var->default_value = (float*)malloc(sizeof(float));
            float tmp = *((float*)value);
            memcpy(var->default_value, &tmp, sizeof(float));
            }
            break;
        case INTEGER_TYPE_e:{
            var->default_value = (int*)malloc(sizeof(int));
            int tmp = *((int*)value);
            memcpy(var->default_value, &tmp, sizeof(int));
            }
            break; 
        default:
            break;
    }
    return EDDL_PARSE_OK;
}

EDDL_PARSE_ERR_t eddl_parser_set_variable_handling(eddl_variable_t* var,
        handling_mask_t val)
{
    var->handling = val;
    return EDDL_PARSE_OK;
}

//compare
char* remove_spaces(char* input)
{
    int i,j;
    char *output=input;
    for (i = 0, j = 0; i<(int)strlen(input); i++,j++){
        if (input[i]!=' ')    
            output[j]=input[i];    
        else
            j--;    
    }   
    output[j]=0;
    return output;
}

class_mask_t eddl_parser_get_class_mask(char* class_string)
{
    class_mask_t ret = INVAL_CLASS_e;

    char* tmp;
    tmp = strtok(remove_spaces(class_string), "&");
    while(tmp != NULL){
        printf("class string: %s\n", tmp);
        if(!strcmp(tmp, "CONTAINED")) ret |= CONTAINED_CLASS_e;
        if(!strcmp(tmp, "DYNAMIC")) ret |= DYNAMIC_CLASS_e;
        tmp = strtok(NULL, "&");
    }

    printf("Getting class mask: 0x%x\n", ret);

    return ret;
}

type_mask_t eddl_parser_get_type_mask(char* type_string)
{
    type_mask_t ret = INVAL_TYPE_e;

    if(!strcmp(type_string, "FLOAT")) return FLOAT_TYPE_e;
    if(!strcmp(type_string, "INTEGER")) return INTEGER_TYPE_e;
        
    return ret;
}

handling_mask_t eddl_parser_get_handling_mask(char* handling_string)
{
    handling_mask_t ret = INVAL_HANDLING_e;
    char* tmp;

    tmp = strtok(remove_spaces(handling_string), "&");
    while(tmp != NULL){
        printf("handle string: %s\n", tmp);
        if(!strcmp(tmp, "READ")) ret |= READ_HANDLING_e;
        if(!strcmp(tmp, "READ_WRITE")) ret |= READ_WRITE_HANDLING_e;
        if(!strcmp(tmp, "WRITE")) ret |= WRITE_HANDLING_e;
        tmp = strtok(NULL, "&");
    }

    printf("Getting handle mask: 0x%x\n", ret);

    return ret;
}

//check

EDDL_PARSE_ERR_t eddl_parser_print_doc(eddl_object_t* doc)
{
    //doc properties
    printf("!!=======EDDL DOC PROPERTIES=======!!\n");
    printf("  Manufacturer: %d\n", doc->manufacturer);
    printf("  Device type: %d\n", doc->device_type);
    printf("  Device revision: %d\n", doc->device_revision);
    printf("  DD revision: %d\n", doc->dd_revision);
    printf("!!=================================!!\n");
    printf(" \n");
    return EDDL_PARSE_OK;
}

char* eddl_parser_get_class_string(class_mask_t mask)
{
    char* ret = NULL;
    //contained
    if((uint8_t)mask & 0x01){
         ret = (char*)malloc(sizeof(char) * 5);
         strcpy(ret, "CONTAINED");
    }
   
    //dynamic
    if(((uint8_t)mask >> 1) & 0x01){
        if(ret == NULL){
            ret = (char*)malloc(sizeof(char) * 5);
            strcpy(ret, "DYNAMIC");
            
        }else{ 
            ret = (char*)realloc(ret, sizeof(char)* (strlen(ret) + 11));
            strcat(ret, " & DYNAMIC");
        }
    }
    
    return ret;
}

char* eddl_parser_get_type_string(type_mask_t mask)
{
    switch((uint8_t)mask){
    case INVAL_TYPE_e:{
        static char inval[] = "INVAL";
        return inval;
        }
        break;
    case FLOAT_TYPE_e:{
        static char float_str[] = "FLOAT";
        return float_str;
        }
        break;
    case INTEGER_TYPE_e:{
        static char int_str[] = "INTEGER";
        return int_str;
        }
        break;
    default:
        break;
    }
    return NULL;
}

char* eddl_parser_get_handling_string(handling_mask_t mask)
{
    char* ret = NULL;
    //read
    if((uint8_t)mask & 0x01){
         ret = (char*)malloc(sizeof(char) * 5);
         strcpy(ret, "READ");
    }
   
    //write
    if(((uint8_t)mask >> 1) & 0x01){
        if(ret == NULL){
            ret = (char*)malloc(sizeof(char) * 5);
            strcpy(ret, "WRITE");
            
        }else{ 
            ret = (char*)realloc(ret, sizeof(char)* 13);
            strcpy(ret, "READ & WRITE");
        }
    }
   
    return ret;
}

char* eddl_parser_get_default_val_string(eddl_variable_t* var)
{
    char buffer[12];
    switch((uint8_t)var->type){
    case INVAL_HANDLING_e:{
        static char inval[] = "NULL";
        return inval;
        }
        break;
    case FLOAT_TYPE_e:{
        sprintf(buffer, "%f",*(float*)var->default_value);
        }
        break;
    case INTEGER_TYPE_e:{
        sprintf(buffer, "%d",*(int*)var->default_value);
        }
        break;
    default:
        return NULL;
    }

    char* ret = (char*)malloc(sizeof(char) * (strlen(buffer) + 1));
    strcpy(ret, buffer);
    return ret;
}

EDDL_PARSE_ERR_t eddl_parser_print_var(eddl_variable_t* var)
{
    char* tmp = NULL;
    printf("!!=============VARIABLE============!!\n");
    printf("  Variable: %s\n", (var->name != NULL) ? var->name : "NULL");
    printf("  Label   : %s\n", (var->label != NULL) ? var->label : "NULL");
    printf("  Help    : %s\n", (var->help != NULL) ? var->help : "NULL");
    tmp = eddl_parser_get_class_string(var->_class);
    printf("  Class   : %s\n", (tmp != NULL) ? tmp : "NULL");
    tmp = eddl_parser_get_type_string(var->type);
    printf("  Type    : %s\n", (tmp != NULL) ? tmp : "NULL");
    tmp = eddl_parser_get_handling_string(var->handling);
    printf("  Handling: %s\n", (tmp != NULL) ? tmp : "NULL");
    tmp = eddl_parser_get_default_val_string(var);
    printf("  Default\n");
    printf("  value   : %s\n", (tmp != NULL) ? tmp : "NULL");
    printf("!!=================================!!\n");
    printf(" \n");

}

int main (void) 
{
    doc_object = eddl_parser_create_eddl_t();
    int ret = yyparse(); 
    eddl_parser_print_doc(doc_object);
    return ret;
}
