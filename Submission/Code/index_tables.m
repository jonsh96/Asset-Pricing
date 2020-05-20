function [startIndex endIndex] = index_tables(startDate, endDate, market_data, monthly_data, liquidity_data)
    % Finding the relevant indices to match the start and end dates in each table
    % Used for convenience in parts a, b, c
    
    startIndex(1) = min(find(table2array(monthly_data(:,1)) == startDate));
    endIndex(1) = min(find(table2array(monthly_data(:,1)) == endDate));

    startIndex(2) = min(find(table2array(liquidity_data(:,1)) == startDate));
    endIndex(2)= min(find(table2array(liquidity_data(:,1)) == endDate));

    startIndex(3) = min(find(table2array(market_data(:,1)) == startDate));
    endIndex(3)= min(find(table2array(market_data(:,1)) == endDate));
end