/**
 * @file eddlparser.h
 * @author Alex Hoffman
 * @date 22 December 2017
 * @brief Text parser to extract information from EDD files
 *
 * @mainpage EDDL Parser
 * This is a very basic EDDL parser used for a proof of concept. May be expanded in the future.
**/

#ifndef __EDDLPARSER_H__
#define __EDDLPARSER_H__

#include "eddl_data_type.h"

/**
 * @brief
 * */
eddl_object_t* doc_object;

/**
 * @brief
 * */
eddl_object_t* eddl_parser_create_eddl_t(void);

/**
 * @brief
 *
 * @param
 * @return
 * */
EDDL_PARSE_ERR_t eddl_parser_create_variable_t(eddl_object_t*);

/**
 * @brief
 *
 * @param
 * @return
 * */
EDDL_PARSE_ERR_t eddl_parser_set_manufacturer(eddl_object_t* object,
        int val);

/**
 * @brief
 *
 * @param
 * @return
 * */
EDDL_PARSE_ERR_t eddl_parser_set_device_type(eddl_object_t* object,
        long val);

/**
 * @brief
 *
 * @param
 * @return
 * */
EDDL_PARSE_ERR_t eddl_parser_set_device_revision(eddl_object_t* object,
        int val);

/**
 * @brief
 *
 * @param
 * @return
 * */
EDDL_PARSE_ERR_t eddl_parser_set_dd_revision(eddl_object_t* object,
        int val);

/**
 * @brief
 *
 * @param
 * @return
 * */
EDDL_PARSE_ERR_t eddl_parser_set_variable_name(eddl_variable_t* var,
        char* name);

/**
 * @brief
 *
 * @param
 * @return
 * */
EDDL_PARSE_ERR_t eddl_parser_set_variable_label(eddl_variable_t* var,
        char* label);

/**
 * @brief
 *
 * @param
 * @return
 * */
EDDL_PARSE_ERR_t eddl_parser_set_variable_help(eddl_variable_t* var,
        char* help);

/**
 * @brief
 *
 * @param
 * @return
 * */
EDDL_PARSE_ERR_t eddl_parser_set_variable_class_mask(
        eddl_variable_t* var, class_mask_t mask);

/**
 * @brief
 *
 * @param
 * @return
 * */
EDDL_PARSE_ERR_t eddl_parser_set_variable_type_mask(
        eddl_variable_t* var, type_mask_t mask);

/**
 * @brief
 *
 * @param
 * @return
 * */
EDDL_PARSE_ERR_t eddl_parser_set_variable_default_value(
        eddl_variable_t* var, void* value);

/**
 * @brief
 *
 * @param
 * @return
 * */
EDDL_PARSE_ERR_t eddl_parser_set_variable_handling(eddl_variable_t* var,
        handling_mask_t val);

/**
 * @brief
 *
 * @param
 * @return
 * */
class_mask_t eddl_parser_get_class_mask(char* class_string);

/**
 * @brief
 *
 * @param
 * @return
 * */
type_mask_t eddl_parser_get_type_mask(char* type_string);

/**
 * @brief
 *
 * @param
 * @return
 * */
handling_mask_t eddl_parser_get_handling_mask(char* handling_string);

/**
 * @brief
 *
 * @param
 * @return
 * */
EDDL_PARSE_ERR_t eddl_parser_print_var(eddl_variable_t* var);



#endif
