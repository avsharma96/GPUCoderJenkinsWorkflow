//
//  _coder_stereoDisparity_mex.cu
//
//  Code generation for function '_coder_stereoDisparity_mex'
//


// Include files
#include "_coder_stereoDisparity_mex.h"
#include "_coder_stereoDisparity_api.h"
#include "stereoDisparity.h"
#include "stereoDisparity_data.h"
#include "stereoDisparity_initialize.h"
#include "stereoDisparity_terminate.h"

// Function Declarations
MEXFUNCTION_LINKAGE void stereoDisparity_mexFunction(int32_T nlhs, mxArray *
  plhs[1], int32_T nrhs, const mxArray *prhs[2]);

// Function Definitions
void stereoDisparity_mexFunction(int32_T nlhs, mxArray *plhs[1], int32_T nrhs,
  const mxArray *prhs[2])
{
  const mxArray *outputs[1];

  // Check for proper number of arguments.
  if (nrhs != 2) {
    emlrtErrMsgIdAndTxt(emlrtRootTLSGlobal, "EMLRT:runTime:WrongNumberOfInputs",
                        5, 12, 2, 4, 15, "stereoDisparity");
  }

  if (nlhs > 1) {
    emlrtErrMsgIdAndTxt(emlrtRootTLSGlobal,
                        "EMLRT:runTime:TooManyOutputArguments", 3, 4, 15,
                        "stereoDisparity");
  }

  // Call the function.
  stereoDisparity_api(prhs, nlhs, outputs);

  // Copy over outputs to the caller.
  emlrtReturnArrays(1, plhs, outputs);
}

void mexFunction(int32_T nlhs, mxArray *plhs[], int32_T nrhs, const mxArray
                 *prhs[])
{
  mexAtExit(&stereoDisparity_atexit);

  // Module initialization.
  stereoDisparity_initialize();

  // Dispatch the entry-point.
  stereoDisparity_mexFunction(nlhs, plhs, nrhs, prhs);

  // Module termination.
  stereoDisparity_terminate();
}

emlrtCTX mexFunctionCreateRootTLS()
{
  emlrtCreateRootTLS(&emlrtRootTLSGlobal, &emlrtContextGlobal, NULL, 1);
  return emlrtRootTLSGlobal;
}

// End of code generation (_coder_stereoDisparity_mex.cu)
