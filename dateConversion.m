function dateNr = dateConversion(dateNumber)
    % Converts integer yyyymm to datestring '01-MM-YYYY'
    % E.g. 192701 => '01-01-1927'
    dd = 1;
    mm = mod(dateNumber,100);
    yyyy = (dateNumber-mod(dateNumber,100))/100;
    dateNr = datenum(yyyy,mm,dd);
end