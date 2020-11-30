//
//  _coder_subtrPrecision_mex.cu
//
//  Code generation for function '_coder_subtrPrecision_mex'
//


// Include files
#include "_coder_subtrPrecision_mex.h"
#include "subtrPrecision.h"

// Function Declarations
MEXFUNCTION_LINKAGE void subtrPrecision_mexFunction(int32_T nlhs, mxArray *plhs
  [1], int32_T nrhs, const mxArray *prhs[2]);

// Function Definitions
void subtrPrecision_mexFunction(int32_T nlhs, mxArray *plhs[1], int32_T nrhs,
  const mxArray *prhs[2])
{
  const mxArray *outputs[1];

  // Check for proper number of arguments.
  if (nrhs != 2) {
    emlrtErrMsgIdAndTxt(emlrtRootTLSGlobal, "EMLRT:runTime:WrongNumberOfInputs",
                        5, 12, 2, 4, 14, "subtrPrecision");
  }

  if (nlhs > 1) {
    emlrtErrMsgIdAndTxt(emlrtRootTLSGlobal,
                        "EMLRT:runTime:TooManyOutputArguments", 3, 4, 14,
                        "subtrPrecision");
  }

  // Call the function.
  subtrPrecision_api(prhs, nlhs, outputs);

  // Copy over outputs to the caller.
  emlrtReturnArrays(1, plhs, outputs);
}

void mexFunction(int32_T nlhs, mxArray *plhs[], int32_T nrhs, const mxArray
                 *prhs[])
{
  mexAtExit(&subtrPrecision_atexit);

  // Module initialization.
  subtrPrecision_initialize();

  // Dispatch the entry-point.
  subtrPrecision_mexFunction(nlhs, plhs, nrhs, prhs);

  // Module termination.
  subtrPrecision_terminate();
}

emlrtCTX mexFunctionCreateRootTLS()
{
  emlrtCreateRootTLS(&emlrtRootTLSGlobal, &emlrtContextGlobal, NULL, 1);
  return emlrtRootTLSGlobal;
}

// End of code generation (_coder_subtrPrecision_mex.cu)
