%% Stereo Disparity
%
% This example shows how to generate a MEX function from a MATLAB(R) 
% function that computes the stereo disparity of two images.

% Copyright 2017-2020 The MathWorks, Inc.

%% Prerequisites
% * CUDA(R) enabled NVIDIA(R) GPU with compute capability 3.2 or higher.
% * NVIDIA CUDA toolkit and driver.
% * Environment variables for the compilers and libraries. For information 
% on the supported versions of the compilers and libraries, see 
% <docid:gpucoder_gs#mw_aa8b0a39-45ea-4295-b244-52d6e6907bff
% Third-Party Products>. For setting up the environment variables, see 
% <docid:gpucoder_gs#mw_453fbbd7-fd08-44a8-9113-a132ed383275
% Environment Variables>.

%% Verify GPU Environment
% To verify that the compilers and libraries necessary for running this example
% are set up correctly, use the <docid:gpucoder_ref#mw_0957d820-192f-400a-8045-0bb746a75278 coder.checkGpuInstall>
% function.
envCfg = coder.gpuEnvConfig('host');
envCfg.BasicCodegen = 1;
envCfg.Quiet = 1;
coder.checkGpuInstall(envCfg);

%% Stereo Disparity Calculation
% The 
% <matlab:edit(fullfile(matlabroot,'examples','gpucoder','main','stereoDisparity.m')) stereoDisparity.m>
% entry-point function takes two images and returns a stereo disparity map computed from the two images.

type stereoDisparity

%% Read Images and Pack Data Into RGBA Packed Column-Major Order
img0 = imread('scene_left.png');
img1 = imread('scene_right.png');

[imgRGB0] = pack_rgbData(img0);
[imgRGB1] = pack_rgbData(img1);

%% Left Image
% 
% <<../scene_left.png>>

%% Right Image
%
% <<../scene_right.png>>
%

%% Generate GPU Code
cfg = coder.gpuConfig('mex');
codegen -config cfg -args {imgRGB0, imgRGB1} stereoDisparity;

%% Run Generated MEX and Show the Output Disparity
out_disp = stereoDisparity_mex(imgRGB0,imgRGB1);
imagesc(out_disp);