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
 * @brief Global document object used when parsing an EDD file 
 * */
extern eddl_object_t* doc_object;

/**
 * @brief Creates an EDD document object used by the parser
 * @return eddl_object_t* Pointer to created document object
 * */
eddl_object_t* eddl_parser_create_eddl_t(void);

/**
 * @brief Creates an EDD variable object
 *
 * @param object Parent object for the EDD object that is to be created
 * @return EDDL_PARSE_ERR_t error message
 * */
EDDL_PARSE_ERR_t eddl_parser_create_variable_t(eddl_object_t* object);

/**
 * @brief Sets the manufacturer ID number in the file information of an 
 * EDD document object
 *
 * @param object The EDD document objects who's manufacture ID is to be set
 * @param val Manufacturer ID value to be set
 * @return EDDL_PARSE_ERR_t error message
 * */
EDDL_PARSE_ERR_t eddl_parser_set_manufacturer(eddl_object_t* object,
        int val);

/**
 * @brief Sets the device type number in the file information of an 
 * EDD document object
 *
 * @param object The EDD document objects who's device type is to be set
 * @param val device type value to be set
 * @return EDDL_PARSE_ERR_t error message
 * */
EDDL_PARSE_ERR_t eddl_parser_set_device_type(eddl_object_t* object,
        long val);

/**
 * @brief Sets the device revision number in the file information of an 
 * EDD document object
 *
 * @param object The EDD document objects who's device revision is to be set
 * @param val device revision value to be set
 * @return EDDL_PARSE_ERR_t error message
 * */
EDDL_PARSE_ERR_t eddl_parser_set_device_revision(eddl_object_t* object,
        int val);

/**
 * @brief Sets the DD revision number in the file information of an 
 * EDD document object
 *
 * @param object The EDD document objects who's DD revision is to be set
 * @param val DD revision value to be set
 * @return EDDL_PARSE_ERR_t error message
 * */
EDDL_PARSE_ERR_t eddl_parser_set_dd_revision(eddl_object_t* object,
        int val);

/**
 * @brief Sets the name of a variable object
 *
 * @param var Variable object who's name is to be set
 * @param name String that is to be set as the variable's name
 * @return EDDL_PARSE_ERR_t error message
 * */
EDDL_PARSE_ERR_t eddl_parser_set_variable_name(eddl_variable_t* var,
        char* name);

/**
 * @brief Sets the label of a variable object
 *
 * @param var Variable object who's label is to be set
 * @param name String that is to be set as the variable's label
 * @return EDDL_PARSE_ERR_t error message
 * */
EDDL_PARSE_ERR_t eddl_parser_set_variable_label(eddl_variable_t* var,
        char* label);

/**
 * @brief Sets the help message of a variable object
 *
 * @param var Variable object who's help message is to be set
 * @param name String that is to be set as the variable's help message
 * @return EDDL_PARSE_ERR_t error message
 * */
EDDL_PARSE_ERR_t eddl_parser_set_variable_help(eddl_variable_t* var,
        char* help);

/**
 * @brief Sets the class mask of a variable object
 *
 * @param var Variable object who's class mask is to be set
 * @param name String that is to be set as the variable's class mask
 * @return EDDL_PARSE_ERR_t error message
 * */
EDDL_PARSE_ERR_t eddl_parser_set_variable_class_mask(
        eddl_variable_t* var, class_mask_t mask);

/**
 * @brief Sets the type mask of a variable object
 *
 * @param var Variable object who's type mask is to be set
 * @param name String that is to be set as the variable's type mask
 * @return EDDL_PARSE_ERR_t error message
 * */
EDDL_PARSE_ERR_t eddl_parser_set_variable_type_mask(
        eddl_variable_t* var, type_mask_t mask);

/**
 * @brief Sets the default value of a variable object
 *
 * @param var Variable object who's default value is to be set
 * @param name String that is to be set as the variable's default value
 * @return EDDL_PARSE_ERR_t error message
 * */
EDDL_PARSE_ERR_t eddl_parser_set_variable_default_value(
        eddl_variable_t* var, void* value);

/**
 * @brief Sets the handling of a variable object
 *
 * @param var Variable object who's handling is to be set
 * @param name String that is to be set as the variable's handling
 * @return EDDL_PARSE_ERR_t error message
 * */
EDDL_PARSE_ERR_t eddl_parser_set_variable_handling(eddl_variable_t* var,
        handling_mask_t val);

/**
 * @brief Gets the class mask for a given class' string name
 *
 * @param class_string String name of a class
 * @return class_mask_t returns the class' enum value
 * */
class_mask_t eddl_parser_get_class_mask(char* class_string);

/**
 * @brief Gets the type mask for a given type's string name
 *
 * @param class_string String name of a type
 * @return class_mask_t returns the type's enum value
 * */
type_mask_t eddl_parser_get_type_mask(char* type_string);

/**
 * @brief Gets the handling mask for a given handling's string name
 *
 * @param class_string String name of a handling type
 * @return class_mask_t returns the handing's enum value
 * */
handling_mask_t eddl_parser_get_handling_mask(char* handling_string);

/**
 * @brief Gets the string name of a class' mask
 *
 * @param mask Enum value of a class' mask
 * @return char* String name of a the given class' mask
 * */
char* eddl_parser_get_class_string(class_mask_t mask);

/**
 * @brief Gets the string name of a type mask
 *
 * @param mask Enum value of a type mask
 * @return char* String name of a the given type mask
 * */
char* eddl_parser_get_type_string(type_mask_t mask);

/**
 * @brief Gets the string name of a handling mask
 *
 * @param mask Enum value of a handling mask
 * @return char* String name of a the given handling mask
 * */
char* eddl_parser_get_handling_string(handling_mask_t mask);

/**
 * @brief Get's the string representation of a variable's default value
 *
 * @param var The variable object who's default value should be returned as a string
 * @return char* String of the variable object's default value
 * */
char* eddl_parser_get_default_val_string(eddl_variable_t* var);

/**
 * @brief Get's the string representation of a variable's initial value
 *
 * @param var The variable object who's initial value should be returned as a string
 * @return char* String of the variable object's initial value
 * */
char* eddl_parser_get_initial_value_string(eddl_variable_t* var);

/**
 * @brief Gets the string representation of a boolean value
 *
 * @param val Boolean that is to be returned as a string
 * @return char* String representation of the given boolean
 * */
char* eddl_parser_get_bool_string(bool val);

/**
 * @brief Prints the contents of a EDD variable object 
 *
 * @param var Variable object who's contents is to be printed
 * @return EDDL_PARSE_ERR_t error message
 * */
EDDL_PARSE_ERR_t eddl_parser_print_var(eddl_variable_t* var);

/**
 * @brief Main runtime function called to parse an EDD file
 *
 * @param filename The filename of the EDD to be parsed
 * @return int error message
 * */
int edd_parser_runtime(char* filename);

#endif
