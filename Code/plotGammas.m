function plotGammas(dates, gamma)
    % Plots the gammas 
    xDates = dateConversion(dates);

    for i = 1:size(gamma,1)
        figure
        leg = sprintf("Gamma %d",i-1);
        plot(xDates, gamma(i,:)) 
        datetick('x','yyyy-mm')
        xlim([xDates(1) xDates(end)])
        
        grid on 
        legend(leg)
    end
end