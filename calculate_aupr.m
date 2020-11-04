function AUPR=calculate_aupr(targets,predicts)
%calculate_aupr calculates the area under the precision-recall curve
%
% AUPR = calculate_aupr(targets, predicts)
%
% INPUT:
%  targets:     actual labels
%  predicts:    prediction scores
%
% OUTPUT
%  AUPR:        area under the precision-recall curve
%

	if nargin > 1
		[~,i] = sort(predicts,'descend');
		targets = targets(i);
	end
	
	%for i=1:n
	%	if targets(i)
	%		goods = goods + 1
	%       aupr = aupr + good/(good+bad);
	%	else
	%		bad = bad + 1;
	%	end
	%end
	cumsums = cumsum(targets)./reshape(1:numel(targets),size(targets));
	AUPR = sum(cumsums(~~targets));
	pos = sum(targets);
	AUPR = AUPR / pos;
end