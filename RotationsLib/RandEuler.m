% RandEuler.m - Philipp Allgeuer - 14/02/14
% Generates random ZYX Euler rotations
function E = RandEuler(N)
	if nargin < 1 || ~isscalar(N) || N < 0
		N = 1;
	end
	E = (2*rand(N,3)-1)*(pi*diag([1 0.5 1]));
end
% EOF