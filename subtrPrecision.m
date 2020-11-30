function out = subtrPrecision(a,b)
    out = abs(int8(a) - int8(b)); %works best with int32 precision 
end