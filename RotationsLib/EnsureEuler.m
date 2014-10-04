% EnsureEuler.m - Philipp Allgeuer - 10/03/14
% Checks whether a ZYX Euler angles rotation is valid to a certain tolerance and 'fixes' it if not.
% A set of ZYX Euler angles (psi, theta, phi) is valid if psi is (-pi,pi], theta is [-pi/2,pi/2], and phi is (-pi,pi].
function [Eout, WasBad] = EnsureEuler(Ein, Tol, Unique)

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
	Eout = Ein;

	% Wrap theta to (-pi,pi]
	Eout(2) = pi - mod(pi - Eout(2), 2*pi);

	% Collapse theta into the [-pi/2,pi/2] interval
	if abs(Eout(2)) > pi/2
		Eout = [pi+Eout(1) pi-mod(Eout(2),2*pi) pi+Eout(3)];
	end
	
	% Make positive and negative gimbal lock representations unique
	if Unique
		if abs(Eout(2) - pi/2) <= Tol
			Eout(3) = Eout(3) - Eout(1);
			Eout(1) = 0;
		elseif abs(Eout(2) + pi/2) <= Tol
			Eout(3) = Eout(3) + Eout(1);
			Eout(1) = 0;
		end
	end
	
	% Wrap psi and phi to (-pi,pi]
	Eout(1) = pi - mod(pi - Eout(1), 2*pi);
	Eout(3) = pi - mod(pi - Eout(3), 2*pi);

	% Work out whether we changed anything
	WasBad = any(abs(Eout - Ein) > Tol);

end
% EOF