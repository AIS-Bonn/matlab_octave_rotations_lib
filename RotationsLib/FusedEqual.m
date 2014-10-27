% FusedEqual.m - Philipp Allgeuer - 22/10/14
% Returns whether two fused angles rotations represent the same rotation.
%
% function [Equal, Err] = FusedEqual(F, G, Tol)
%
% Refer to EnsureFused for more information on the unique form of a fused
% angles rotation.
%
% F     ==> First fused angles rotation to compare
% G     ==> Second fused angles rotation to compare
% Tol   ==> Allowed tolerance between F and G for which equality is still asserted
% Equal ==> Boolean flag whether F equals G to the given L_inf norm tolerance
% Err   ==> The quantified error between F and G (0 if exactly equal)

% Main function
function [Equal, Err] = FusedEqual(F, G, Tol)

	% Default tolerance
	if nargin < 3
		Tol = 1e-10;
	else
		Tol = abs(Tol);
	end

	% Convert both fused angles into their unique representations
	F = EnsureFused(F, Tol, true);
	G = EnsureFused(G, Tol, true);

	% Calculate the deviation between the two rotations
	Err = max(abs(F-G));

	% Check whether the two rotations are within tolerance
	Equal = (Err <= Tol);
	
end
% EOF