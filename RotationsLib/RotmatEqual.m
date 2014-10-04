% RotmatEqual.m - Philipp Allgeuer - 07/03/14
% Returns whether two rotation matrices are equivalent.
% Two rotation matrices are equivalent iff they are equal as matrices.
function [Equal, Err] = RotmatEqual(Ra, Rb, Tol)

	% Default tolerance
	if nargin < 3
		Tol = 1e-10;
	else
		Tol = abs(Tol);
	end

	% Check whether the two rotation matrices are within tolerance
	Err = norm(Ra-Rb);
	Equal = (Err <= Tol);

end
% EOF