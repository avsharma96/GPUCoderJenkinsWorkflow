//
//  stereoDisparity.h
//
//  Code generation for function 'stereoDisparity'
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
CODEGEN_EXPORT_SYM void stereoDisparity(const uint8_T img0[581632], const
  uint8_T img1[581632], real_T out_disp[145408]);

// End of code generation (stereoDisparity.h)
