//
//  subtrPrecision.cu
//
//  Code generation for function 'subtrPrecision'
//


// Include files
#include "subtrPrecision.h"
#include "_coder_subtrPrecision_mex.h"
#include "rt_nonfinite.h"
#include <math.h>

// Variable Definitions
emlrtCTX emlrtRootTLSGlobal = NULL;
emlrtContext emlrtContextGlobal = { true,// bFirstTime
  false,                               // bInitialized
  131594U,                             // fVersionInfo
  NULL,                                // fErrorFunction
  "subtrPrecision",                    // fFunctionName
  NULL,                                // fRTCallStack
  false,                               // bDebugMode
  { 3194014219U, 53452778U, 2865749887U, 3590888462U },// fSigWrd
  NULL                                 // fSigMem
};

// Function Declarations
static real_T b_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId);
static real_T c_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
  *msgId);
static real_T emlrt_marshallIn(const mxArray *a, const char_T *identifier);
static const mxArray *emlrt_marshallOut(const int8_T u);
static real_T rt_roundd_snf(real_T u);

// Function Definitions
static real_T b_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId)
{
  real_T y;
  y = c_emlrt_marshallIn(emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}

static real_T c_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
  *msgId)
{
  real_T ret;
  static const int32_T dims = 0;
  emlrtCheckBuiltInR2012b(emlrtRootTLSGlobal, msgId, src, "double", false, 0U,
    &dims);
  ret = *(real_T *)emlrtMxGetData(src);
  emlrtDestroyArray(&src);
  return ret;
}

static real_T emlrt_marshallIn(const mxArray *a, const char_T *identifier)
{
  real_T y;
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = const_cast<const char *>(identifier);
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  y = b_emlrt_marshallIn(emlrtAlias(a), &thisId);
  emlrtDestroyArray(&a);
  return y;
}

static const mxArray *emlrt_marshallOut(const int8_T u)
{
  const mxArray *y;
  const mxArray *m;
  y = NULL;
  m = emlrtCreateNumericMatrix(1, 1, mxINT8_CLASS, mxREAL);
  *(int8_T *)emlrtMxGetData(m) = u;
  emlrtAssign(&y, m);
  return y;
}

static real_T rt_roundd_snf(real_T u)
{
  real_T y;
  if (fabs(u) < 4.503599627370496E+15) {
    if (u >= 0.5) {
      y = floor(u + 0.5);
    } else if (u > -0.5) {
      y = u * 0.0;
    } else {
      y = ceil(u - 0.5);
    }
  } else {
    y = u;
  }

  return y;
}

int8_T subtrPrecision(real_T a, real_T b)
{
  int8_T out;
  real_T d;
  int8_T i;
  int8_T i1;
  int32_T i2;
  int32_T i3;
  d = rt_roundd_snf(a);
  if (d < 128.0) {
    if (d >= -128.0) {
      i = static_cast<int8_T>(d);
    } else {
      i = MIN_int8_T;
    }
  } else if (d >= 128.0) {
    i = MAX_int8_T;
  } else {
    i = 0;
  }

  d = rt_roundd_snf(b);
  if (d < 128.0) {
    if (d >= -128.0) {
      i1 = static_cast<int8_T>(d);
    } else {
      i1 = MIN_int8_T;
    }
  } else if (d >= 128.0) {
    i1 = MAX_int8_T;
  } else {
    i1 = 0;
  }

  i2 = i - i1;
  if (i2 > 127) {
    i2 = 127;
  } else {
    if (i2 < -128) {
      i2 = -128;
    }
  }

  i3 = -i2;
  if (i3 > 127) {
    i3 = 127;
  }

  if (i2 < 0) {
    out = static_cast<int8_T>(i3);
  } else {
    out = static_cast<int8_T>(i2);
  }

  // works best with int32 precision
  return out;
}

void subtrPrecision_api(const mxArray * const prhs[2], int32_T, const mxArray
  *plhs[1])
{
  real_T a;
  real_T b;

  // Marshall function inputs
  a = emlrt_marshallIn(emlrtAliasP(prhs[0]), "a");
  b = emlrt_marshallIn(emlrtAliasP(prhs[1]), "b");

  // Invoke the target function
  // Marshall function outputs
  plhs[0] = emlrt_marshallOut(subtrPrecision(a, b));
}

void subtrPrecision_atexit()
{
  mexFunctionCreateRootTLS();
  emlrtEnterRtStackR2012b(emlrtRootTLSGlobal);
  emlrtLeaveRtStackR2012b(emlrtRootTLSGlobal);
  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
  emlrtExitTimeCleanup(&emlrtContextGlobal);
}

void subtrPrecision_initialize()
{
  mex_InitInfAndNan();
  mexFunctionCreateRootTLS();
  emlrtClearAllocCountR2012b(emlrtRootTLSGlobal, false, 0U, 0);
  emlrtEnterRtStackR2012b(emlrtRootTLSGlobal);
  emlrtLicenseCheckR2012b(emlrtRootTLSGlobal, "Distrib_Computing_Toolbox", 2);
  emlrtFirstTimeR2012b(emlrtRootTLSGlobal);
  cudaGetLastError();
}

void subtrPrecision_terminate()
{
  cudaError_t errCode;
  errCode = cudaGetLastError();
  if (errCode != cudaSuccess) {
    emlrtThinCUDAError(false, emlrtRootTLSGlobal);
  }

  emlrtLeaveRtStackR2012b(emlrtRootTLSGlobal);
  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
}

// End of code generation (subtrPrecision.cu)
