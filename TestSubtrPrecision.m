classdef TestSubtrPrecision < matlab.unittest.TestCase
    
    methods ( Test )
        
        function verifyTypeMatch( testCase )
            x = 1;
            y = 2;
            z = subtrPrecision(x, y);
            op1= isa(z , 'int32');
            op2 = isa(z , 'int16');
            op3 = isa(z , 'int8');
            testCase.verifyTrue( op1 | op2 | op3);
        end
        
        function subWitheps( testCase )
            x = eps(5);
            y = 2;
            z = subtrPrecision(x,y);
            if isa( z , 'int32' ) == true
                t = int32(eps(5)) - int32(2);
            elseif isa ( z , 'int16' ) == true
                 t = int16(eps(5)) - int16(2);
            elseif isa ( z , 'int8' ) == true
                 t = int8(eps(5)) - int8(2);     
            else
                t = 0;
            end
            testCase.verifyEqual(z , abs(t));
        end
    end
end