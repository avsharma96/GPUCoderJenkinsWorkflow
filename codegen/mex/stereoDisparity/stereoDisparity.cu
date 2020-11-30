//
//  stereoDisparity.cu
//
//  Code generation for function 'stereoDisparity'
//


// Include files
#include "stereoDisparity.h"
#include "MWCudaDimUtility.hpp"
#include "rt_nonfinite.h"

// Function Declarations
static __global__ void stereoDisparity_kernel1(real_T out_disp[145408], real_T
  min_cost[145408]);
static __global__ void stereoDisparity_kernel2(const uint8_T img1[581632], const
  uint8_T img0[581632], const int32_T d, int32_T diff_img[158400]);
static __global__ void stereoDisparity_kernel3(const int32_T diff_img[158400],
  real_T cost_v[153600]);
static __global__ void stereoDisparity_kernel4(const real_T cost_v[153600],
  real_T cost[145408]);
static __global__ void stereoDisparity_kernel5(const int32_T d, const real_T
  cost[145408], real_T out_disp[145408], real_T min_cost[145408]);

// Function Definitions
static __global__ __launch_bounds__(512, 1) void stereoDisparity_kernel1(real_T
  out_disp[145408], real_T min_cost[145408])
{
  uint32_T threadId;
  int32_T temp_cost;
  threadId = static_cast<uint32_T>(mwGetGlobalThreadIndex());
  temp_cost = static_cast<int32_T>(threadId);
  if (temp_cost < 145408) {
    //  Modified Algorithm for Stereo Disparity Block Matching
    //  In this implementation, instead of finding shifted image, indices are
    //  mapped accordingly to save memory and some processing. RGBA column major  
    //  packed data is used as input for compatibility with CUDA intrinsics.
    //  Convolution is performed using separable filters (horizontal and then
    //  vertical).
    //    Copyright 2017-2019 The MathWorks, Inc.
    //  GPU code generation pragma
    //  Stereo Disparity Parameters
    //  |WIN_RAD| is the radius of the window to be operated. |min_disparity| is  
    //  the minimum disparity level the search continues for. |max_disparity| is  
    //  the maximum disparity level the search continues for.
    //  Image Dimensions for Loop Control
    //  The number of channels packed are 4 (RGBA) so as nChannels are 4.
    //  Store the Raw Differences
    //  Store the minimum cost
    //  Store the final disparity
    min_cost[temp_cost] = 9.9999999E+7;
    out_disp[temp_cost] = 0.0;
  }
}

static __global__ __launch_bounds__(512, 1) void stereoDisparity_kernel2(const
  uint8_T img1[581632], const uint8_T img0[581632], const int32_T d, int32_T
  diff_img[158400])
{
  uint32_T threadId;
  int32_T tDiff;
  int32_T colIdx;
  int32_T rowIdx;
  threadId = static_cast<uint32_T>(mwGetGlobalThreadIndex());
  rowIdx = static_cast<int32_T>(threadId % 300U);
  colIdx = static_cast<int32_T>((threadId - static_cast<uint32_T>(rowIdx)) /
    300U);
  if (colIdx < 528) {
    int32_T ind_w2;
    int32_T ind_w1;
    int32_T ind_h;

    //  Row index calculation.
    ind_h = rowIdx - 7;

    //  Column indices calculation for left image.
    ind_w1 = colIdx - 7;

    //  Row indices calculation for right image.
    ind_w2 = (colIdx + d) - 23;

    //  Border clamping for row Indices.
    if (rowIdx - 7 <= 0) {
      ind_h = 1;
    }

    if (ind_h > 284) {
      ind_h = 284;
    }

    //  Border clamping for column indices for left image.
    if (colIdx - 7 <= 0) {
      ind_w1 = 1;
    }

    if (ind_w1 > 512) {
      ind_w1 = 512;
    }

    //  Border clamping for column indices for right image.
    if (ind_w2 <= 0) {
      ind_w2 = 1;
    }

    if (ind_w2 > 512) {
      ind_w2 = 512;
    }

    //  In this step, Sum of absolute Differences is performed
    //  across tour channels.
    tDiff = 0;
    for (int32_T kk = 0; kk < 4; kk++) {
      int32_T temp_cost;
      temp_cost = static_cast<int32_T>(img0[(((ind_h - 1) << 2) + kk) + 1136 *
        (ind_w1 - 1)]) - static_cast<int32_T>(img1[(((ind_h - 1) << 2) + kk) +
        1136 * (ind_w2 - 1)]);
      if (temp_cost < 0) {
        temp_cost = -temp_cost;
      }

      if ((static_cast<int32_T>(tDiff < 0)) && (static_cast<int32_T>(temp_cost <
            MIN_int32_T - tDiff))) {
        tDiff = MIN_int32_T;
      } else if ((static_cast<int32_T>(tDiff > 0)) && (static_cast<int32_T>
                  (temp_cost > MAX_int32_T - tDiff))) {
        tDiff = MAX_int32_T;
      } else {
        tDiff += temp_cost;
      }

      // tDiff = tDiff + abs(int32(img0((ind_h-1)*(nChannels)+chIdx,ind_w1))-int32(img1((ind_h-1)*(nChannels)+chIdx,ind_w2))); 
    }

    //  Store the SAD cost into a matrix.
    diff_img[rowIdx + 300 * colIdx] = tDiff;
  }
}

