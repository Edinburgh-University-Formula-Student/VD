#ifndef Model_private_h_
#define Model_private_h_
#include "rtwtypes.h"
#include "builtin_typeid_types.h"
#include "multiword_types.h"
#include "zero_crossing_types.h"
#include "Model.h"
#include "Model_types.h"
#if !defined(rt_VALIDATE_MEMORY)
#define rt_VALIDATE_MEMORY(S, ptr)     if(!(ptr)) {\
    ssSetErrorStatus(rtS, RT_MEMORY_ALLOCATION_ERROR);\
    }
#endif
#if !defined(rt_FREE)
#if !defined(_WIN32)
#define rt_FREE(ptr)     if((ptr) != (NULL)) {\
    free((ptr));\
    (ptr) = (NULL);\
    }
#else
#define rt_FREE(ptr)     if((ptr) != (NULL)) {\
    free((void *)(ptr));\
    (ptr) = (NULL);\
    }
#endif
#endif
extern void rt_mrdivide_U1d1x3_U2d3x3_Yd1x3_snf ( const real_T u0 [ 3 ] ,
const real_T u1 [ 9 ] , real_T y [ 3 ] ) ; extern real_T look1_binlcpw ( real_T
u0 , const real_T bp0 [ ] , const real_T table [ ] , uint32_T maxIndex ) ;
extern real_T look1_binlxpw ( real_T u0 , const real_T bp0 [ ] , const real_T
table [ ] , uint32_T maxIndex ) ; extern void f54ycx0ndz ( real_T kryq1p10wx
, bm2a545cdv * localB ) ; extern void fznn3ldl1e ( SimStruct * rtS_p ,
kykmqioigc * localDW ) ; extern void odtknpjn1i ( kykmqioigc * localDW ) ;
extern void cman0zlcfc ( SimStruct * rtS_i , boolean_T g0qnmwznz3 , real_T
nbxz4veflo , bm2a545cdv * localB , kykmqioigc * localDW ) ; extern void
pgfbx23c43 ( real_T atlsdikn0k , m2bzlhlghr * localB , kje4vbgpbu * localDW ,
ikjp2x302z * localP , giuxx4bd40 * localX ) ; extern void kovljustuh ( m2bzlhlghr * localB ) ; extern void hnzoeoxnn3 ( m2bzlhlghr * localB , kje4vbgpbu * localDW , c0x20tyv52 * localXdot ) ; extern void bbqqnkju14 ( SimStruct * rtS_j , real_T gqyplkyqks , real_T ikreitp4o2 , real_T mb4jhyox5m , real_T atlsdikn0k , real_T lezxizdkbi , real_T mxidrz4wu1 , real_T dvtj4qf2gh , m2bzlhlghr * localB , kje4vbgpbu * localDW , ikjp2x302z * localP , giuxx4bd40 * localX ) ; extern void bbqqnkju14TID4 ( real_T lezxizdkbi , m2bzlhlghr * localB , ikjp2x302z * localP ) ; extern void pn2024uvyk ( void ) ; extern void imefofx3s3 ( int32_T npix534sv4 ) ;
#if defined(MULTITASKING)
#error Models using the variable step solvers cannot define MULTITASKING
#endif
#endif
