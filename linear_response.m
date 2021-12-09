%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Linear Response Curve Fitter
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function sse = dose_response(A,x_val,y_val)
m = A(1);
c = A(2);
sse = sum((y_val - (m.*x_val + c)).^2/y_val);