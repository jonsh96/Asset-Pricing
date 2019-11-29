%% 3. Testing the Liquidity Factor for the Cross-Section of Stock Returns
Data_processing     

% Now there are three large tables
% - liquidity_data 
% - monthly_data
% - market_data
% 
% For parts A and B we look at all the data up until August-2008 so
% monthly_data is broken down into the following tables:
% - AVWR = Average Value Weighted Returns               -- Monthly
% - AEWR = Average Equal Weighted Returns               -- Monthly
% - NFP = Number of Firms in Portfolio                  -- Monthly
% - AVS = Average Firm Size                             -- Monthly
% - EQAPR = Equally-Weighted Average of Prior Returns   -- Monthly
% - VWAPR = Value-Weighted Average of Prior Returns     -- Monthly
%
% Only AVWR is used for this part but the code should run for all the others

% Making sure the data ranges from the same dates and where removing the
% missing data from the liquidity_data (roughly 1962 - 1968)
% startDate = max(table2array(liquidity_data(1,1)),max(table2array(monthly_data(1,1)),table2array(liquidity_data(min(find(liquidity_data.Traded_liquidity_factor ~= -99)),1))));
% endDate = 200808;
% 
% % Matching the indices to the tables
% [startIndex, endIndex] = indexTables(startDate, endDate, market_data, monthly_data, liquidity_data);
%
%% PART A
startDate = max(table2array(liquidity_data(1,1)),max(table2array(monthly_data(1,1)),table2array(liquidity_data(min(find(liquidity_data.Traded_liquidity_factor ~= -99)),1))));
endDate = 200808;

factorIndex = 0; % WHICH FACTORS YOU WANT, IF NONE TYPE factorIndex = 0;

[t_lambda, lambda, alpha, beta, gamma, covariance, dates, excess_returns] = ...
    runRegression(startDate, endDate, AVWR, risk_free_data, excess_return_data, market_data, monthly_data, liquidity_data, factorIndex);

% plotResult(t_lambda, lambda, alpha, beta, gamma, covariance, excess_returns, dates);
% plotGammas(dates, gamma);
% plotBetas(beta);

%% PART B
startDate = max(table2array(liquidity_data(1,1)),max(table2array(monthly_data(1,1)),table2array(liquidity_data(min(find(liquidity_data.Traded_liquidity_factor ~= -99)),1))));
endDate = 200808;
factorIndex = 1:3; % WHICH FACTORS YOU WANT, IF NONE TYPE factorIndex = 0;

[t_lambda, lambda, alpha, beta, gamma, covariance, dates, excess_returns] = ...
    runRegression(startDate, endDate, AVWR, risk_free_data, excess_return_data, market_data, monthly_data, liquidity_data, factorIndex);

% plotResult(t_lambda, lambda, alpha, beta, gamma, covariance, excess_returns, dates);
% plotGammas(dates, gamma);
% plotBetas(beta);
    
%% PART C
startDate = 200809;
endDate = min(min(max(table2array(liquidity_data(:,1))),max(table2array(monthly_data(:,1)))),max(table2array(market_data(:,1))));
factorIndex = [1 1 1 1];
[t_lambda, lambda, alpha, beta, gamma, covariance, dates, excess_returns] = ...
    FamaMacBeth2(startDate, endDate, AVWR, risk_free_data, excess_return_data, market_data, monthly_data, liquidity_data, factorIndex);

plotResult(t_lambda, lambda, alpha, beta, gamma, covariance, excess_returns, dates);
plotGammas(dates, gamma);
plotBetas(beta);

