%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Dose Response Curve Fitter
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function sse = inverse_response2(A,x_val,y_val)
n = A(1);
K = A(2);
sse = sum((y_val - (y_val(1) - ((y_val(1) - min(y_val)) .* (x_val.^n ./ (K^n + x_val.^n))))).^2);