% QuatEqual.m - Philipp Allgeuer - 07/03/14
% Returns whether two quaternions represent the same underlying rotation to the given
% degree of tolerance in terms of the vector norm of the deviation.
% Two quaternions P and Q are equivalent iff P == Q or P == -Q.
function [Equal, Err] = QuatEqual(P, Q, Tol)

	% Default tolerance
	if nargin < 3
		Tol = 1e-10;
	else
		Tol = abs(Tol);
	end
	
	% Calculate the deviation between the two quaternions
	Err = norm(P-Q);
	ErrNeg = norm(P+Q);
	if ErrNeg < Err
		Err = ErrNeg;
	end
	
	% Check whether the two quaternions are within tolerance
	Equal = (Err <= Tol);

end
% EOF