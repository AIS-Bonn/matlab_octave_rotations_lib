% RandQuat.m - Philipp Allgeuer - 14/02/14
% Generate random quaternion(s) (output is Nx4)
function q = RandQuat(N)
	if nargin < 1 || ~isscalar(N) || N < 0
		N = 1;
	end
	q = 2*rand(N,4) - 1;
	q = q ./ repmat(sqrt(sum(q.^2,2)),1,4);
end
% EOF