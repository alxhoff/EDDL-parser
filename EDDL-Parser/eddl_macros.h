#ifndef __EDDL_MACROS_H__
#define __EDDL_MACROS_H__

#define TYPE_MASKS(FUNC)            \
            FUNC(INVAL)             \
            FUNC(DOUBLE)            \
            FUNC(FLOAT)             \
            FUNC(INTEGER)           \
            FUNC(UNSIGNED_INTEGER)  \
            FUNC(DATE_TYPE)         \
            FUNC(DATE_AND_TIME)     \
            FUNC(DURATION)          \
            FUNC(TIME)              \
            FUNC(TIME_VALUE_4)      \
            FUNC(TIME_VALUE_8)      \
            FUNC(BIT_ENUMERATED)    \
            FUNC(ENUMERATED)        \
            FUNC(INDEX)             \
            FUNC(OBJECT_REFERENCE)  \
            FUNC(ASCII)             \
            FUNC(BITSTRING)         \
            FUNC(EUC)               \
            FUNC(OCTET)             \
            FUNC(PACKED_ASCII)      \
            FUNC(PASSWORD)          \
            FUNC(VISIBLE)           \

/**
 * @enum
 * @brief
 * */
#define TYPE_ENUM(foo) foo##_TYPE_e ,

#define TYPE_STRING(foo) #foo ,

typedef enum {TYPE_MASKS(TYPE_ENUM)} type_mask_t;

#define CLASS_MASKS(FUNC)           \
            FUNC(INVAL)             \
            FUNC(ALARM)             \
            FUNC(ANALOG_INPUT)      \
            FUNC(ANALOG_OUTPUT)     \
            FUNC(COMPUTATION)       \
            FUNC(CONTAINED)         \
            FUNC(CORRECTION)        \
            FUNC(DEVICE)            \
            FUNC(DIAGNOSTIC)        \
            FUNC(DIGITAL_INPUT)     \
            FUNC(DIGITAL_OUTPUT)    \
            FUNC(DISCRETE_INPUT)    \
            FUNC(DISCRETE_OUTPUT)   \
            FUNC(DYNAMIC)           \
            FUNC(FREQUENCY_INPUT)   \
            FUNC(FREQUENCY_OUTPUT)  \
            FUNC(HART)              \
            FUNC(INPUT)             \
            FUNC(LOCAL)             \
            FUNC(LOCAL_DISPLAY)     \
            FUNC(OPERATE)           \
            FUNC(OPERATIONAL)       \
            FUNC(OUTPUT)            \
            FUNC(SERVICE)           \
            FUNC(TEMPORARY)         \
            FUNC(TUNE)              \

/**
 * @enum
 * @brief
 * */
#define CLASS_ENUM(foo) foo##_CLASS_e , 

#define CLASS_STRING(foo) #foo ,

typedef enum {CLASS_MASKS(CLASS_ENUM)} class_mask_t;

#define HANDLING_MASKS(FUNC)    \
            FUNC(INVAL)         \
            FUNC(READ)          \
            FUNC(READ_WRITE)    \
            FUNC(WRITE)         \

/**
 * @enum
 * @brief
 * */
#define HANDLING_ENUM(foo) foo##_HANDLING_e ,

#define HANDLING_STRING(foo) #foo ,

typedef enum {HANDLING_MASKS(HANDLING_ENUM)} handling_mask_t;

#endif
