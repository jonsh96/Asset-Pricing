
if print>=1
 
    % print general information to screen
    fprintf('\n\n');
    fprintf('------------------------------------------------------------\n');
    fprintf('         Results of a cross-sectional regression\n');
    fprintf('------------------------------------------------------------\n\n');
    fprintf('Number of factors:                              %1.0f\n',K);
    fprintf('Number of test assets:                          %1.0f\n',N);
    fprintf('Sample size:                                    %1.0f\n',T);
    fprintf('Lags in the estimation of score covariance:     %1.0f\n',lags);
    fprintf('Kernel used in estimation of score covariance:  ');
    if strcmp(nw_method,'HACC_B');
        fprintf('Bartlett\n');
    elseif strcmp(nw_method,'HACC_P');
        fprintf('Parzen\n');
    else 
        fprintf('Serially uncorrelated errors\n');
    end
    fprintf('\n');
    if constant==1
        fprintf('A constant was included in the cross-sectional regression.\n');
    else
        fprintf('Cross-sectional regression was performed without a constant.\n');
    end
    
    % print alphas and betas to screen
    fprintf('\n');
    fprintf('---------------------------------');
    for k=2:K
        fprintf('------------');
    end
    fprintf('\n');
    fprintf(' ASSET      ALPHA       ');
    for i=1:K
        fprintf('BETA%1.0f       ',i);
    end
    fprintf('\n');
    fprintf('---------------------------------');
    for k=2:K
        fprintf('------------');
    end
    fprintf('\n');
    fmt = ['%4.0f    ', repmat('%10.4f  ',1,K), '%10.4f\n'];
    tfmt = ['         ', repmat('(%8.4f)  ',1,K), '(%8.4f)\n'];
    AUX = [1:N;alphaBeta];
    tAUX = [talpha,tbeta]';
    for n=1:N
        fprintf(fmt,AUX(:,n)');
        fprintf(tfmt,tAUX(:,n)');
    end
    fprintf('---------------------------------');
    for k=2:K
        fprintf('------------');
    end
    fprintf('\n\n');
    
    % print lambdas to screen    
    fprintf('-----------');
    for k=2:K+constant
        fprintf('------------');
    end
    fprintf('--\n');
    fprintf('  ');
    idx = 1-constant:K;
    for i=idx
        fprintf('  LAMBDA%1.0f   ',i);
    end
    
    fprintf('\n');
    fprintf('-----------');
    for k=2:K+constant
        fprintf('------------');
    end
    fprintf('--\n');
    lfmt = [repmat('%10.4f  ',1,K-1+constant), '%10.4f\n'];
    tlfmt = [' ',repmat('(%8.4f)  ',1,K-1+constant), '(%8.4f)\n'];
    fprintf(lfmt,lambda');
    fprintf(tlfmt,tlambda');
    fprintf('-----------');
    for k=2:K+constant
        fprintf('------------');
    end
    fprintf('--\n\n');
    
    % print model performance to screen
    fprintf('-----------------------------------------------------------------\n');
    fprintf('      RMSE         R2adj         R2          GRS          p-val\n');
    fprintf('-----------------------------------------------------------------\n');
    fprintf(' %10.4f   %10.4f   %10.4f   %10.4f   %10.4f\n',RMSE, R2adj,R2,GRS,pval);
    fprintf('-----------------------------------------------------------------\n');
    
end
if print>=2
    numbers_only = 1;
    % create "model-implied vs realized"-plot
    figure('Name','Realized versus Predicted Returns','PaperType','a4letter','PaperOrientation','Portrait','Position',[100 100 750 800]);
    min_val=min([100*miReturns;100*EReturns])-0.1*abs(1-min([100*miReturns;100*EReturns]));
    max_val=max([100*miReturns;100*EReturns])+0.1*abs(1-max([100*miReturns;100*EReturns]));
    plot([min_val, max_val],[min_val, max_val],'k','LineWidth',2); hold on;
    labels = cellstr(num2str((1:N)'));
    if numbers_only==0
        plot(100*miReturns(1:N),100*EReturns(1:N),'.','MarkerEdgeColor','r','MarkerFaceColor','r'); hold on;
        dx = 0.05; dy = 0.05; % displacement so the text does not overlay the data points
        text(100*miReturns+dx, 100*EReturns+dy, labels);
    else
        text(100*miReturns, 100*EReturns, labels);
    end    
    daspect([10,10,10]);
    xlabel('Predicted Return'), ylabel('Realized Return');
end
    