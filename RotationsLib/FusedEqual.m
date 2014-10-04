% FusedEqual.m - Philipp Allgeuer - 28/06/14
% Returns whether two fused angles rotations represent the same underlying rotation
% to the given degree of tolerance in each term.
% The following fundamental equivalences hold:
% 1) (psi, th, phi, h) == (psi+2*pi*k1, th+2*pi*k2, phi+2*pi*k3, h) for integers k1, k2, k3
% 2) (psi, th, phi, h1) == (psi, th, phi, h2) if (h1 >= 0) == (h2 >= 0)
% 3) (psi, th, phi, h) == (psi, th, phi, -h) if th and phi are in (-pi,pi] and abs(th) + abs(phi) >= pi/2
% 4) (psi, th, phi, h) == (psi, c*th, c*phi, h) if both sides are in (-pi,pi] range, c >= 1 and abs(th) + abs(phi) == pi/2
function [Equal, Err] = FusedEqual(F, G, Tol)

	% Default tolerance
	if nargin < 3
		Tol = 1e-10;
	else
		Tol = abs(Tol);
	end

	% Convert both Fused angles into their unique representations
	F = EnsureFused(F, Tol, true);
	G = EnsureFused(G, Tol, true);

	% Calculate the deviation between the two rotations
	Err = max(abs(F-G));

	% Check whether the two Fused angle rotations are within tolerance
	Equal = (Err <= Tol);
	
end
% EOF