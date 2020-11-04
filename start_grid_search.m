
clear   % clear workspace
clc     % clear console screen


diary off;  diary on;   % to save console output

%--------------------------------------------------------------------------

%*************************%
%* Adjustable Parameters *%
%*************************%

% The location of the folder that contains the data
path='data\';

% the different datasets
datasets={'e','ic','gpcr','nr'};
ds=4;


% ------------------------------------------

% CROSS VALIDATION SETTING -----------------
% cv_setting = 'cv_d';    % DRUG PREDICTION CASE
cv_setting = 'cv_t';    % TARGET PREDICTION CASE
% cv_setting = 'cv_p';    % PAIR PREDICTION CASE
% ------------------------------------------

% CROSS VALIDATION PARAMETERS --------------
m = 1;  % number of n-fold experiments (repetitions)
n = 10; % the 'n' in "n-fold experiment"
% ------------------------------------------

%warning off     % to be used when many unnecessary warnings are being produced

%--------------------------------------------------------------------------

% Terminology:
% Y = Interaction matrix
% Sd = Drug similarity matrix
% St = Target similarity matrix


disp('==============================================================');
switch cv_setting
    case 'cv_d', fprintf('\nCV Setting Used: CV_d - New Drug\n');
    case 'cv_t', fprintf('\nCV Setting Used: CV_t - New Target\n');
    case 'cv_p', fprintf('\nCV Setting Used: CV_p - Pair Prediction\n');
end

fprintf('\n');

% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


disp('--------------------------------------------------------------');

fprintf('\nData Set: %s\n', datasets{ds});

% LOAD DATA
[Y,Sd,St,Did,Tid]=getdata(path,datasets{ds});
aupr_sum=[];
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 bestaupr = -Inf;
 for k=(10:10:20)
    for lambda_l=2.^(-4:4)
        for lambda_d=2.^(-4:4)
            for lambda_t=2.^(-4:4)
                aupr = crossValidation(Y',Sd,St,cv_setting,m,n,k,lambda_l,lambda_d,lambda_t);
                fprintf('k=%g\tlambda_l=%g\tlambda_d=%g\tlambda_t=%g\t\tAUPR:\t%.3g\n', k,lambda_l, lambda_d, lambda_t, aupr);
%                 aupr_sum=[aupr_sum aupr];
                if bestaupr < aupr
                    bestaupr = aupr;
                    bestcomb = [k lambda_l lambda_d lambda_t bestaupr];
                end
            end
        end
    end
 end
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
disp('--------------------------------------------------------------');
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

disp('==============================================================');


diary off;