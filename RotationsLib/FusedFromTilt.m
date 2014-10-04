% FusedFromTilt.m - Philipp Allgeuer - 30/06/14
% Converts a tilt angles rotation into fused angles
%
% The output ranges are:
% Fused yaw:   psi   is in (-pi,pi]
% Fused pitch: theta is in [-pi/2,pi/2]
% Fused roll:  phi   is in [-pi/2,pi/2]
% Hemisphere:  h     is in {-1,1}
%
% function Fused = FusedFromTilt(Tilt)
%

% Main function
function Fused = FusedFromTilt(Tilt)

	% Precalculate sin and cos values
	cgamma = cos(Tilt(2));
	sgamma = sin(Tilt(2));
	salpha = sin(Tilt(3));

	% Calculate theta and phi
	theta = asin(salpha*sgamma);
	phi   = asin(salpha*cgamma);
	
	% See which hemisphere we're in
	if Tilt(3) <= pi/2
		h = 1;
	else
		h = -1;
	end

	% Construct the output fused angles
	Fused = [Tilt(1) theta phi h];

end
% EOF