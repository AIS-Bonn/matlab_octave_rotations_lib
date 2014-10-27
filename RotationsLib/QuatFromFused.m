% QuatFromFused.m - Philipp Allgeuer - 22/10/14
% Converts a fused angles rotation to the corresponding quaternion representation.
%
% function [Quat, Tilt] = QuatFromFused(Fused)
%
% The output quaternion is in the format [w x y z].
%
% Fused ==> Input fused angles rotation
% Quat  ==> Equivalent quaternion rotation

% Main function
function [Quat, Tilt] = QuatFromFused(Fused)

	% Precalculate the sin values
	sth  = sin(Fused(2));
	sphi = sin(Fused(3));
	
	% Calculate the tilt angle alpha
	crit = sth*sth + sphi*sphi;
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
	
	% Calculate the tilt axis angle gamma
	gamma = atan2(sth,sphi);
	
	% Evaluate the required intermediate angles
	halpha = 0.5*alpha;
	hpsi = 0.5*Fused(1);
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
	if nargout >= 2
		Tilt = [Fused(1) gamma alpha];
	end

end
% EOF