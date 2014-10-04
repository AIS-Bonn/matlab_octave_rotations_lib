% RandUnitVec.m - Philipp Allgeuer - 07/07/14
% Generates a random vector of unit norm.
% The dimension of the output is MxN, where N is the number of random vectors to generate,
% and M is the dimension of the vector(s), by default 3.
%
% function v = RandUnitVec(N, M)
%
function v = RandUnitVec(N, M)
	if nargin < 1 || ~isscalar(N) || N < 0
		N = 1;
	end
	if nargin < 2 || ~isscalar(M) || M < 0
		M = 3;
	end
	N = round(N);
	M = round(M);
	v = 2*rand(M,N) - 1;
	vnorm = sqrt(sum(v.^2,1));
	vnorm(vnorm == 0) = 1;
	v = v./repmat(vnorm,M,1);
end
% EOF