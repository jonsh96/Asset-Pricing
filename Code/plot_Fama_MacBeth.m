function plot_Fama_MacBeth(x, y)
    p = polyfit(x,y,1);
 
    % Evaluate the fitted polynomial p and plot:
    xp = 0:0.05:1;
    f = polyval(p,xp);

    xt = 0.05 * (max(x)-min(x)) + min(x)
    yt = 0.90 * (max(y)-min(y)) + min(y)
    
    if(p(2) > 0)
        caption = sprintf('y = %fx + %e', p(1), p(2));
    else
        caption = sprintf('y = %fx - %e', p(1), abs(p(2)));
    end
    
    scatter(x,y,'filled')
    hold on
    grid on
    plot(xp,f,'k-')
    %text(xt, yt, caption, 'FontSize', 12, 'Color', 'k', 'FontWeight', 'bold');
    plot(x,y,'bo')
    xlabel('Predicted expected returns from Fama MacBeth','FontSize',14)
    ylabel('Actual expected returns','FontSize',14)
    %title('Fama MacBeth fit','FontSize',14)
    xlim([0,1])
end