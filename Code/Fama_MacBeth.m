function [t_lambda, lambda, alpha, beta, gamma, covariance] = Fama_MacBeth(returns, factors)

    [Tf,K]      = size(factors);
    [T,N]       = size(returns);
    X           = [ones(T,1) factors];
    alphaBeta   = X\returns;
    alpha       = alphaBeta(1,:)';
    beta        = alphaBeta(2:end,:)';
    beta        = [ones(N,1),beta];
    
    alternate =((X.'*X)\(X.'*returns))';
    % we can use this for CAPM regression since we just run a linear
    % regression(ts regression)
    %
    % Cross sectional regression is the second part of Fama Macbeth
    % Cross-sectional regression
    EReturns    = mean(returns)';
    covariance  = hac(beta(:,2:end),EReturns) %returns a covariance matrix of our lambdas
    lambda      = beta\mean(returns)'; 
    SE          = sqrt(diag(covariance));    
    t_lambda    = lambda./SE;
    
    %EReturns computes the actual expected returns of the porfolio
    %miReturns computes the predicted expected returns of the portfolio
    %lambda are Point estimates of the market prices of risk
    EReturns    = mean(returns)';
    lambda      = beta\EReturns; 
    miReturns   = beta*lambda;
    gamma       = beta\returns';
    t_gamma     = gamma./SE;
    plot(miReturns, EReturns,'bo');

    [Tf,K]    = size(factors);
    [T,N]     = size(returns);
    
%     % t-statistics
%     SE        = sqrt(diag(covariance));
%     SElambda  = SE(N*K+N+1:end);
%     tlambda   = lambda'./SElambda;
%     SEalpha   = SE(1:K+1:N*K+N);
%     talpha    = alpha./SEalpha;
%     SEbeta    = SE(1:N*K+N); SEbeta(1:K+1:N*K+N) = [];
%     SEbeta    = reshape(SEbeta,K,N)';
%     beta      = beta(:,1+constant:end);
%     tbeta     = beta./SEbeta;
% 
%     % Model performance
%     GRS       = alpha'*pinv(vcv(1:K+1:N*K+N,1:K+1:N*K+N))*alpha;
%     pval      = 1-chi2cdf(GRS,N-K);
%     RSS       = norm(mean(u)-mean(mean(u)))^2; % Regression sum of squares.
%     TSS       = norm(EReturns-mean(EReturns))^2 ;
%     R2        = 1-RSS/TSS;
%     R2adj     = 1-((N-1)/(N-K))*RSS/TSS; % adjusted
%     RMSE      = sqrt(mean((EReturns-miReturns).^2));
%     
%     display_results
end