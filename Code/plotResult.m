function plotResult(t_lambda, lambda, alpha, beta, gamma, covariance, excess_returns, dates)
    % Plots the residual 
    figure
    predicted_returns = (beta*gamma)';
    actual_returns = excess_returns;
    residual = predicted_returns - actual_returns;
    xDates = dateConversion(dates);
    plot(xDates, residual, '.')
    datetick('x','yyyy-mm')
    xlim([xDates(1) xDates(end)])
    ylabel('Residual','FontSize',14)
    grid on 
    
    % Plots the expected return as a function of beta
%     figure
%     plot(predicted_returns, actual_returns, '.')
%     grid on
%     xlabel('Actual returns (%)','FontSize',14)
%     ylabel('Expected return (%)','FontSize',14)
%     grid on 
end