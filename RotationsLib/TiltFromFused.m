% TiltFromFused.m - Philipp Allgeuer - 30/06/14
% Converts a fused angles rotation into tilt angles
%
% The output ranges are:
% Fused yaw:  psi   is in (-pi,pi]
% Tilt axis:  gamma is in (-pi,pi]
% Tilt angle: alpha is in [0,pi]
%
% function Tilt = TiltFromFused(Fused)
%

% Main function
function Tilt = TiltFromFused(Fused)

	% Precalculate the sin values
	sth  = sin(Fused(2));
	sphi = sin(Fused(3));
	
	% Calculate the sin sum criterion
	crit = sth*sth + sphi*sphi;
	
	% Calculate the cos of the tilt angle alpha
	if crit >= 1.0
		calpha = 0.0;
	else
		if Fused(4) >= 0
			calpha =  sqrt(1-crit);
		else
			calpha = -sqrt(1-crit);
		end
	end
	
	% Calculate the tilt axis and tilt angle
	gamma = atan2(sth,sphi);
	alpha = acos(calpha);
	
	% Return the tilt angles representation
	Tilt = [Fused(1) gamma alpha];

end
% EOF