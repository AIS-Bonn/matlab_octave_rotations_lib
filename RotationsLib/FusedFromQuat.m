% FusedFromQuat.m - Philipp Allgeuer - 30/06/14
% Converts a quaternion orientation into fused angles
%
% The output ranges are:
% Fused yaw:   psi   is in (-pi,pi]
% Fused pitch: theta is in [-pi/2,pi/2]
% Fused roll:  phi   is in [-pi/2,pi/2]
% Hemisphere:  h     is in {-1,1}
%
% function [Fused, Tilt] = FusedFromQuat(Quat)
%

% Main function
function [Fused, Tilt] = FusedFromQuat(Quat)

	% Calculate and wrap the fused yaw
	psi = 2.0*atan2(Quat(4),Quat(1));
	psi = pi - mod(pi - psi, 2*pi);
	
	% Calculate the fused pitch and roll
	stheta = 2.0*(Quat(3)*Quat(1) - Quat(2)*Quat(4));
	sphi = 2.0*(Quat(3)*Quat(4) + Quat(2)*Quat(1));
	stheta = max(min(stheta,1.0),-1.0); % Note: If Quat is valid then this should only trim at most a few eps...
	sphi = max(min(sphi,1.0),-1.0); % Note: If Quat is valid then this should only trim at most a few eps...
	theta = asin(stheta);
	phi = asin(sphi);
	
	% See which hemisphere we're in
	hzzG = 0.5 - (Quat(2)*Quat(2) + Quat(3)*Quat(3));
	if hzzG >= 0
		h = 1;
	else
		h = -1;
	end

	% Construct the output fused angles
	Fused = [psi theta phi h];
	
	% Calculate the tilt axis and angle
	hzzG = max(min(hzzG,0.5),-0.5); % Note: If Quat is valid then this should only trim at most a few eps...
	gamma = atan2(stheta,sphi);
	alpha = acos(2.0*hzzG);

	% Construct the output tilt angles
	Tilt = [psi gamma alpha];
	
end
% EOF