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

%% TODO:
% - Split data into 6 tables [DONE]
% - Create Fama-MacBeth regression
% - Test CAPM
% - Interpret results



%% a) Perform the test of the CAPM by running a two-steps Fama-MacBeth regression. 
%     Fully interpret the result and comment upon the validity of the model and its 
%     ability to explain the cross-section of the portfolio returns.
dateConversion(200812)

function dateNr = dateConversion(dateNumber)
    % Converts integer yyyymm to datestring '01-MM-YYYY'
    % E.g. 192701 => '01-01-1927'
    dd = 1;
    mm = mod(dateNumber,100);
    yyyy = (dateNumber-mod(dateNumber,10))/100;
    dateNr = datestr(datenum(yyyy,mm,dd)); 
end