% %%
% %PART A
% 
% % Time series regressions
% %first part of fama macbeth
% % alpha: Intercepts from time series regressions our gamma0
% % beta Slope coefficients from time series regressions
% %X is a matrix of the returns of portfolios
% 
% [Tf,K]    = size(excess_market_returns);
% [T,N]     = size(excess_returns);
% X         = [ones(T,1) excess_market_returns];
% alphaBeta = X\excess_returns;
% alpha     = alphaBeta(1,:)';
% beta      = alphaBeta(2:end,:)';
% beta = [ones(N,1),beta]; 
% alternate=((X.'*X)\(X.'*excess_returns))'
% % we can use this for CAPM regression since we just run a linear
% % regression(ts regression)
% %
% %Cross sectional regression is the second part of Fama Macbeth
% % Cross-sectional regression
% 
% %EReturns computes the actual expected returns of the porfolio
% %miReturns computes the predicted expected returns of the portfolio
% %lambda are Point estimates of the market prices of risk
% EReturns  = mean(excess_returns)';
% lambda    = beta\EReturns; 
% miReturns = beta*lambda;
% 
% covariance=hac(beta(:,2),EReturns) %returns a covariance matrix of our lambdas
% 
% SE=sqrt(diag(covariance));
% tlambda=lambda./SE 
% 
% %our tlambda =
% % 
% %     2.3323
% %    -1.3295
% 
% % plot(miReturns,EReturns,'.b')
% % xlabel('Predicted expected returns from Fama MacBeth')
% % ylabel('Actual expected returns')
% % title('Fama MacBeth fit')
% % xlim([0,1])
% %%
% 
% %PART B
% %Now we add the additional factors' betas and test the extended model
% 
% % We consider the factors of Liquidity without the excess_market_return
% 
% % Time series regressions
% %first part of fama macbeth
% % alpha: Intercepts from time series regressions our gamma0
% % beta Slope coefficients from time series regressions
% %X is a matrix of the returns of portfolios
% 
% [Tf,K]    = size(factors);
% [T,N]     = size(excess_returns);
% X         = [ones(T,1) factors];
% alphaBeta = X\excess_returns;
% alpha     = alphaBeta(1,:)';
% beta      = alphaBeta(2:end,:)';
% beta = [ones(N,1),beta]; 
% alternate=((X.'*X)\(X.'*excess_returns))';
% % we can use this for CAPM regression since we just run a linear
% % regression(ts regression)
% %
% %Cross sectional regression is the second part of Fama Macbeth
% % Cross-sectional regression
% 
% %EReturns computes the actual expected returns of the porfolio
% %miReturns computes the predicted expected returns of the portfolio
% %lambda are Point estimates of the market prices of risk
% EReturns  = mean(excess_returns)';
% lambda    = beta\EReturns; 
% miReturns = beta*lambda;
% 
% plot(miReturns,EReturns,'.b')
% xlabel('Predicted expected returns from Fama MacBeth')
% ylabel('Actual expected returns')
% title('Fama MacBeth fit')
% xlim([0,1])
% 
% covariance=hac(beta(:,2:end),EReturns) %returns a covariance matrix of our lambdas
% 
% SE=sqrt(diag(covariance));
% tlambda=lambda./SE 
% 
% %%
% 
% %Now we include Liquidity factors and the excess_market_return
% 
% [Tf,K]    = size([factors excess_market_returns]);
% [T,N]     = size(excess_returns);
% X         = [ones(T,1) [factors excess_market_returns]];
% alphaBeta = X\excess_returns;
% alpha     = alphaBeta(1,:)';
% beta      = alphaBeta(2:end,:)';
% beta = [ones(N,1),beta]; 
% alternate=((X.'*X)\(X.'*excess_returns))';
% % we can use this for CAPM regression since we just run a linear
% % regression(ts regression)
% %
% %Cross sectional regression is the second part of Fama Macbeth
% % Cross-sectional regression
% 
% %EReturns computes the actual expected returns of the porfolio
% %miReturns computes the predicted expected returns of the portfolio
% %lambda are Point estimates of the market prices of risk
% EReturns  = mean(excess_returns)';
% lambda    = beta\EReturns; 
% miReturns = beta*lambda;
% 
% plot(miReturns,EReturns,'.b')
% xlabel('Predicted expected returns from Fama MacBeth')
% ylabel('Actual expected returns')
% title('Fama MacBeth fit')
% xlim([0,1])
% 
% covariance=hac(beta(:,2),EReturns) %returns a covariance matrix of our lambdas
% 
% SE=sqrt(diag(covariance));
% tlambda=lambda./SE 