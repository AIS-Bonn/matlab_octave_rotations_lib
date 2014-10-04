% RandRotmat.m - Philipp Allgeuer - 14/02/14
% Generates random rotation matrix/matrices
% The internally randomly generated quaternions are also returned
function [R, q] = RandRotmat(N)
	if nargin < 1 || ~isscalar(N) || N < 0
		N = 1;
	end
	q = RandQuat(N);
	R = zeros(3, 3, N);
	for k = 1:N
		R(:,:,k) = RotmatFromQuat(q(k,:));
	end
end
% EOF