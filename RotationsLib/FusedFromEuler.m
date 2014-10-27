% FusedFromEuler.m - Philipp Allgeuer - 22/10/14
% Converts a ZYX Euler angles rotation to the corresponding fused angles representation.
%
% function [Fused, Tilt] = FusedFromEuler(Euler)
%
% The output ranges are:
% Fused yaw:   psi   is in (-pi,pi]
% Fused pitch: theta is in [-pi/2,pi/2]
% Fused roll:  phi   is in [-pi/2,pi/2]
% Hemisphere:  h     is in {-1,1}
% 
% Euler ==> Input ZYX Euler angles rotation
% Fused ==> Equivalent fused angles rotation
% Tilt  ==> Equivalent tilt angles rotation

% Main function
function [Fused, Tilt] = FusedFromEuler(Euler)

	% Precalculate the sin and cos values
	cepsi = cos(Euler(1));
	ceth  = cos(Euler(2));
	cephi = cos(Euler(3));
	sepsi = sin(Euler(1));
	seth  = sin(Euler(2));
	sephi = sin(Euler(3));
	
	% Calculate intermediate terms
	R32 = ceth*sephi;
	sce = seth*cephi;

	% Calculate and wrap the fused yaw
	gamma = atan2(seth,R32);
	psi = atan2(cepsi*sce+sepsi*sephi,cepsi*sephi-sepsi*sce) - gamma;
	psi = pi - mod(pi - psi, 2*pi);

	% Calculate the fused pitch and roll
	theta = Euler(2); % ZYX Euler pitch is equivalent to fused pitch!
	phi = asin(R32);
	
	% See which hemisphere we're in
	calpha = ceth*cephi;
	if calpha >= 0
		h = 1;
	else
		h = -1;
	end
	
	% Construct the output fused angles
	Fused = [psi theta phi h];
	
	% Construct the output tilt angles
	if nargout >= 2
		alpha = acos(calpha);
		Tilt = [psi gamma alpha];
	end

end
% EOF