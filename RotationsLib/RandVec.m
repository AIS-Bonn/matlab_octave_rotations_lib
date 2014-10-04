% RandVec.m - Philipp Allgeuer - 11/03/14
% Generates a random 3-vector of up to the given norm.
% If generating N vectors then the output is a matrix of dimensions 3xN.
%
% function v = RandVec(N, MaxNorm)
%
function v = RandVec(N, MaxNorm)
	if nargin < 1 || ~isscalar(N) || N < 0
		N = 1;
	end
	if nargin < 2 || ~isscalar(MaxNorm) || MaxNorm < 0
		MaxNorm = 1;
	end
	N = round(N);
	RealNorm = MaxNorm * rand(1,N);
	v = 2*rand(3,N) - 1;
	vnorm = sqrt(v(1,:).^2 + v(2,:).^2 + v(3,:).^2);
	vnorm(vnorm == 0) = 1;
	v = v.*repmat(RealNorm./vnorm,3,1);
end
% EOF