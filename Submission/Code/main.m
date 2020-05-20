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
    run_regression(startDate, endDate, AVWR, risk_free_data, excess_return_data, market_data, monthly_data, liquidity_data, factorIndex);

% Plots the results of the regression.
plot_result(t_lambda, lambda, alpha, beta, gamma, covariance, excess_returns, dates);
plot_gammas(dates, gamma);
plot_betas(beta);


%% PART B
% For part B we consider the same dates
startDate = max(table2array(liquidity_data(1,1)),max(table2array(monthly_data(1,1)),table2array(liquidity_data(min(find(liquidity_data.Traded_liquidity_factor ~= -99)),1))));
endDate = 200808;

% But now we want to observe the effect of the three liquidity factors
factorIndex = 1:3;

% Runs the regression for the period specified by the start and end date,
% for the factor specified with the indices.
[t_lambda, lambda, alpha, beta, gamma, covariance, dates, excess_returns] = ...
    run_regression(startDate, endDate, AVWR, risk_free_data, excess_return_data, market_data, monthly_data, liquidity_data, factorIndex);

% Plots the results of the regression.
plot_result(t_lambda, lambda, alpha, beta, gamma, covariance, excess_returns, dates);
plot_gammas(dates, gamma);
plot_betas(beta);
    
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
    run_regression(startDate, endDate, AVWR, risk_free_data, excess_return_data, market_data, monthly_data, liquidity_data, factorIndex);

% Plot the results of the regression
plot_result(t_lambda, lambda, alpha, beta, gamma, covariance, excess_returns, dates);
plot_gammas(dates, gamma);
plot_betas(beta);

%% EXTRA 1968-2018
% For our own interest, we also considered the entire period available,
% starting with the earliest date available and ending with the last
% available date. 
startDate = max(table2array(liquidity_data(1,1)),max(table2array(monthly_data(1,1)),table2array(liquidity_data(min(find(liquidity_data.Traded_liquidity_factor ~= -99)),1))));
endDate = min(min(max(table2array(liquidity_data(:,1))),max(table2array(monthly_data(:,1)))),max(table2array(market_data(:,1))));

% We considered all factors and ran the regression
factorIndex = 1:3;
[t_lambda, lambda, alpha, beta, gamma, covariance, dates, excess_returns] = ...
    run_regression(startDate, endDate, AVWR, risk_free_data, excess_return_data, market_data, monthly_data, liquidity_data, factorIndex);

% And plotted the results
plot_result(t_lambda, lambda, alpha, beta, gamma, covariance, excess_returns, dates);
plot_gammas(dates, gamma);
plot_betas(beta);
