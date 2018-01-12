/**
 * @file eddl_data_type.h
 * @author Alex Hoffman
 * @date 22 December 2017
 * @brief Text parser to extract information from EDD files
 *
 * @mainpage EDDL Parser
 * This is a very basic EDDL parser used for a proof of concept. May be expanded in the future.
**/

#ifndef __EDDL_DATA_TYPE_H__
#define __EDDL_DATA_TYPE_H__

#include "stdint.h"

#ifndef bool
#define bool unsigned char
#endif
#ifndef true
#define true 1
#endif
#ifndef false
#define false 0
#endif

/**
 * @enum
 * @brief
 * */
typedef enum {
   EDDL_PARSE_OK,
   EDDL_PARSE_MEM,
   EDDL_PARSE_INVAL,
   EDDL_PARSE_ASSERT,
}EDDL_PARSE_ERR_t;

/**
 * @enum
 * @brief
 * */
typedef enum{
    INVAL_CLASS_e   = 0x00,
    ALARM_CLASS_e,
    ANALOG_INPUT_CLASS_e,
    ANALOG_OUTPUT_CLASS_e,
    COMPUTATION_CLASS_e,
    CONTAINED_CLASS_e,
    CORRECTION_CLASS_e,
    DEVICE_CLASS_e,
    DIAGNOSTIC_CLASS_e,
    DIGITAL_INPUT_CLASS_e,
    DIGITAL_OUTPUT_CLASS_e,
    DISCRETE_INPUT_CLASS_e,
    DISCRETE_OUTPUT_CLASS_e,
    DYNAMIC_CLASS_e,
    FREQUENCY_INPUT_CLASS_e,
    FREQUENCY_OUTPUT_CLASS_e,
    HART_CLASS_e,
    INPUT_CLASS_e,
    LOCAL_CLASS_e,
    LOCAL_DISPLAY_CLASS_e,
    OPERATE_CLASS_e,
    OPTIONAL_CLASS_e,
    OUTPUT_CLASS_e,
    SERVICE_CLASS_e,
    TEMPORARY_CLASS_e,
    TUNE_CLASS_e
} class_mask_t;

/**
 * @enum
 * @brief
 * */
typedef enum{
    INVAL_TYPE_e    = 0x00,
    DOUBLE_TYPE_e,  
    FLOAT_TYPE_e,
    INTEGER_TYPE_e,
    UNSIGNED_INTEGER_TYPE_e,
    DATE_TYPE_e,
    DATE_AND_TIME_TYPE_e,
    DURATION_TYPE_e,
    TIME_TYPE_e,
    TIME_VALUE_4_TYPE_e,
    TIME_VALUE_8_TYPE_e,
    BIT_ENUMERATED_TYPE_e,
    ENUMERATED_TYPE_e,
    INDEX_TYPE_e,
    OBJECT_REFERENCE_TYPE_e,
    ASCII_TYPE_e,
    BITSTRING_TYPE_e,
    EUC_TYPE_e,
    OCTET_TYPE_e,
    PACKED_ASCII_TYPE_e,
    PASSWORD_TYPE_e,
    VISIBLE_TYPE_e
} type_mask_t;

/**
 * @enum
 * @brief
 * */
typedef enum{
    INVAL_HANDLING_e  = 0x00,
    READ_HANDLING_e,
    READ_WRITE_HANDLING_e,
    WRITE_HANDLING_e
} handling_mask_t;

/**
 * @typedef 
 * @brief
 * */
typedef struct eddl_variable eddl_variable_t;
 
/**
 * @struct eddl_variable
 * @brief Structure that represents a EDD variable object
 * */
struct eddl_variable{
    char*           name;
    class_mask_t    _class;
    char*           label;
    type_mask_t     type;
    char*           constant_unit;
    void*           default_value;
    handling_mask_t handling; 
    char*           help;
    void*           initial_value;
    void*           post_edit_actions;
    void*           post_read_actions;
    void*           post_write_actions;
    void*           pre_edit_actions;
    void*           pre_read_actions;
    void*           pre_write_actions;
    int             read_timeout;
    void*           refresh_actions;
    char*           response_code;
    char*           style;
    bool            validity;
    int             write_timeout;
    eddl_variable_t* next;
};

/**
 * @typedef 
 * @brief
 * */
typedef struct eddl_object eddl_object_t;

/**
 * @struct
 * @brief
 * */
struct eddl_object{
    int manufacturer;
    uint16_t device_type;
    int device_revision;
    int dd_revision;

    eddl_variable_t* current_var;
    eddl_variable_t* variable_head;
};

#endif
