%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Dose Response Curve Fitter
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function sse = dose_response(A,x_val,y_val)
n = A(1);
K = A(2);
sse = sum((y_val - (y_val(1) + ((max(y_val) - y_val(1)) .* (x_val.^n ./ (K^n + x_val.^n))))).^2);
