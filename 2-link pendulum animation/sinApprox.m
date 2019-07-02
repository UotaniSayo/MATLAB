function [x] = sinApprox(t)
%approximate sinusoid by Taylor series
%from -pi to pi, high accuracy is achieved with first 5 items
    
    x = t - t^3/6 + t^5/120 - t^7/5040 + t^9/362880;

end

