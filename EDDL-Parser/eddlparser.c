#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#include "eddlparser.h"
#include "eddl_data_type.h"

eddl_object_t* doc_object;

int yylex(void);
int yyparse(void);

const char* edd_type_strings[] = {TYPE_MASKS(TYPE_STRING)};
const char* edd_handling_strings[] = {HANDLING_MASKS(HANDLING_STRING)};
const char* edd_class_strings[] = {CLASS_MASKS(CLASS_STRING)};

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
    return ret;
}

EDDL_PARSE_ERR_t eddl_parser_create_variable_t(eddl_object_t* object)
{
    eddl_variable_t* ret = (eddl_variable_t*)calloc(1, sizeof(eddl_variable_t));
    if(ret == NULL) return EDDL_PARSE_MEM;
    
    if(object->variable_head == NULL){
        object->variable_head = ret;
        object->current_var = ret;
        return EDDL_PARSE_OK;
    }else{
        //TODO can this line be removed VVVV
        eddl_variable_t* tail_var = eddl_parser_get_last_ll_var(object);
        tail_var->next = ret;
        object->current_var = ret;
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
        case DOUBLE_TYPE_e:{
            var->default_value = (double*)malloc(sizeof(double));
            double tmp = (double)*((double*)value);
            memcpy(var->default_value, &tmp, sizeof(double));
            }
            break;
        case FLOAT_TYPE_e:{
            var->default_value = (float*)malloc(sizeof(float));
            float tmp = (float)*((double*)value);
            memcpy(var->default_value, &tmp, sizeof(float));
            }
            break;
        case INTEGER_TYPE_e:{
            var->default_value = (int*)malloc(sizeof(int));
            int tmp = (int)*((int*)value);
            memcpy(var->default_value, &tmp, sizeof(int));
            }
            break; 
        case UNSIGNED_INTEGER_TYPE_e:{
            var->default_value = (unsigned int*)malloc(sizeof(unsigned int));
            unsigned int tmp = (unsigned int)*((unsigned int*)value);
            memcpy(var->default_value, &tmp, sizeof(unsigned int));
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

#define GET_CLASS_MASK(foo) \
            if(!strcmp(tmp, #foo)) ret |= CLASS_e_##foo;

class_mask_t eddl_parser_get_class_mask(char* class_string)
{
    class_mask_t ret = CLASS_e_INVAL;

    char* tmp;
    tmp = strtok(remove_spaces(class_string), "&");
    while(tmp != NULL){
        CLASS_MASKS(GET_CLASS_MASK)
        tmp = strtok(NULL, "&");
    }
    return ret;
}

#define GET_TYPE_MASK(foo) \
            if(!strcmp(type_string, #foo)) ret = foo##_TYPE_e;

type_mask_t eddl_parser_get_type_mask(char* type_string)
{
    type_mask_t ret = INVAL_TYPE_e;

    TYPE_MASKS(GET_TYPE_MASK)

    return ret;
}

#define GET_HANDLING_MASK(foo) \
            if(!strcmp(tmp, #foo)) ret |= foo##_HANDLING_e;

handling_mask_t eddl_parser_get_handling_mask(char* handling_string)
{
    handling_mask_t ret = INVAL_HANDLING_e;
    char* tmp;

    tmp = strtok(remove_spaces(handling_string), "&");
    while(tmp != NULL){
        HANDLING_MASKS(GET_HANDLING_MASK)
        tmp = strtok(NULL, "&");
    }
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

    eddl_variable_t* var_head;
    if(doc->variable_head != NULL){
        var_head = doc->variable_head;
        while(var_head != NULL){
            eddl_parser_print_var(var_head);
            var_head = var_head->next;
        }
    }
    return EDDL_PARSE_OK;
}

char* eddl_parser_get_class_string(class_mask_t mask)
{
    char* ret = NULL;
    size_t ret_len = 0;
    size_t tmp_len = 0;

    for(int i = 0; i < 26; i++){
        if((mask >> i) & 0x01){
            if(ret != NULL) ret_len = strlen(ret);
            else ret_len = 0;
            tmp_len = strlen(edd_class_strings[i+1]);
            if(ret == NULL) ret = (char*)realloc(ret, sizeof(char) * (tmp_len + 1));
            else ret = (char*)realloc(ret, sizeof(char) * (tmp_len + ret_len + 4));
            if(ret == NULL) return EDDL_PARSE_MEM;
            if(ret_len > 1) strcat(ret, " & ");
            strcat(ret, edd_class_strings[i+1]);
        }
    }
    return ret;
}

char* eddl_parser_get_type_string(type_mask_t mask)
{
    if(edd_type_strings[mask] != NULL)
        return edd_type_strings[mask];
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
    //TODO VOID POINTER DEF VARS
    char buffer[12];
    if(var->default_value != NULL)
        switch(var->type){
        case INVAL_HANDLING_e:{
            static char inval[] = "NULL";
            return inval;
            }
            break;
        case DOUBLE_TYPE_e:{
            sprintf(buffer, "%lf", *(double*)var->default_value);
            }
            break;
        case FLOAT_TYPE_e:{
            sprintf(buffer, "%f", *(float*)var->default_value);
            }
            break;
        case INTEGER_TYPE_e:{
            sprintf(buffer, "%i", *(int*)var->default_value);
            }
            break;
        case UNSIGNED_INTEGER_TYPE_e:{
            sprintf(buffer, "%u", *(unsigned int*)var->default_value);
            }
            break;
        default:
            return NULL;
        }
    else{
        static char return_val[] = "NULL";
        return return_val;
    }

    char* ret = (char*)malloc(sizeof(char) * (strlen(buffer) + 1));
    strcpy(ret, buffer);
    return ret;
}

char* eddl_parser_get_initial_value_string(eddl_variable_t* var)
{

}

char* eddl_parser_get_bool_string(bool val)
{
    if(val == true) {
        static char true_str[] = "true";   
        return true_str;
    }else if(val == false) {
        static char false_str[] = "false";
        return false_str;
    }else return NULL;
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
