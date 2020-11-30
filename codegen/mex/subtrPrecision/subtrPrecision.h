//
//  subtrPrecision.h
//
//  Code generation for function 'subtrPrecision'
//


#pragma once

// Include files
#include <cmath>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include "mex.h"
#include "emlrt.h"
#include "rtwtypes.h"
#include "subtrPrecision_types.h"

// Custom Header Code
#ifdef __CUDA_ARCH__
#undef printf
#endif

// Variable Declarations
extern emlrtCTX emlrtRootTLSGlobal;
extern emlrtContext emlrtContextGlobal;

// Function Declarations
CODEGEN_EXPORT_SYM int8_T subtrPrecision(real_T a, real_T b);
void subtrPrecision_api(const mxArray * const prhs[2], int32_T nlhs, const
  mxArray *plhs[1]);
CODEGEN_EXPORT_SYM void subtrPrecision_atexit();
CODEGEN_EXPORT_SYM void subtrPrecision_initialize();
CODEGEN_EXPORT_SYM void subtrPrecision_terminate();

// End of code generation (subtrPrecision.h)
