classdef TestStereoDisparity < matlab.unittest.TestCase

    methods ( Test )
        
        function imgDiff_WithinTolerance( testCase )
            load imgVariables.mat
            load expectedOutput.mat
            tolerance = 1e-03;
            outp = stereoDisparity(imgRGB0,imgRGB1);
            
            diff = outp - out_disp;
            error = sum(sum(diff.^2));
            mse = error/(length(out_disp(:,1))*length(out_disp));
            % Check if the mse exceeds the absolute tolerance
            testCase.verifyEqual(mse, 0,'AbsTol',tolerance);

        end
    end
end