% %%
% % %% 
% % % Defining the returns, factors, risk free, excess market returns, excess
% % % returns and dates for the first part
% % returns = table2array(AVWR(startIndex(1):endIndex(1),2:end));
% % factors = table2array(liquidity_data(startIndex(2):endIndex(2),2:end-1));
% % risk_free = table2array(risk_free_data(startIndex(3):endIndex(3),1:end));
% % excess_market_returns = table2array(excess_return_data(startIndex(3):endIndex(3),1:end));
% % excess_returns = returns-risk_free;
% % dates = table2array(monthly_data(startIndex(3):endIndex(3),1));
% % 
% % % Running the Fama MacBeth regression
% % [t_lambda, lambda, alpha, beta, gamma, covariance] = Fama_MacBeth(excess_returns, [excess_market_returns factors]);
% 
% % IS THIS USED??? ASK NEEL
% % [lambda, tlambda, R2adj, RMSE, alpha, talpha, beta, tbeta, GRS, pval, vcv] = XSReg(excess_returns, [factors excess_market_returns])
% 
% % PRED VS ACTUAL RETURNS
% % predicted_returns = (beta*gamma)';
% % actual_returns = excess_returns;
% % residual = predicted_returns - actual_returns;
% % xDates = dateConversion(dates);
% % plot(xDates, residual, '.')
% % datetick('x','yyyy-mm')
% % xlim([xDates(1) xDates(end)])
% % ylabel('Residual')
% % grid on
% 
% %% PLOT GAMMAS 
% plot(xDates, gamma(1,:)')
% datetick('x','yyyy-mm')
% xlim([xDates(1) xDates(end)])
% ylabel('Residual')
% grid on
% 
% %%
% % plot(xDates, gamma(2,:)')
% % datetick('x','yyyy-mm')
% % xlim([xDates(1) xDates(end)])
% % ylabel('Residual')
% % grid on
% % 
% % 
% % plot(xDates, gamma(3,:)')
% % datetick('x','yyyy-mm')
% % xlim([xDates(1) xDates(end)])
% % ylabel('Residual')
% % grid on
% % 
% % 
% % plot(xDates, gamma(4,:)')
% % datetick('x','yyyy-mm')
% % xlim([xDates(1) xDates(end)])
% % ylabel('Residual')
% % grid on
% % 
% % 
% % plot(xDates, gamma(5,:)')
% % datetick('x','yyyy-mm')
% % xlim([xDates(1) xDates(end)])
% % ylabel('Residual')
% % grid on
% 
% 
% %% PART C
% % Making sure the data ranges from the same dates and where removing the
% % missing data from the liquidity_data (roughly 1962 - 1968)
% 
% startDate = 200809
% endDate = min(min(max(table2array(liquidity_data(:,1))),max(table2array(monthly_data(:,1)))),max(table2array(market_data(:,1))));
% 
% 
% % Finding the relevant indices to match the start and end dates in each table
% startIndex(1) = min(find(table2array(monthly_data(:,1)) == startDate));
% endIndex(1) = min(find(table2array(monthly_data(:,1)) == endDate));
% 
% startIndex(2) = min(find(table2array(liquidity_data(:,1)) == startDate));
% endIndex(2)= min(find(table2array(liquidity_data(:,1)) == endDate));
% 
% startIndex(3) = min(find(table2array(market_data(:,1)) == startDate));
% endIndex(3)= min(find(table2array(market_data(:,1)) == endDate));
% 
% % Defining the returns, factors, risk free, excess market returns, excess
% % returns and dates for the first part
% returns = table2array(AVWR(startIndex(1):endIndex(1),2:end));
% factors = table2array(liquidity_data(startIndex(2):endIndex(2),2:end-1));
% risk_free = table2array(risk_free_data(startIndex(3):endIndex(3),1:end));
% excess_market_returns = table2array(excess_return_data(startIndex(3):endIndex(3),1:end));
% excess_returns=returns-risk_free;
% dates = table2array(monthly_data(startIndex(3):endIndex(3),1));
% 
% % [tlambda, lambda, alpha, beta, covariance] = Fama_MacBeth(returns,factors);
% 
% % Running the Fama MacBeth regression
% [t_lambda, lambda, alpha, beta, gamma, covariance] = Fama_MacBeth(excess_returns, [excess_market_returns factors]);
% 
% % PRED VS ACTUAL RETURNS
% predicted_returns = (beta*gamma)';
% actual_returns = excess_returns;
% residual = predicted_returns - actual_returns;
% xDates = dateConversion(dates);
% plot(xDates, residual,'.')
% datetick('x','yyyy-mm')
% xlim([xDates(1) xDates(end)])
% ylabel('Residual')
% grid on
% 
% 
% % IS THIS USED? ASK NEEL
% %[lambda, tlambda, R2adj, RMSE, alpha, talpha, beta, tbeta, GRS, pval, vcv] = XSReg(excess_returns, excess_market_returns)
% %[lambda, tlambda, R2adj, RMSE, alpha, talpha, beta, tbeta, GRS, pval, vcv] = XSReg(excess_returns, factors)
% %[lambda, tlambda, R2adj, RMSE, alpha, talpha, beta, tbeta, GRS, pval, vcv] = XSReg(excess_returns, [factors excess_markets_returns])
% % dateConversion(200812)
% 
