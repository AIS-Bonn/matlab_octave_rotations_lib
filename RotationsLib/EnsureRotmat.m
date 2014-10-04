% EnsureRotmat.m - Philipp Allgeuer - 10/03/14
% Checks whether a rotation matrix is valid to a certain tolerance and 'fixes' it if not.
% A rotation matrix is valid if R'*R = I and det(R) = 1.
function [Rout, WasBad, Err] = EnsureRotmat(Rin, Tol, Force)

	% Default arguments
	if nargin < 2
		Tol = 1e-10;
	else
		Tol = abs(Tol);
	end
	if nargin < 3
		Force = false;
	end

	% Check whether the rotation matrix is ok
	Prod = Rin' * Rin;
	Err = norm(Prod - eye(3));
	WasBad = (Err > Tol) || (abs(det(Rin) - 1) > Tol);

	% Set the output
	if WasBad || Force
		Rout = Rin / sqrtm(Prod); % Find the 'closest' valid rotation matrix to the given one
	else
		Rout = Rin;
	end

end
% EOF