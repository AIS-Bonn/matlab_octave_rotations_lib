% FYawOfEuler.m - Philipp Allgeuer - 30/06/14
% Calculates the fused yaw of a ZYX Euler angles rotation
function FYaw = FYawOfEuler(Euler)

	% Precalculate the sin and cos values
	cpsi = cos(Euler(1));
	cth  = cos(Euler(2));
	cphi = cos(Euler(3));
	spsi = sin(Euler(1));
	sth  = sin(Euler(2));
	sphi = sin(Euler(3));

	% Calculate the fused yaw
	FYaw = pi + atan2(-cpsi*sth*cphi-spsi*sphi,spsi*sth*cphi-cpsi*sphi) - atan2(sth,cth*sphi);
	FYaw = pi - mod(pi - FYaw, 2*pi);

end
% EOF