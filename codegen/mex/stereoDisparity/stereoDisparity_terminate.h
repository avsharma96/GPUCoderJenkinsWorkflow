//
//  stereoDisparity_terminate.h
//
//  Code generation for function 'stereoDisparity_terminate'
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
#include "stereoDisparity_types.h"

// Custom Header Code
#ifdef __CUDA_ARCH__
#undef printf
#endif

// Function Declarations
CODEGEN_EXPORT_SYM void stereoDisparity_atexit();
CODEGEN_EXPORT_SYM void stereoDisparity_terminate();

// End of code generation (stereoDisparity_terminate.h)
