% TiltFromEuler.m - Philipp Allgeuer - 22/10/14
% Converts a ZYX Euler angles rotation to the corresponding tilt angles representation.
%
% function [Tilt] = TiltFromEuler(Euler)
%
% The output ranges are:
% Fused yaw:        psi   is in (-pi,pi]
% Tilt axis angle:  gamma is in (-pi,pi]
% Tilt angle:       alpha is in [0,pi]
% 
% Euler ==> Input ZYX Euler angles rotation
% Tilt  ==> Equivalent tilt angles rotation

% Main function
function [Tilt] = TiltFromEuler(Euler)

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
	
	% Calculate the tilt angle
	calpha = ceth*cephi; % No need to manually coerce to [-1,1] due to construction
	alpha = acos(calpha);
	
	% Calculate the tilt axis angle
	gamma = atan2(seth,R32);

	% Calculate and wrap the fused yaw
	psi = atan2(cepsi*sce+sepsi*sephi,cepsi*sephi-sepsi*sce) - gamma;
	psi = pi - mod(pi - psi, 2*pi);
	
	% Return the tilt angles representation
	Tilt = [psi gamma alpha];

end
% EOF