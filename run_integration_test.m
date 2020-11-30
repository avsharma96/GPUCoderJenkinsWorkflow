%% Run Integration Test in MATLAB
load imgVariables.mat

%% Create configuration object of class 'coder.MexCodeConfig'.
cfg = coder.gpuConfig('mex');
cfg.GpuConfig.CompilerFlags = '--fmad=false';
cfg.FilePartitionMethod = 'SingleFile';
cfg.GenerateReport = true;
cfg.ReportPotentialDifferences = false;

%% Invoke GPU Coder.
codegen -config cfg -args {imgRGB0, imgRGB1} stereoDisparity;

%% Run the unit tests using the generated MEX file
coder.runTest('TestStereoDisparity', 'stereoDisparity');