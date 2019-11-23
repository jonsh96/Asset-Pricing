%% 3. Testing the Liquidity Factor for the Cross-Section of Stock Returns
Data_processing     

% Now there are two large tables
% - liquidity_data 
% - monthly_data
% 
% For parts A and B we look at all the data up until August-2008 so
% monthly_data is broken down into the following tables:
% - AVWR = Average Value Weighted Returns               -- Monthly
% - AEWR = Average Equal Weighted Returns               -- Monthly
% - NFP = Number of Firms in Portfolio                  -- Monthly
% - AVS = Average Firm Size                             -- Monthly
% - EQAPR = Equally-Weighted Average of Prior Returns   -- Monthly
% - VWAPR = Value-Weighted Average of Prior Returns     -- Monthly

% TODO:
% - Split data into 6 tables [DONE]
% - Create Fama-MacBeth regression
% - Test CAPM
% - Interpret results

% Making sure the data ranges from the same dates

startDate = max(table2array(monthly_data(1,1)),table2array(liquidity_data(min(find(liquidity_data.Traded_liquidity_factor ~= -99)),1)));
endDate = 200808;

startIndex(1) = min(find(table2array(monthly_data(:,1)) == startDate));
endIndex(1) = min(find(table2array(monthly_data(:,1)) == endDate));

startIndex(2) = min(find(table2array(liquidity_data(:,1)) == startDate));
endIndex(2)= min(find(table2array(liquidity_data(:,1)) == endDate));

startIndex(3) = min(find(table2array(market_data(:,1)) == startDate));
endIndex(3)= min(find(table2array(market_data(:,1)) == endDate));

returns = table2array(AVWR(startIndex(1):endIndex(1),2:end));
factors = table2array(liquidity_data(startIndex(2):endIndex(2),2:end));
risk_free = table2array(risk_free_data(startIndex(3):endIndex(3),1:end));
excess_market_returns = table2array(excess_return_data(startIndex(3):endIndex(3),1:end));
excess_returns=returns-risk_free;

[lambda, tlambda, R2adj, RMSE, alpha, talpha, beta, tbeta, GRS, pval, vcv] = XSReg(excess_returns, excess_market_returns)

%% a) Perform the test of the CAPM by running a two-steps Fama-MacBeth regression. 
%     Fully interpret the result and comment upon the validity of the model and its 
%     ability to explain the cross-section of the portfolio returns.



% 
% dateConversion(200812)


function dateNr = dateConversion(dateNumber)
    % Converts integer yyyymm to datestring '01-MM-YYYY'
    % E.g. 192701 => '01-01-1927'
    dd = 1;
    mm = mod(dateNumber,100);
    yyyy = (dateNumber-mod(dateNumber,100))/100;
    dateNr = datestr(datenum(yyyy,mm,dd));
end