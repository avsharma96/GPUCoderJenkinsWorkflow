%% Modified Algorithm for Stereo Disparity Block Matching
% In this implementation, instead of finding shifted image, indices are 
% mapped accordingly to save memory and some processing. RGBA column major 
% packed data is used as input for compatibility with CUDA intrinsics. 
% Convolution is performed using separable filters (horizontal and then 
% vertical).

function [out_disp] = stereoDisparity(img0,img1) %#codegen

%   Copyright 2017-2019 The MathWorks, Inc.

% GPU code generation pragma
coder.gpu.kernelfun;

%% Stereo Disparity Parameters
% |WIN_RAD| is the radius of the window to be operated. |min_disparity| is 
% the minimum disparity level the search continues for. |max_disparity| is 
% the maximum disparity level the search continues for.
WIN_RAD = 8;
min_disparity = -16;
max_disparity = 0;

%% Image Dimensions for Loop Control
% The number of channels packed are 4 (RGBA) so as nChannels are 4.
[imgHeight,imgWidth]=size(img0);
nChannels = 4;
imgHeight = imgHeight/nChannels;

flag = subtractAbs(5,3);
precisionType = class(flag);
%% Store the Raw Differences
diff_img = zeros([imgHeight+2*WIN_RAD,imgWidth+2*WIN_RAD]);
% Store the minimum cost
min_cost = zeros([imgHeight,imgWidth]);
min_cost(:,:) = 99999999;

% Store the final disparity
out_disp = zeros([imgHeight,imgWidth]);

%% Filters for Aggregating the Differences
% |filter_h| is the horizontal filter used in separable convolution.
% |filter_v| is the vertical filter used in separable convolution which
% operates on the output of the row convolution.
filt_h = ones([1 17]);
filt_v = ones([17 1]);

% Main Loop that runs for all the disparity levels. This loop is
% expected to run on CPU.
for d=min_disparity:max_disparity
    
    % Find the difference matrix for the current disparity level. Expect
    % this to generate a Kernel function.
    coder.gpu.kernel;
    for colIdx=1:imgWidth+2*WIN_RAD
        coder.gpu.kernel;
        for rowIdx=1:imgHeight+2*WIN_RAD
            % Row index calculation.
            ind_h = rowIdx - WIN_RAD;
            
            % Column indices calculation for left image.
            ind_w1 = colIdx - WIN_RAD;
            
            % Row indices calculation for right image.
            ind_w2 = colIdx + d - WIN_RAD;
            
            % Border clamping for row Indices.
            if ind_h <= 0
                ind_h = 1;
            end
            if ind_h > imgHeight
                ind_h = imgHeight;
            end
            
            % Border clamping for column indices for left image.
            if ind_w1 <= 0
                ind_w1 = 1;
            end
            if ind_w1 > imgWidth
                ind_w1 = imgWidth;
            end
            
            % Border clamping for column indices for right image.
            if ind_w2 <= 0
                ind_w2 = 1;
            end
            if ind_w2 > imgWidth
                ind_w2 = imgWidth;
            end
            
            % In this step, Sum of absolute Differences is performed
            % across tour channels.
            tDiff = cast(0,precisionType);
            for chIdx = 1:nChannels
                tDiff = tDiff + subtractAbs(img0((ind_h-1)*(nChannels)+chIdx,ind_w1), img1((ind_h-1)*(nChannels)+chIdx,ind_w2));
            end
            
            % Store the SAD cost into a matrix.
            diff_img(rowIdx,colIdx) = tDiff;
        end
    end
    
    % Aggregating the differences using separable convolution. Expect this
    % to generate two kernels using shared memory.The first kernel is the 
    % convolution with the horizontal kernel and second kernel operates on 
    % its output the column wise convolution.
    cost_v = conv2(diff_img,filt_h,'valid');
    cost = conv2(cost_v,filt_v,'valid');
    
    % This part updates the min_cost matrix with by comparing the values
    % with current disparity level.
    for ll=1:imgWidth
        for kk=1:imgHeight
            % load the cost
            %temp_cost = int32(cost(kk,ll));
            temp_cost = cast(cost(kk,ll), precisionType);
            % Compare against the minimum cost available and store the
            % disparity value.
            if min_cost(kk,ll) > temp_cost
                min_cost(kk,ll) = temp_cost;
                out_disp(kk,ll) = abs(d) + 8;
            end
            
        end
    end
    
end
end
