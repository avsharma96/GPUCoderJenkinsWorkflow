/*
 * _coder_subtrPrecision_info.cu
 *
 * Code generation for function '_coder_subtrPrecision_info'
 *
 */

/* Include files */
#include "_coder_subtrPrecision_info.h"
#include "emlrt.h"
#include "rt_nonfinite.h"
#include "tmwtypes.h"

/* Function Declarations */
static const mxArray *emlrtMexFcnResolvedFunctionsInfo();

/* Function Definitions */
static const mxArray *emlrtMexFcnResolvedFunctionsInfo()
{
  const mxArray *nameCaptureInfo;
  const char * data[9] = {
    "789ced58cf4f134114de0a1a6382a089267a91a03762172120f1d69ff407a5852d818846a6bb433bb23bbbce6c4be1628f1e48fc173ceacda3070f1cbd6b8c77"
    "493cf11f70b0dbdda9dba5cd825b16daf425edf6f5ebf6fbde7bd3af93e102c94c80e3b89b9c191f26cceb48fd715407c6acf7af70ade1c403d6f59a23677195",
    "1be68edf9af731dcb8ffbd958b2ad6615537130c14d8bc5352158401d6f3bb1ae408a4aa5c815203d94232cc23050af664c9c894b80d6a260664bc8e94a0b82d"
    "94158e94e83f85b23d69f6e397ad5e433fab77b84d3fec38abbf62cb0d9cc59895337c23f632f28c5fa590501e4888f2590ca30455e0f8e3f10cd04b6b2ad9a6",
    "7c5415cb0ac43ae533a1fc6228ccc7aa40d16448f995e9a9e929c00b3a24508d22aa0182f4dd85dc6a4495204941bc8d30e569b9a0931c8122a248c541c5acd3"
    "98c3a6c73a873ad639d4c8418136fbda0dbe615bdeca67ae3384f5793bdf478f7c0b1df9cc9ce11bc9c5f5c62873442d12a08c1b0bae392e6b4abaaaca05b5ca",
    "4345e66554e015a0cba0c04379ab8cf97aa7ea8371ebd3e82975dbaf76dd23dcf5461efcfd2360efd379f3713f8fdef8ca67c545f1553b7cdf69d7dd9d0e7c6c"
    "dd317c3b162e86abeaf3456d4e5c283c21e954369cb1e9c8b9f0b8e9e06c79bb3acffbfb7bf5f75bf3a8fb818b6e868b86cd07ebae0709067210d17019c97a12",
    "2fd5ff2f08122fcc77bf79e42bbad4cff033cd8d96008112dfe899f56c8c71d27c39c9bac83bbbe8a72f7ff2d7976b37ee7ff5938f45affaf2dd0e7c6c5d327c"
    "6f4a43691a13b3d11c8a9766f3f3a1c26c3636f0e55ef7e57b2eba19eef0652a02199020db0d7bdf0f3ba3931e168cef8bc7fa05173e869f796ec6e384114f9a",
    "7db366789abe75cb370e0f7dde1f7f46fbbef259d1ef3e9c2e0ad5e5e44a6566390605394ed2c27a251a19f8f045fbf03b8fba275c7433dce1c340d3e45da161"
    "2af1321675a4e2d67e6a1e758ddaf276ba18be65b1bf2a012cc9b0c97fe0917fc3859fe1ddf1e736edf4d9a7fd3ec7a8dd7ea4f9c9c7a2df7dfaf5ce42692d44",
    "137bd28e965f4989e0a9b03a17ee1f9f3ee8707faffeaebdfaf743977a18eef4ef8a8aa4102160372e035d8718e1628baecdffd4e58cd3eea70f3cf6e1850b1f"
    "c3bb34d736ed3307eb97bfecdffaeeefbebaf6e7d8573e2bfaddaff7528999c8aab6ae2c17b252687d2b91a92ad9c4c0af2fab5fd73cd67359ce3d028ecf9dd4",
    "d3fe3c7a70ee71f23a38f7e85f7feed7738fbfd1fc0bea", "" };

  nameCaptureInfo = NULL;
  emlrtNameCaptureMxArrayR2016a(&data[0], 8888U, &nameCaptureInfo);
  return nameCaptureInfo;
}

mxArray *emlrtMexFcnProperties()
{
  mxArray *xResult;
  mxArray *xEntryPoints;
  const char * epFieldName[6] = { "Name", "NumberOfInputs", "NumberOfOutputs",
    "ConstantInputs", "FullPath", "TimeStamp" };

  mxArray *xInputs;
  const char * propFieldName[4] = { "Version", "ResolvedFunctions",
    "EntryPoints", "CoverageInfo" };

  xEntryPoints = emlrtCreateStructMatrix(1, 1, 6, epFieldName);
  xInputs = emlrtCreateLogicalMatrix(1, 2);
  emlrtSetField(xEntryPoints, 0, "Name", emlrtMxCreateString("subtrPrecision"));
  emlrtSetField(xEntryPoints, 0, "NumberOfInputs", emlrtMxCreateDoubleScalar(2.0));
  emlrtSetField(xEntryPoints, 0, "NumberOfOutputs", emlrtMxCreateDoubleScalar
                (1.0));
  emlrtSetField(xEntryPoints, 0, "ConstantInputs", xInputs);
  emlrtSetField(xEntryPoints, 0, "FullPath", emlrtMxCreateString(
    "C:\\Users\\adis\\OneDrive - MathWorks\\Documents\\MATLAB\\Examples\\R2020a\\StereoDisparityGPUCoderJenkins\\subtrPrecision.m"));
  emlrtSetField(xEntryPoints, 0, "TimeStamp", emlrtMxCreateDoubleScalar
                (738125.42971064814));
  xResult = emlrtCreateStructMatrix(1, 1, 4, propFieldName);
  emlrtSetField(xResult, 0, "Version", emlrtMxCreateString(
    "9.8.0.1417392 (R2020a) Update 4"));
  emlrtSetField(xResult, 0, "ResolvedFunctions", (mxArray *)
                emlrtMexFcnResolvedFunctionsInfo());
  emlrtSetField(xResult, 0, "EntryPoints", xEntryPoints);
  return xResult;
}

/* End of code generation (_coder_subtrPrecision_info.cu) */
