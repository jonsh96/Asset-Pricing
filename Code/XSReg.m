% XSReg: Performs a two-stage cross-sectional regression a la Fama/MacBeth
% but provides standard errors that account for errors-in-variables,
% heteroskedasticity and autocorrelation in error terms.
%
% Author:        Julian Thimme (Goethe University Frankfurt)
% First version: 2018/07/25
% This version:  2018/10/12
%
% Necessary programs:
% display_results   prints results to screen and generates plot
% longvar           estimates long-run covariance matrix
% kernelest         computes Bartlett or Parzen weights
% optbandw          Newey and Wests's method of optimal bandwidth selection
% The latter three programs are taken from Kostas Kyriakoulis' GMM package
% at https://personalpages.manchester.ac.uk/staff/Alastair.Hall/GMMGUI.html
%
% This program is a corrected and generalized version of a program
% provided in Kevin Sheppard's MATLAB course, see the script, Section 22.2.
% The script can be downloaded at https://www.kevinsheppard.com/MFE_MATLAB
%
% SYNTAX: 
%[lambda, tlambda, R2adj, RMSE, alpha, talpha, beta, tbeta, GRS, pval, vcv] 
% = XSReg(returns, factors, constant, print, nw_lags, nw_center, nw_method)
%
% INPUT
% returns       A matrix with test asset return time series in columns 
% factors       A matrix with factor time series in columns
%
% OPTIONAL INPUT
% constant      0 <-- cross-sectional regression without constant 
%               1 (default) <-- cross-sectional regression with constant
% print         0 <-- results are not printed to screen
%               1 (default) <-- results are printed to screen
%               2 <-- results are printed and a plot is created
% nw_lags       The bandwidth used in the HACC estimates. Must be a
%               non-negative integer (or zero, in the case of serially 
%               uncorrelated moments). 
%               If nw_lags=[] (default), the program will automatically 
%               calculate the optimal bandwidth, using Newey and Wests's 
%               method of bandwidth selection.              
% nw_center     0 <-- errors are not demeaned before covariance estimation
%               1 (default) <-- errors are demeaned 
% nw_method     There are three methods available for calculating the
%               covariance matrix. Set this input equal to:
%               'HACC_B' <-- for HACC with Bartlett kernel (default)
%               'HACC_P' <-- for HACC with Parzen kernel
%               'SerUnc' <-- for Serially uncorrelated errors
%
% OUTPUT
% lambda        Point estimates of the market prices of risk
% tlambda       t-statistics of lambda
% R2adj         Cross-sectional adjusted R2
% RMSE          Root-mean-squared pricing error
% alpha         Intercepts from time series regressions
% talpha        t-statistics of alpha
% beta          Slope coefficients from time series regressions
% tbeta         t-statistics of beta
% GRS           Gibbons/Ross/Shanken statistic
% pval          p-value of the GRS statistic
% vcv           Covariance matrix of the parameter estimates

function [lambda, tlambda, R2adj, RMSE, alpha, talpha, beta, tbeta, GRS, pval, vcv] = ...
    XSReg(returns, factors, constant, print, nw_lags, nw_center, nw_method)

% Diagnostics
if nargin < 2; error('Not enough inputs');
elseif nargin == 2; constant=1; print=1; nw_center=1; nw_method='HACC_B'; nw_lags=[];
elseif nargin == 3; print=1; nw_center=1; nw_method='HACC_B'; nw_lags=[];
elseif nargin == 4; nw_lags=[]; nw_center=1; nw_method='HACC_B';
elseif nargin == 5; nw_center=1; nw_method='HACC_B';
elseif nargin == 6; nw_method='HACC_B';
elseif nargin >= 8; error('Too many inputs'); end
[Tf,K]    = size(factors);
[T,N]     = size(returns);
if ~(Tf==T); error('Time series must have the same sizes'); end
if constant~=0; constant=1; end

% Time series regressions
X         = [ones(T,1) factors];
alphaBeta = X\returns;
alpha     = alphaBeta(1,:)';
beta      = alphaBeta(2:end,:)';
if constant == 1; beta = [ones(N,1),beta]; end

% Cross-sectional regression
EReturns  = mean(returns)';
lambda    = beta\EReturns;
miReturns = beta*lambda;

% Moment conditions
epsilon   = returns - X*alphaBeta;
moments1  = kron(epsilon,ones(1,K+1)) .* kron(ones(1,N),X);
u         = bsxfun(@minus,returns,miReturns');
moments2  = u*beta;

% Score covariance
[S, lags] = longvar([moments1 moments2], nw_center, nw_method, nw_lags);

% Jacobian
G         = zeros(N*K+N+K+constant,N*K+N+K+constant);
SigmaX    = X'*X/T;
G(1:N*K+N,1:N*K+N) = kron(eye(N),SigmaX);
G(N*K+N+1:end,N*K+N+1:end) = -beta'*beta;
for i=1:N
    temp  = zeros(K+constant,K+1);
    temp(:,2-constant:end) = -beta(i,:)'*lambda';
    temp(:,1) = zeros(K+constant,1);
    temp(1+constant:end,2:end) = temp(1+constant:end,2:end) + mean(u(:,i))*eye(K);
    G(N*K+N+1:end,(i-1)*(K+1)+1:i*(K+1)) = temp;
end

% Covariance of the parameters
vcv       = G'\S/G/T;

% t-statistics
SE        = sqrt(diag(vcv));
SElambda  = SE(N*K+N+1:end);
tlambda   = lambda./SElambda;
SEalpha   = SE(1:K+1:N*K+N);
talpha    = alpha./SEalpha;
SEbeta    = SE(1:N*K+N); 
SEbeta(1:K+1:N*K+N) = [];
SEbeta    = reshape(SEbeta,K,N)';
beta      = beta(:,1+constant:end);
tbeta     = beta./SEbeta;

% Model performance
GRS       = alpha'*pinv(vcv(1:K+1:N*K+N,1:K+1:N*K+N))*alpha;
pval      = 1-chi2cdf(GRS,N-K);
RSS       = norm(mean(u)-mean(mean(u)))^2; % Regression sum of squares.
TSS       = norm(EReturns-mean(EReturns))^2 ;
R2        = 1-RSS/TSS;
R2adj     = 1-((N-1)/(N-K))*RSS/TSS; % adjusted
RMSE      = sqrt(mean((EReturns-miReturns).^2));

display_results

end
