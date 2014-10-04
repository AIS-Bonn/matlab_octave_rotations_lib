% FusedFromEuler.m - Philipp Allgeuer - 30/06/14
% Converts a ZYX Euler rotation to the corresponding fused angles representation
%
% The output ranges are:
% Fused yaw:   psi   is in (-pi,pi]
% Fused pitch: theta is in [-pi/2,pi/2]
% Fused roll:  phi   is in [-pi/2,pi/2]
% Hemisphere:  h     is in {-1,1}
% 
% function [Fused, Tilt] = FusedFromEuler(Euler)
%

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
	gammainv = atan2(-(cepsi*sce+sepsi*sephi),sepsi*sce-cepsi*sephi);
	psi = pi + gammainv - gamma;
	psi = pi - mod(pi - psi, 2*pi);

	% Calculate the fused pitch and roll
	theta = Euler(2); % ZYX Euler pitch is equivalent to fused pitch!
	phi = asin(R32);
	
	% See which hemisphere we're in
	if cephi >= 0 || ceth <= 0 % ceth should never actually be negative by more than a few eps...
		h = 1;
	else
		h = -1;
	end
	
	% Construct the output fused angles
	Fused = [psi theta phi h];
	
	% Calculate the tilt angle
	alpha = acos(ceth*cephi);
	
	% Construct the output tilt angles
	Tilt = [psi gamma alpha];

end
% EOF