
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
m = 5;  
n = 10; 
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
Y=Y';

% the best parameters
k=10;lambda_l=2;lambda_d=0.0625;lambda_t=4;

aupr = crossValidation(Y,Sd,St,cv_setting,m,n,k,lambda_l,lambda_d,lambda_t);

disp('--------------------------------------------------------------');
disp('==============================================================');
diary off;
