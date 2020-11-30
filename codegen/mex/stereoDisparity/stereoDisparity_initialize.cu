//
//  stereoDisparity_initialize.cu
//
//  Code generation for function 'stereoDisparity_initialize'
//


// Include files
#include "stereoDisparity_initialize.h"
#include "_coder_stereoDisparity_mex.h"
#include "rt_nonfinite.h"
#include "stereoDisparity.h"
#include "stereoDisparity_data.h"

// Function Definitions
void stereoDisparity_initialize()
{
  mex_InitInfAndNan();
  mexFunctionCreateRootTLS();
  emlrtClearAllocCountR2012b(emlrtRootTLSGlobal, false, 0U, 0);
  emlrtEnterRtStackR2012b(emlrtRootTLSGlobal);
  emlrtLicenseCheckR2012b(emlrtRootTLSGlobal, "Distrib_Computing_Toolbox", 2);
  emlrtFirstTimeR2012b(emlrtRootTLSGlobal);
  cudaGetLastError();
}

// End of code generation (stereoDisparity_initialize.cu)
