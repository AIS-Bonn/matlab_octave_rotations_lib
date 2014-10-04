% FusedFromRotmat.m - Philipp Allgeuer - 30/06/14
% Converts a rotation matrix to the corresponding fused angles representation
%
% The output ranges are:
% Fused yaw:   psi   is in (-pi,pi]
% Fused pitch: theta is in [-pi/2,pi/2]
% Fused roll:  phi   is in [-pi/2,pi/2]
% Hemisphere:  h     is in {-1,1}
% 
% function [Fused, Tilt] = FusedFromRotmat(Rotmat)
%

% Main function
function [Fused, Tilt] = FusedFromRotmat(Rotmat)

	% Calculate the sin of the fused pitch and roll
	stheta = -Rotmat(3,1);
	sphi = Rotmat(3,2);
	stheta = max(min(stheta,1.0),-1.0); % Note: If Rotmat is valid then this should only trim at most a few eps...
	sphi = max(min(sphi,1.0),-1.0); % Note: If Rotmat is valid then this should only trim at most a few eps...
	
	% Calculate the fused pitch and roll
	theta = asin(stheta);
	phi = asin(sphi);
	
	% Calculate and wrap the fused yaw
	gamma = atan2(stheta,sphi);
	gammainv = atan2(-Rotmat(1,3),Rotmat(2,3));
	psi = pi + gammainv - gamma;
	psi = pi - mod(pi - psi, 2*pi);

	% See which hemisphere we're in
	if Rotmat(3,3) >= 0
		h = 1;
	else
		h = -1;
	end

	% Construct the output fused angles
	Fused = [psi theta phi h];
	
	% Calculate the tilt angle
	calpha = max(min(Rotmat(3,3),1.0),-1.0); % Note: If Rotmat is valid then this should only trim at most a few eps...
	alpha = acos(calpha);

	% Construct the output tilt angles
	Tilt = [psi gamma alpha];

end
% EOF