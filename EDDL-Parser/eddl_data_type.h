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

#include <stdint.h>

#include "eddl_macros.h"

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

typedef struct eddl_file_information eddl_file_information_t;

struct eddl_file_information{
    int manufacturer;
    uint16_t device_type;
    int device_revision;
    int dd_revision;

    int fileinfo_obj_id;
    int name_space;
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
    eddl_file_information_t* file_info;
    eddl_variable_t* current_var;
    eddl_variable_t* variable_head;
};

#endif
