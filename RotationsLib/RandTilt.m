% RandTilt.m - Philipp Allgeuer - 30/06/14
% Generates random tilt angle rotations
function T = RandTilt(N)
	if nargin < 1 || ~isscalar(N) || N < 0
		N = 1;
	end
	T = (2*rand(N,3)-1)*(pi*diag([1 1 0.5])) + repmat([0 0 0.5*pi],N,1);
end
% EOF