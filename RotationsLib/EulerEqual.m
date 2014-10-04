% EulerEqual.m - Philipp Allgeuer - 10/03/14
% Returns whether two ZYX Euler angle rotations represent the same underlying rotation
% to the given degree of tolerance in each term.
% The following fundamental ZYX Euler angle equivalences hold:
% 1) (psi, th, phi) == (psi+2*pi*k1, th+2*pi*k2, phi+2*pi*k3) for integers k1, k2, k3
% 2) (psi, th, phi) == (pi+psi, pi-th, pi+phi)
% 3) (psia, th, phia) == (psib, th, phib) IF sin(th) =  1 and psia - phia = psib - phib,
%                                         OR sin(th) = -1 and psia + phia = psib + phib
%    sin(th) = 1 resolves to th = pi/2 + 2*pi*k, and sin(th) = -1 resolves to th = -pi/2 + 2*pi*k
function [Equal, Err] = EulerEqual(E, F, Tol)

	% Default tolerance
	if nargin < 3
		Tol = 1e-10;
	else
		Tol = abs(Tol);
	end

	% Convert both Euler angles into their unique representations
	E = EnsureEuler(E, Tol, true);
	F = EnsureEuler(F, Tol, true);
	
	% Calculate the deviation between the two rotations
	Err = max(abs(E-F));
	
	% Check whether the two Euler angle rotations are within tolerance
	Equal = (Err <= Tol);

end
% EOF