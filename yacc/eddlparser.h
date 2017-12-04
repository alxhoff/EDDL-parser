#ifndef __EDDLPARSER_H__
#define __EDDLPARSER_H__

#include "eddl_data_type.h"

eddl_object_t* doc_object;

eddl_object_t* eddl_parser_create_eddl_t(void);
EDDL_PARSE_ERR_t eddl_parser_create_variable_t(eddl_object_t*);

EDDL_PARSE_ERR_t eddl_parser_set_manufacturer(eddl_object_t* object,
        int val);
EDDL_PARSE_ERR_t eddl_parser_set_device_type(eddl_object_t* object,
        long val);
EDDL_PARSE_ERR_t eddl_parser_set_device_revision(eddl_object_t* object,
        int val);
EDDL_PARSE_ERR_t eddl_parser_set_dd_revision(eddl_object_t* object,
        int val);
EDDL_PARSE_ERR_t eddl_parser_set_variable_name(eddl_variable_t* var,
        char* name);
EDDL_PARSE_ERR_t eddl_parser_set_variable_label(eddl_variable_t* var,
        char* label);
EDDL_PARSE_ERR_t eddl_parser_set_variable_help(eddl_variable_t* var,
        char* help);
EDDL_PARSE_ERR_t eddl_parser_set_variable_class_mask(
        eddl_variable_t* var, class_mask_t mask);
EDDL_PARSE_ERR_t eddl_parser_set_variable_type_mask(
        eddl_variable_t* var, type_mask_t mask);
EDDL_PARSE_ERR_t eddl_parser_set_variable_default_value(
        eddl_variable_t* var, void* value);
EDDL_PARSE_ERR_t eddl_parser_set_handling(eddl_variable_t* var,
        handling_mask_t val);
class_mask_t eddl_parser_get_class_mask(char* class_string);
type_mask_t eddl_parser_get_type_mask(char* type_string);
handling_mask_t eddl_parser_get_handling_mask(char* handling_string);

#endif
