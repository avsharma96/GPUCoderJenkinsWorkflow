function out = subtrPrecision(a,b)
    out = abs(int16(a) - int16(b)); %works best with int32 precision 
end