static __global__ __launch_bounds__(1024, 1) void stereoDisparity_kernel3(const
  int32_T diff_img[158400], real_T cost_v[153600])
{
  int32_T colIdx;
  real_T cv;
  int32_T kk;
  __shared__ int32_T diff_img_shared[1536];
  int32_T baseR;
  int32_T srow;
  int32_T strideRow;
  int32_T scol;
  int32_T strideCol;
  int32_T baseC;
  int32_T x_idx;
  colIdx = mwGetGlobalThreadIndexInYDimension();
  kk = mwGetGlobalThreadIndexInXDimension();
  baseR = kk;
  srow = static_cast<int32_T>(threadIdx.x);
  strideRow = static_cast<int32_T>(blockDim.x);
  scol = static_cast<int32_T>(threadIdx.y);
  strideCol = static_cast<int32_T>(blockDim.y);
  while (srow <= 31) {
    baseC = colIdx;
    for (x_idx = scol; x_idx <= 47; x_idx += strideCol) {
      if ((static_cast<int32_T>((static_cast<int32_T>(baseR >= 0)) && (
             static_cast<int32_T>(baseR < 300)))) && (static_cast<int32_T>((
             static_cast<int32_T>(baseC >= 0)) && (static_cast<int32_T>(baseC <
              528))))) {
        diff_img_shared[srow + 32 * x_idx] = diff_img[300 * baseC + baseR];
      } else {
        diff_img_shared[srow + 32 * x_idx] = 0;
      }

      baseC += strideCol;
    }

    baseR += strideRow;
    srow += strideRow;
  }

  __syncthreads();
  if ((static_cast<int32_T>(colIdx < 512)) && (static_cast<int32_T>(kk < 300)))
  {
    cv = 0.0;
    for (baseR = 0; baseR < 17; baseR++) {
      cv += static_cast<real_T>(diff_img_shared[(static_cast<int32_T>
        (threadIdx.x) + (mwGetGlobalThreadIndexInXDimension() -
                         mwGetGlobalThreadIndexInXDimension())) + 32 * (
        static_cast<int32_T>(threadIdx.y) + baseR)]);
    }

    cost_v[kk + 300 * colIdx] = cv;
  }
}

