% TiltEqual.m - Philipp Allgeuer - 22/10/14
% Returns whether two tilt angles rotations represent the same rotation.
%
% function [Equal, Err] = TiltEqual(T, U, Tol)
%
% Refer to EnsureTilt for more information on the unique form of a tilt
% angles rotation.
%
% T     ==> First tilt angles rotation to compare
% U     ==> Second tilt angles rotation to compare
% Tol   ==> Allowed tolerance between T and U for which equality is still asserted
% Equal ==> Boolean flag whether T equals U to the given L_inf norm tolerance
% Err   ==> The quantified error between T and U (0 if exactly equal)

% Main function
function [Equal, Err] = TiltEqual(T, U, Tol)

	% Default tolerance
	if nargin < 3
		Tol = 1e-10;
	else
		Tol = abs(Tol);
	end

	% Convert both tilt angles into their unique representations
	T = EnsureTilt(T, Tol, true);
	U = EnsureTilt(U, Tol, true);

	% Calculate the deviation between the two rotations
	Err = max(abs(T-U));

	% Check whether the two rotations are within tolerance
	Equal = (Err <= Tol);
	
end
% EOF