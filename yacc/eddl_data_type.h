#ifndef __EDDL_DATA_TYPE_H__
#define __EDDL_DATA_TYPE_H__

#include "stdint.h"

typedef enum {
   EDDL_PARSE_OK,
   EDDL_PARSE_MEM,
   EDDL_PARSE_INVAL,
}EDDL_PARSE_ERR_t;

typedef enum{
    INVAL_CLASS_e   = 0x00,
    CONTAINED_e     = 0x01,
    DYNAMIC_e       = 0x02,
} class_mask_t;

typedef enum{
    INVAL_TYPE_e    = 0x00,
    FLOAT_e         = 0x01,
    INTEGER_e       = 0x02,
} type_mask_t;

typedef enum{
    INVAL_HANDLE_e  = 0x00,
    READ_e          = 0x01,
    WRITE_e         = 0x02,
} handling_mask_t;

typedef struct eddl_variable eddl_variable_t;

struct eddl_variable{
    char*           __name;
    char*           __label;
    char*           __help;
    class_mask_t    __class;
    type_mask_t     __type;
    void*           __default_value;
    handling_mask_t __handling; 

    eddl_variable_t* next;
};

typedef struct eddl_object eddl_object_t;

struct eddl_object{
    int manufacturer;
    uint16_t device_type;
    int device_revision;
    int dd_revision;

    eddl_variable_t* variable_head;
};

#endif