static __global__ __launch_bounds__(1024, 1) void stereoDisparity_kernel4(const
  real_T cost_v[153600], real_T cost[145408])
{
  int32_T colIdx;
  real_T cv;
  int32_T kk;
  __shared__ real_T cost_v_shared[1536];
  int32_T baseR;
  int32_T srow;
  int32_T strideRow;
  int32_T scol;
  int32_T strideCol;
  int32_T baseC;
  int32_T x_idx;
  colIdx = mwGetGlobalThreadIndexInYDimension();
  kk = mwGetGlobalThreadIndexInXDimension();
  baseR = kk;
  srow = static_cast<int32_T>(threadIdx.x);
  strideRow = static_cast<int32_T>(blockDim.x);
  scol = static_cast<int32_T>(threadIdx.y);
  strideCol = static_cast<int32_T>(blockDim.y);
  while (srow <= 47) {
    baseC = colIdx;
    for (x_idx = scol; x_idx <= 31; x_idx += strideCol) {
      if ((static_cast<int32_T>((static_cast<int32_T>(baseR >= 0)) && (
             static_cast<int32_T>(baseR < 300)))) && (static_cast<int32_T>((
             static_cast<int32_T>(baseC >= 0)) && (static_cast<int32_T>(baseC <
              512))))) {
        cost_v_shared[srow + 48 * x_idx] = cost_v[300 * baseC + baseR];
      } else {
        cost_v_shared[srow + 48 * x_idx] = 0.0;
      }

      baseC += strideCol;
    }

    baseR += strideRow;
    srow += strideRow;
  }

  __syncthreads();
  if ((static_cast<int32_T>(colIdx < 512)) && (static_cast<int32_T>(kk < 284)))
  {
    cv = 0.0;
    for (baseR = 0; baseR < 17; baseR++) {
      cv += cost_v_shared[(static_cast<int32_T>(threadIdx.x) + baseR) + 48 * (
        static_cast<int32_T>(threadIdx.y) + (mwGetGlobalThreadIndexInYDimension()
        - mwGetGlobalThreadIndexInYDimension()))];
    }

    cost[kk + 284 * colIdx] = cv;
  }
}

static __global__ __launch_bounds__(512, 1) void stereoDisparity_kernel5(const
  int32_T d, const real_T cost[145408], real_T out_disp[145408], real_T
  min_cost[145408])
{
  uint32_T threadId;
  int32_T colIdx;
  int32_T kk;
  threadId = static_cast<uint32_T>(mwGetGlobalThreadIndex());
  kk = static_cast<int32_T>(threadId % 284U);
  colIdx = static_cast<int32_T>((threadId - static_cast<uint32_T>(kk)) / 284U);
  if (colIdx < 512) {
    int32_T temp_cost;
    real_T cv;

    //  load the cost
    cv = cost[kk + 284 * colIdx];
    if (cv < 2.147483648E+9) {
      if (cv >= -2.147483648E+9) {
        temp_cost = static_cast<int32_T>(cv);
      } else {
        temp_cost = MIN_int32_T;
      }
    } else if (cv >= 2.147483648E+9) {
      temp_cost = MAX_int32_T;
    } else {
      temp_cost = 0;
    }

    //  Compare against the minimum cost available and store the
    //  disparity value.
    if (min_cost[kk + 284 * colIdx] > static_cast<real_T>(temp_cost)) {
      min_cost[kk + 284 * colIdx] = static_cast<real_T>(temp_cost);
      out_disp[kk + 284 * colIdx] = fabs(static_cast<real_T>(d) + -16.0) + 8.0;
    }
  }
}

