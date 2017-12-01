#ifndef __EDDL_DATA_TYPE_H__
#define __EDDL_DATA_TYPE_H__

typedef enum{
    CONTAINED_e   = 0x01,
    DYNAMIC_e     = 0x02,
} class_mask_t;

typedef enum{
    FLOAT_e       = 0x01,
} type_mask_t;

typedef enum{
    READ_e        = 0x01,
    WRITE_e       = 0x02,
} handling_mask_t;

typedef struct eddl_variable eddl_variable_t;

struct eddl_variable{
    char*           __name;
    char*           __label;
    char*           __help;
    class_mask_t    __class;
    type_mask_t     __type;
    float           __default_value;
    handling_mask_t __handling; 

    eddl_variable_t* next;
};

typedef struct eddl_object eddl_object_t;

struct eddl_object{
    int manufacturer;
    long device_type;
    int device_revision;
    int dd_revision;

    eddl_variable_t* variable_head;
};

#endif
