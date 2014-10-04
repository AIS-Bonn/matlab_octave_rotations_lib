% QuatFromFused.m - Philipp Allgeuer - 28/06/14
% Converts fused angles to the corresponding quaternion representation
%
% function [Quat, Tilt] = QuatFromFused(Fused)
%

% Main function
function [Quat, Tilt] = QuatFromFused(Fused)

	% Precalculate the sin values
	sth  = sin(Fused(2));
	sphi = sin(Fused(3));
	
	% Calculate the sin sum criterion
	crit = sth*sth + sphi*sphi;
	
	% Calculate the tilt angle alpha
	if crit >= 1.0
		alpha = pi/2;
	else
		if Fused(4) >= 0
			calpha =  sqrt(1-crit);
		else
			calpha = -sqrt(1-crit);
		end
		alpha = acos(calpha);
	end
	
	% Calculate the tilt axis gamma
	gamma = atan2(sth,sphi);
	
	% Evaluate the required intermediate angles
	halpha = alpha/2.0;
	hpsi = Fused(1)/2.0;
	hgampsi = gamma + hpsi;
	
	% Precalculate trigonometric terms involved in the quaternion expression
	chalpha = cos(halpha);
	shalpha = sin(halpha);
	chpsi = cos(hpsi);
	shpsi = sin(hpsi);
	chgampsi = cos(hgampsi);
	shgampsi = sin(hgampsi);
	
	% Calculate the required quaternion
	Quat = [chalpha*chpsi shalpha*chgampsi shalpha*shgampsi chalpha*shpsi];
	
	% Return the tilt angles representation
	Tilt = [Fused(1) gamma alpha];

end
% EOF