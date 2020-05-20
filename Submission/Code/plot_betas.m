function plot_betas(beta)
    % Plots the betas as a bar chart
    for i = 1:size(beta,2)
        figure
        leg = sprintf("Beta %d", i-1);
        bar(beta(:,i))
        grid on
        xlabel('Portfolio','FontSize',14)
        ylabel('Beta value','FontSize',14)
        legend(leg);
    end
end