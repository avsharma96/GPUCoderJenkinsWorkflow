//
//  stereoDisparity_terminate.cu
//
//  Code generation for function 'stereoDisparity_terminate'
//


// Include files
#include "stereoDisparity_terminate.h"
#include "_coder_stereoDisparity_mex.h"
#include "rt_nonfinite.h"
#include "stereoDisparity.h"
#include "stereoDisparity_data.h"

// Function Definitions
void stereoDisparity_atexit()
{
  mexFunctionCreateRootTLS();
  emlrtEnterRtStackR2012b(emlrtRootTLSGlobal);
  emlrtLeaveRtStackR2012b(emlrtRootTLSGlobal);
  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
  emlrtExitTimeCleanup(&emlrtContextGlobal);
}

void stereoDisparity_terminate()
{
  cudaError_t errCode;
  errCode = cudaGetLastError();
  if (errCode != cudaSuccess) {
    emlrtThinCUDAError(false, emlrtRootTLSGlobal);
  }

  emlrtLeaveRtStackR2012b(emlrtRootTLSGlobal);
  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
}

// End of code generation (stereoDisparity_terminate.cu)
