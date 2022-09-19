function e = epsLMS_errorCurve(wo1, u, N, mu, eps, wo2)
% Returns learning curve for normalized LMS algorithm
% Inputs:
%   - wo: expected optimal result;
%   - u: measured input sequence;
%   - N: number of iterations;
%   - mu: initial step size;
%   - eps: regularization factor.
    
    if nargin < 6
        wo2 = wo1;
        if nargin < 5
            eps = 0.001;
            if nargin < 4
                mu = 0.2;
            end
        end
    end
    M = size(wo1,1); % filter order
    e = zeros(N,1); % error curve
    w = zeros(size(wo1)); % initial condition
    for i = 0:N-1
        if i < 100
            wo = wo1;
        else
            wo = wo2;
        end
        ui = u(1,i+1:i+M);
        d = ui*wo + sqrt(0.01)*randn(1,1);
        e(i+1) = d - ui*w; % indexed with (i+1) as matlab indexing starts at 1
        step = mu/(eps + ui*ui');
        w = w + step*ui'*e(i+1);
    end
    e = abs(e).^2;
end

