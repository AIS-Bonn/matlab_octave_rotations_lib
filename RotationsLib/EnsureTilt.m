% EnsureTilt.m - Philipp Allgeuer - 22/10/14
% Checks whether a tilt angles rotation is valid to within a certain
% tolerance and fixes it if not.
%
% function [Tout, WasBad] = EnsureTilt(Tin, Tol, Unique)
%
% A set of tilt angles (psi, gamma, alpha) is valid if psi is in (-pi,pi],
% gamma is in (-pi,pi] and alpha is in [0,pi]. If alpha is in the range (-pi,0),
% then the equivalence alpha <-> -alpha, gamma <-> gamma+pi applies. Uniqueness
% is achieved by setting psi = 0 when alpha = pi, and setting gamma = 0 when
% alpha = 0, pi.
%
% Tin    ==> Input tilt angles rotation
% Tol    ==> Tolerance bound for the L_inf norm of the input/output difference
% Unique ==> Boolean flag whether to make the output rotation unique
% Tout   ==> Output tilt angles rotation (fixed)
% WasBad ==> Boolean flag whether the input and output differ more than Tol

% Main function
function [Tout, WasBad] = EnsureTilt(Tin, Tol, Unique)

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
	Tout = Tin;

	% Wrap the angles to (-pi,pi]
	Tout = pi - mod(pi - Tout, 2*pi);

	% Handle case of negative alpha
	if Tout(3) < 0
		Tout(2) = pi - mod(-Tout(2), 2*pi); % Equivalent to wrapToPi(Tout(2)+pi)
		Tout(3) = -Tout(3);
	end
	
	% Check whether we need to make the representation unique
	if Unique
		if Tout(3) <= Tol || Tout(3) >= pi-Tol
			Tout(2) = 0;
		end
		if Tout(3) >= pi-Tol
			Tout(1) = 0;
		end
	end

	% Work out whether we changed anything
	WasBad = any(abs(Tout - Tin) > Tol);

end
% EOF