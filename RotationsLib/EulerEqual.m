% EulerEqual.m - Philipp Allgeuer - 22/10/14
% Returns whether two ZYX Euler angles rotations represent the same rotation.
%
% function [Equal, Err] = EulerEqual(E, F, Tol)
%
% The following fundamental ZYX Euler angle equivalences hold:
% 1) (psi, th, phi) == (psi+2*pi*k1, th+2*pi*k2, phi+2*pi*k3) for integers k1, k2, k3
% 2) (psi, th, phi) == (pi+psi, pi-th, pi+phi)
% 3) (psia, th, phia) == (psib, th, phib) IF sin(th) =  1 and psia - phia = psib - phib,
%                                         OR sin(th) = -1 and psia + phia = psib + phib
%    sin(th) = 1 resolves to th = pi/2 + 2*pi*k, and sin(th) = -1 resolves
%    to th = -pi/2 + 2*pi*k.
% Refer to EnsureEuler for more information on the unique form of a ZYX Euler
% angles rotation.
%
% E     ==> First ZYX Euler angles rotation to compare
% F     ==> Second ZYX Euler angles rotation to compare
% Tol   ==> Allowed tolerance between E and F for which equality is still asserted
% Equal ==> Boolean flag whether E equals F to the given L_inf norm tolerance
% Err   ==> The quantified error between E and F (0 if exactly equal)

% Main function
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
	
	% Check whether the two rotations are within tolerance
	Equal = (Err <= Tol);

end
% EOF