%%  Data processing 
%   - If the data is not in the folder, the files are downloaded.
%   - Imports the data from the files into tables 
%   - This process/code should be reusable for comparable files/factors, 
%     given that the data is available via url.

% Monthly portfolios for US stocks sorted by size and momentum
monthly_url = "https://mba.tuck.dartmouth.edu/pages/faculty/ken.french/ftp/25_Portfolios_ME_Prior_12_2_CSV.zip";
monthly_filename = download_data(monthly_url);

% Liquqidity factor 
liquidity_url = "http://faculty.chicagobooth.edu/lubos.pastor/research/liq_data_1962_2018.txt";
liquidity_filename = download_data(liquidity_url);

% Risk free rate and excess market return
fama_french_url = "https://mba.tuck.dartmouth.edu/pages/faculty/ken.french/ftp/F-F_Research_Data_Factors_CSV.zip";
fama_french_filename = download_data(fama_french_url);

% Checks whether the data has been imported into tables
if(~exist('monthly_data','var') || ~exist('liquidity_data','var') || ~exist('market_data','var') || ~exist('risk_free_data','var') || ~exist('excess_return_data','var'))
    fprintf("Importing the data into datatables.\n\n")
    % Importing monthly data into datatable
    opts = detectImportOptions(monthly_filename);       % Automatically detects import settings
    monthly_data = readtable(monthly_filename, opts);

    % Importing liquidity data into datatable
    opts = detectImportOptions(liquidity_filename);        % Automatically detects import settings
    liquidity_data = readtable(liquidity_filename, opts);
    liquidity_data = liquidity_data(:,1:end-1);
    
    % Importing Fama French data into datatable
    opts = detectImportOptions(fama_french_filename);        % Automatically detects import settings
    market_data = readtable(fama_french_filename, opts);
    excess_return_data = market_data(:,2);
    risk_free_data = market_data(:,5);
    
    % Used to clean out NaN values
    risk_free_temp = risk_free_data{:,'RF'};
    risk_free_temp(isnan(risk_free_temp))=0;
    risk_free_data = risk_free_temp;
    
    % Manually fixing the variable names
    monthly_data.Properties.VariableNames(1) = "Months";
    liquidity_data.Properties.VariableNames(1) = "Months";
    liquidity_data.Properties.VariableNames(2) = "Levels_of_aggregate_liquidity";
    liquidity_data.Properties.VariableNames(3) = "Innovations_in_aggregate_liquidity";
    liquidity_data.Properties.VariableNames(4) = "Traded_liquidity_factor";
    
    % Manually filtering the data into 6 monthly tables
    startIndex = find(monthly_data.Months == monthly_data.Months(1));
    endIndex = find(monthly_data.Months == monthly_data.Months(end-1));
    
    %   Average Value Weighted Returns -- Monthly
    AVWR = monthly_data(startIndex(1):endIndex(1),:);
    
    %   The following datatables are not used
    %   Average Equal Weighted Returns -- Monthly
    AEWR = monthly_data(startIndex(2):endIndex(2),:);
    %   Number of Firms in Portfolios
    NFP = monthly_data(startIndex(3):endIndex(3),:);
    %   Average Firm Size
    AVS = monthly_data(startIndex(4):endIndex(4),:);
    %   Equally-Weighted Average of Prior Returns
    EQAPR = monthly_data(startIndex(5):endIndex(5),:);
    %   Value-Weighted Average of Prior Returns
    VWAPR = monthly_data(startIndex(6):endIndex(6),:);
else
    fprintf("The data has already been imported into datatables.\n\n")
end 