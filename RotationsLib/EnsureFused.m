% EnsureFused.m - Philipp Allgeuer - 28/06/14
% Checks whether a fused angles rotation is valid to a certain tolerance and 'fixes' it if not.
% The output fused angle can further be enforced to be in its standardised unique representation.
% A set of fused angles (psi, theta, phi, h) is valid if psi is (-pi,pi], theta is [-pi/2,pi/2], phi is [-pi/2,pi/2], h is {-1,1},
% and abs(theta) + abs(phi) <= pi/2 (equivalent to sin(theta)^2 + sin(phi)^2 <= 1).
% Uniqueness is achieved by enforcing h to 1 when equality is achieved in the above inequality.
function [Fout, WasBad] = EnsureFused(Fin, Tol, Unique)

	% Default arguments
	if nargin < 2
		Tol = 1e-10;
	else
		Tol = abs(Tol);
	end
	if nargin < 3
		Unique = false;
	end

	% Make a copy of the input
	Fout = Fin;

	% Wrap the angles to (-pi,pi]
	Fout = pi - mod(pi - Fout, 2*pi);
	
	% Enforce h to {-1,1}
	if Fout(4) >= 0
		Fout(4) = 1;
	else
		Fout(4) = -1;
	end

	% Check the L1 norm
	L1Norm = abs(Fout(2)) + abs(Fout(3));
	if L1Norm > pi/2
		Fout(2:3) = (pi/2)*Fout(2:3)/L1Norm;
	end

	% Check whether we need to make the representation unique
	if Unique
		if L1Norm >= pi/2
			Fout(4) = 1;
		end
	end

	% Work out whether we changed anything
	WasBad = any(abs(Fout - Fin) > Tol);

end
% EOF