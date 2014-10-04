% EnsureQuat.m - Philipp Allgeuer - 10/03/14
% Checks whether a quaternion rotation is valid to a certain tolerance and 'fixes' it if not.
% A quaternion is valid if norm(Q) = 1.
function [Qout, WasBad, Err] = EnsureQuat(Qin, Tol, Force)

	% Default arguments
	if nargin < 2
		Tol = 1e-10;
	else
		Tol = abs(Tol);
	end
	if nargin < 3
		Force = false;
	end
	
	% Check whether the quaternion is ok
	Norm = norm(Qin);
	Err = abs(Norm - 1);
	WasBad = (Err > Tol);
	
	% Set the output
	if WasBad || Force
		Qout = Qin / Norm; % Scale to unit norm
	else
		Qout = Qin;
	end

end
% EOF