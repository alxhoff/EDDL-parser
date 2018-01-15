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

#define CLASS_MASKS_VAL(FUNC)                                       \
            FUNC(INVAL              = 0b0)                          \
            FUNC(ALARM              = 0b1)                         \
            FUNC(ANALOG_INPUT       = 0b10)                        \
            FUNC(ANALOG_OUTPUT      = 0b100)                       \
            FUNC(COMPUTATION        = 0b1000)                      \
            FUNC(CONTAINED          = 0b10000)                     \
            FUNC(CORRECTION         = 0b100000)                    \
            FUNC(DEVICE             = 0b1000000)                   \
            FUNC(DIAGNOSTIC         = 0b10000000)                  \
            FUNC(DIGITAL_INPUT      = 0b100000000)                 \
            FUNC(DIGITAL_OUTPUT     = 0b1000000000)                \
            FUNC(DISCRETE_INPUT     = 0b10000000000)               \
            FUNC(DISCRETE_OUTPUT    = 0b100000000000)              \
            FUNC(DYNAMIC            = 0b1000000000000)             \
            FUNC(FREQUENCY_INPUT    = 0b10000000000000)            \
            FUNC(FREQUENCY_OUTPUT   = 0b100000000000000)           \
            FUNC(HART               = 0b1000000000000000)          \
            FUNC(INPUT              = 0b10000000000000000)         \
            FUNC(LOCAL              = 0b100000000000000000)        \
            FUNC(LOCAL_DISPLAY      = 0b1000000000000000000)       \
            FUNC(OPERATE            = 0b10000000000000000000)      \
            FUNC(OPERATIONAL        = 0b100000000000000000000)     \
            FUNC(OUTPUT             = 0b1000000000000000000000)    \
            FUNC(SERVICE            = 0b10000000000000000000000)   \
            FUNC(TEMPORARY          = 0b100000000000000000000000)  \
            FUNC(TUNE               = 0b1000000000000000000000000) \

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
#define CLASS_ENUM(foo) CLASS_e_##foo , 

#define CLASS_STRING(foo) #foo ,

typedef enum {CLASS_MASKS_VAL(CLASS_ENUM)} class_mask_t;

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
