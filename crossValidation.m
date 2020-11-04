function aupr=crossValidation(Y,Sd,St,cv_setting,m,n,k,lambda_l,lambda_d,lambda_t)

    % parameters
    fprintf('+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\n\n\n');
    fprintf('m = %i\n',m);      % #repetitions
    fprintf('n = %i\n',n);      % #folds

    % seeds
    rng('default')
    rng('shuffle');
    seeds = randi(10000,1,m);

    % print seeds to be used...
    fprintf('seeds = [  ');
    for s=1:length(seeds)
        fprintf('%i  ',seeds(s));
    end
    fprintf('  ]\n\n');
    disp('==========================');

    % cross validation (m repetitions of n-fold experiments)
    AUCs  = zeros(1,m);
    AUPRs = zeros(1,m);
    for i=1:m
        seed = seeds(i);
        [AUCs(i), AUPRs(i)] = nfold(Y,Sd,St,n,seed,cv_setting,k,lambda_l,lambda_d,lambda_t);
        diary off;  diary on;
    end

    % display evaluation results
    fprintf('\n FINAL AVERAGED RESULTS\n\n');
    fprintf('     AUC (std): %g\t(%g)\n',   mean(AUCs),  std(AUCs));
    fprintf('    AUPR (std): %g\t(%g)\n',   mean(AUPRs), std(AUPRs));
    diary off;  diary on;
    
    aupr=mean(AUPRs);
end