function [t_lambda, lambda, alpha, beta, covariance] = Fama_MacBeth2(returns, factors)

    [Tf,K]      = size(factors);
    [T,N]       = size(returns);
    X           = [ones(T,1) factors];
    alphaBeta   =((X.'*X)\(X.'*returns))'; %= X\returns;
    alpha       = alphaBeta(1,:)';
    beta        = alphaBeta(2:end,:)';
    beta        = [ones(N,1),beta]';
    
    % alternate =((X.'*X)\(X.'*excess_returns))'
    % we can use this for CAPM regression since we just run a linear
    % regression(ts regression)
    %
    % Cross sectional regression is the second part of Fama Macbeth
    % Cross-sectional regression
%     EReturns    = mean(returns)';
    covariance  = hac(beta(:,2:end),returns(1,:)) %returns a covariance matrix of our lambdas
    lambda      = beta\returns(1,:)'; 
   
    SE          = sqrt(diag(covariance));    
    t_lambda    = lambda./SE;
    
    %EReturns computes the actual expected returns of the porfolio
    %miReturns computes the predicted expected returns of the portfolio
    %lambda are Point estimates of the market prices of risk
    EReturns    = mean(returns(1,:))';
    lambda      = beta\EReturns; 
    miReturns   = beta*lambda;
    
    %plot_Fama_MacBeth(miReturns, EReturns);
end