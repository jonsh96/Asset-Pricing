function [t_lambda, lambda, alpha, beta, gamma, covariance, dates, excess_returns] ...
       = runRegression(startDate, endDate, data, risk_free_data, excess_return_data, market_data, monthly_data, liquidity_data, factorIndex)
    % Data can be AVWR or something else...

    % Matching the indices to the tables
    [startIndex, endIndex] = indexTables(startDate, endDate, market_data, monthly_data, liquidity_data);
    
    % Defining the returns, factors, risk free, excess market returns, excess
    % returns and dates for the first part
    returns = table2array(data(startIndex(1):endIndex(1),2:end));
    factors = table2array(liquidity_data(startIndex(2):endIndex(2),2:end));
    risk_free = risk_free_data(startIndex(3):endIndex(3),1);
    excess_market_returns = table2array(excess_return_data(startIndex(3):endIndex(3),1:end));
    excess_returns = returns-risk_free;
    dates = table2array(monthly_data(startIndex(3):endIndex(3),1));
    
    fprintf("Correlation between factors 1 and 2: %.4f\n", corr(factors(:,1),factors(:,2)))
    fprintf("Correlation between factors 2 and 3: %.4f\n", corr(factors(:,2),factors(:,3)))
    fprintf("Correlation between factors 1 and 3: %.4f\n", corr(factors(:,1),factors(:,3)))
    
    if factorIndex == 0
        [t_lambda, lambda, alpha, beta, gamma, covariance] = Fama_MacBeth(excess_returns, [excess_market_returns]);
    else
        [t_lambda, lambda, alpha, beta, gamma, covariance] = Fama_MacBeth(excess_returns, [excess_market_returns factors(:,factorIndex)]);
    end
end