void stereoDisparity(const uint8_T img0[581632], const uint8_T img1[581632],
                     real_T out_disp[145408])
{
  real_T (*gpu_out_disp)[145408];
  real_T (*gpu_min_cost)[145408];
  uint8_T (*gpu_img1)[581632];
  uint8_T (*gpu_img0)[581632];
  int32_T (*gpu_diff_img)[158400];
  real_T (*gpu_cost_v)[153600];
  real_T (*gpu_cost)[145408];
  boolean_T img1_dirtyOnCpu;
  boolean_T img0_dirtyOnCpu;
  cudaMalloc(&gpu_min_cost, 1163264ULL);
  cudaMalloc(&gpu_out_disp, 1163264ULL);
  cudaMalloc(&gpu_cost, 1163264ULL);
  cudaMalloc(&gpu_cost_v, 1228800ULL);
  cudaMalloc(&gpu_diff_img, 633600ULL);
  cudaMalloc(&gpu_img0, 581632ULL);
  cudaMalloc(&gpu_img1, 581632ULL);
  img1_dirtyOnCpu = true;
  img0_dirtyOnCpu = true;

  //  Modified Algorithm for Stereo Disparity Block Matching
  //  In this implementation, instead of finding shifted image, indices are
  //  mapped accordingly to save memory and some processing. RGBA column major
  //  packed data is used as input for compatibility with CUDA intrinsics.
  //  Convolution is performed using separable filters (horizontal and then
  //  vertical).
  //    Copyright 2017-2019 The MathWorks, Inc.
  //  GPU code generation pragma
  //  Stereo Disparity Parameters
  //  |WIN_RAD| is the radius of the window to be operated. |min_disparity| is
  //  the minimum disparity level the search continues for. |max_disparity| is
  //  the maximum disparity level the search continues for.
  //  Image Dimensions for Loop Control
  //  The number of channels packed are 4 (RGBA) so as nChannels are 4.
  //  Store the Raw Differences
  //  Store the minimum cost
  //  Store the final disparity
  stereoDisparity_kernel1<<<dim3(284U, 1U, 1U), dim3(512U, 1U, 1U)>>>
    (*gpu_out_disp, *gpu_min_cost);

  //  Filters for Aggregating the Differences
  //  |filter_h| is the horizontal filter used in separable convolution.
  //  |filter_v| is the vertical filter used in separable convolution which
  //  operates on the output of the row convolution.
  // if isequal(class(flag), 'int32')
  //     Diff = int32(0);
  // elseif isequal(class(flag),'int16')
  //     Diff = int16(0);
  // else
  //     Diff = int8(0);
  // end
  //  Main Loop that runs for all the disparity levels. This loop is
  //  expected to run on CPU.
  for (int32_T d = 0; d < 17; d++) {
    //  Find the difference matrix for the current disparity level. Expect
    //  this to generate a Kernel function.
    if (img1_dirtyOnCpu) {
      cudaMemcpy(gpu_img1, (void *)&img1[0], 581632ULL, cudaMemcpyHostToDevice);
      img1_dirtyOnCpu = false;
    }

    if (img0_dirtyOnCpu) {
      cudaMemcpy(gpu_img0, (void *)&img0[0], 581632ULL, cudaMemcpyHostToDevice);
      img0_dirtyOnCpu = false;
    }

    stereoDisparity_kernel2<<<dim3(310U, 1U, 1U), dim3(512U, 1U, 1U)>>>
      (*gpu_img1, *gpu_img0, d, *gpu_diff_img);

    //  Aggregating the differences using separable convolution. Expect this
    //  to generate two kernels using shared memory.The first kernel is the
    //  convolution with the horizontal kernel and second kernel operates on
    //  its output the column wise convolution.
    stereoDisparity_kernel3<<<dim3(10U, 16U, 1U), dim3(32U, 32U, 1U)>>>
      (*gpu_diff_img, *gpu_cost_v);
    stereoDisparity_kernel4<<<dim3(9U, 16U, 1U), dim3(32U, 32U, 1U)>>>
      (*gpu_cost_v, *gpu_cost);

    //  This part updates the min_cost matrix with by comparing the values
    //  with current disparity level.
    stereoDisparity_kernel5<<<dim3(284U, 1U, 1U), dim3(512U, 1U, 1U)>>>(d,
      *gpu_cost, *gpu_out_disp, *gpu_min_cost);
  }

  cudaMemcpy(&out_disp[0], gpu_out_disp, 1163264ULL, cudaMemcpyDeviceToHost);
  cudaFree(*gpu_img1);
  cudaFree(*gpu_img0);
  cudaFree(*gpu_diff_img);
  cudaFree(*gpu_cost_v);
  cudaFree(*gpu_cost);
  cudaFree(*gpu_out_disp);
  cudaFree(*gpu_min_cost);
}

// End of code generation (stereoDisparity.cu)
