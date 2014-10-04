% RandFused.m - Philipp Allgeuer - 02/07/14
% Generates random fused angle rotations
function F = RandFused(N)
	if nargin < 1 || ~isscalar(N) || N < 0
		N = 1;
	end
	yaw = pi*(2*rand(N,1)-1);
	lam = 2*rand(N,2)-1;
	F = [yaw (pi/4)*[lam(:,1)+lam(:,2) lam(:,1)-lam(:,2)] 2*(rand(N,1)>0.5)-1];
end
% EOF