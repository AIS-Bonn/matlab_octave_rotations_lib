% EnsureFused.m - Philipp Allgeuer - 22/10/14
% Checks whether a fused angles rotation is valid to within a certain
% tolerance and fixes it if not.
%
% function [Fout, WasBad] = EnsureFused(Fin, Tol, Unique)
%
% A set of fused angles (psi, theta, phi, h) is valid if psi is in (-pi,pi],
% theta is in [-pi/2,pi/2], phi is in [-pi/2,pi/2], h is in {-1,1}, and
% abs(theta) + abs(phi) <= pi/2 (equivalent to sin(theta)^2 + sin(phi)^2 <= 1).
% Uniqueness is achieved by setting h = 1 when equality holds in the above
% inequality, and setting psi = 0 when theta = phi = 0 and h = -1.
%
% Fin    ==> Input fused angles rotation
% Tol    ==> Tolerance bound for the L_inf norm of the input/output difference
% Unique ==> Boolean flag whether to make the output rotation unique
% Fout   ==> Output fused angles rotation (fixed)
% WasBad ==> Boolean flag whether the input and output differ more than Tol

% Main function
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
	Fout(1:3) = pi - mod(pi - Fout(1:3), 2*pi);
	
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
		SineSum = sin(Fout(2))^2 + sin(Fout(3))^2;
		if SineSum >= 1 - Tol
			Fout(4) = 1;
		end
		L1Norm = abs(Fout(2)) + abs(Fout(3));
		if L1Norm <= Tol && Fout(4) == -1
			Fout(1) = 0;
		end
	end

	% Work out whether we changed anything
	WasBad = any(abs(Fout - Fin) > Tol);

end
% EOF