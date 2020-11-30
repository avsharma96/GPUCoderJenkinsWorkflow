function out = subtrPrecision(a,b)
    out = abs(int32(a) - int32(b)); %works best with int32 precision 
end