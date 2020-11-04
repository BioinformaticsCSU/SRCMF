clear
clc

path='data\';
datasets='gpcr';

disp('--------------------------------------------------------------');
fprintf('\nData Set: %s\n', datasets);

% load data
[Y,Sd,St,Did,Tid]=getdata(path,datasets);
Y=Y';

% the parameters: arbitrarily given
k=20;
lambda_l=2;
lambda_d=1;
lambda_t=1;

% get projection matrix W
W = ones(size(Y));
W(Y == 0) = 0;

y_recovery = alg_srcmf_predict(Y,Sd,St,k,lambda_l,lambda_d,lambda_t,W);

disp('--------------------------------------------------------------');
disp('==============================================================');
diary off;