%% 3. Testing the Liquidity Factor for the Cross-Section of Stock Returns
% Start the data processing 
data_processing     

% Now there are three large tables
% - liquidity_data 
% - excess_return_data
% - risk_free_data
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

%% PART A
% The start date is determined as the most recent date which is available in all
% datatables, excluding the missing data in our liquidity data, i.e. -99
startDate = max(table2array(liquidity_data(1,1)),max(table2array(monthly_data(1,1)),table2array(liquidity_data(min(find(liquidity_data.Traded_liquidity_factor ~= -99)),1))));
endDate = 200808;

% The factor indices provide the option of running the regressions for 
% only one factor at a time, i.e. {1},{2},{3}, two factors at a time, i.e.
% {[1,2],[2,3],[1,3]}, all three {[1,2,3]} or none of them {0}. In all
% cases, excess return is also considered a factor.

% In this case we are only interested in CAPM so we don't include any of
% the liquidity factors.
factorIndex = 0; 

% Runs the regression for the period specified by the start and end date,
% for the factor specified with the indices.
[t_lambda, lambda, alpha, beta, gamma, covariance, dates, excess_returns] = ...
    runRegression(startDate, endDate, AVWR, risk_free_data, excess_return_data, market_data, monthly_data, liquidity_data, factorIndex);

% Plots the results of the regression.
plotResult(t_lambda, lambda, alpha, beta, gamma, covariance, excess_returns, dates);
plotGammas(dates, gamma);
plotBetas(beta);


%% PART B
% For part B we consider the same dates
startDate = max(table2array(liquidity_data(1,1)),max(table2array(monthly_data(1,1)),table2array(liquidity_data(min(find(liquidity_data.Traded_liquidity_factor ~= -99)),1))));
endDate = 200808;

% But now we want to observe the effect of the three liquidity factors
factorIndex = 1:3;

% Runs the regression for the period specified by the start and end date,
% for the factor specified with the indices.
[t_lambda, lambda, alpha, beta, gamma, covariance, dates, excess_returns] = ...
    runRegression(startDate, endDate, AVWR, risk_free_data, excess_return_data, market_data, monthly_data, liquidity_data, factorIndex);

% Plots the results of the regression.
plotResult(t_lambda, lambda, alpha, beta, gamma, covariance, excess_returns, dates);
plotGammas(dates, gamma);
plotBetas(beta);
    
%% PART C
% For part C we consider the period from September 2009 until the latest
% available date (which has to be common in all of our datatables). For the
% liquidity data, we opted for a newer file than the one suggested in the
% project description, i.e. we used 1962-2018 instead of 1962-2013 as
% suggested. We felt that this would give a more accurate result. 
startDate = 200809;
endDate = min(min(max(table2array(liquidity_data(:,1))),max(table2array(monthly_data(:,1)))),max(table2array(market_data(:,1))));

% Again, we consider all of the liquidity factors and run the regression
factorIndex = 1:3;
[t_lambda, lambda, alpha, beta, gamma, covariance, dates, excess_returns] = ...
    runRegression(startDate, endDate, AVWR, risk_free_data, excess_return_data, market_data, monthly_data, liquidity_data, factorIndex);

% Plot the results of the regression
plotResult(t_lambda, lambda, alpha, beta, gamma, covariance, excess_returns, dates);
plotGammas(dates, gamma);
plotBetas(beta);

%% EXTRA 1968-2018
% For our own interest, we also considered the entire period available,
% starting with the earliest date available and ending with the last
% available date. 
startDate = max(table2array(liquidity_data(1,1)),max(table2array(monthly_data(1,1)),table2array(liquidity_data(min(find(liquidity_data.Traded_liquidity_factor ~= -99)),1))));
endDate = min(min(max(table2array(liquidity_data(:,1))),max(table2array(monthly_data(:,1)))),max(table2array(market_data(:,1))));

% We considered all factors and ran the regression
factorIndex = 1:3;
[t_lambda, lambda, alpha, beta, gamma, covariance, dates, excess_returns] = ...
    runRegression(startDate, endDate, AVWR, risk_free_data, excess_return_data, market_data, monthly_data, liquidity_data, factorIndex);

% And plotted the results
plotResult(t_lambda, lambda, alpha, beta, gamma, covariance, excess_returns, dates);
plotGammas(dates, gamma);
plotBetas(beta);

% DELETING THE FOLLOWING UNLESS SOMEONE SAYS OTHERWISE
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
