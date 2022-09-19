clear;

% Parameters definition:
L = 10000; % number of experiments
c = [1 2 3 4]'; % channel impulse response coefficients
M = size(c,1); % filter order
N = 1000; % number of iterations
c2 = [10 1 2 3]'; % channel change

% Error curves matrices:
e_LMS = zeros(N, L);
e_epsLMS = zeros(N, L);
e_RLS = zeros(N, L);

% Experiments:
for j = 1:L
    u = randn(1,N+M); % white input data
    %u(1,:) = pinknoise(N+M); % pink input data

    e_LMS(:,j) = LMS_errorCurve(c, u, N, 0.01, c2);
    e_epsLMS(:,j) = epsLMS_errorCurve(c, u, N, 0.2, 0.001, c2);
    e_RLS(:,j) = RLS_errorCurve(c, u, N, 0.995, 0.001, c2);
end

% Learning curves:
J_LMS_dB = 10*log10((1/L)*sum(e_LMS,2));
J_epsLMS_dB = 10*log10((1/L)*sum(e_epsLMS,2));
J_RLS_dB = 10*log10((1/L)*sum(e_RLS,2));

% Plotting the learning curves:
figure(1);
hold on
plot(J_LMS_dB)
plot(J_epsLMS_dB)
plot(J_RLS_dB)
grid on

xlabel('iteration')
ylabel('MSE (dB)')
legend('LMS', 'n-LMS', 'RLS')

%%

clear;

% Parameters definition:
L = 1000; % number of experiments
c = [1 2 3 4]'; % channel impulse response coefficients
M = size(c,1); % filter order
N = 300; % number of iterations

% Error curves matrices:
e_RLS1 = zeros(N, L);
e_RLS2 = zeros(N, L);
e_RLS3 = zeros(N, L);
e_RLS4 = zeros(N, L);

% Experiments:
for j = 1:L
    u = randn(1,N+M); % white input data
    %u(1,:) = pinknoise(N+M); % pink input data

    e_RLS1(:,j) = RLS_errorCurve(c, u, N, 1);
    e_RLS2(:,j) = RLS_errorCurve(c, u, N, 0.9);
    e_RLS3(:,j) = RLS_errorCurve(c, u, N, 0.6);
    e_RLS4(:,j) = RLS_errorCurve(c, u, N, 0.3);
end

% Learning curves:
J_RLS1_dB = 10*log10((1/L)*sum(e_RLS1,2));
J_RLS2_dB = 10*log10((1/L)*sum(e_RLS2,2));
J_RLS3_dB = 10*log10((1/L)*sum(e_RLS3,2));
J_RLS4_dB = 10*log10((1/L)*sum(e_RLS4,2));

% Plotting the learning curves:
figure(1);
hold on
plot(J_RLS1_dB)
plot(J_RLS2_dB)
plot(J_RLS3_dB)
plot(J_RLS4_dB)
grid on

xlabel('iteration')
ylabel('MSE (dB)')
legend('\lambda = 1, \epsilon = 0.001', '\lambda = 0.9, \epsilon = 0.001',...
    '\lambda = 0.6, \epsilon = 0.001', '\lambda = 0.3, \epsilon = 0.001')