% QuatFromFYawGzB - Philipp Allgeuer - 26/10/16
% Calculates the quaternion (qGB) with a given fused yaw and body-fixed z-axis in global coordinates (GzB).
%
% function [qGB] = QuatFromFYawGzB(FYaw, GzB)
%
% It is assumed that GzB is a unit vector!

% Main function
function [qGB] = QuatFromFYawGzB(FYaw, GzB)

	% Precalculate trigonometric terms
	chpsi = cos(0.5*FYaw);
	shpsi = sin(0.5*FYaw);
	
	% Calculate the w and z components
	wsqpluszsq = min(max(0.5*(1 + GzB(3)), 0), 1); % Note: If GzB is a unit vector then this should only trim at most a few eps...
	wznorm = sqrt(wsqpluszsq);
	w = wznorm * chpsi;
	z = wznorm * shpsi;
	
	% Calculate the x and y components
	xsqplusysq = 1 - wsqpluszsq;
	xtilde = GzB(1)*z - GzB(2)*w;
	ytilde = GzB(2)*z + GzB(1)*w;
	xytildenormsq = xtilde*xtilde + ytilde*ytilde;
	if xytildenormsq <= 0
		x = sqrt(xsqplusysq);
		y = 0;
	else
		factor = sqrt(xsqplusysq / xytildenormsq);
		x = factor * xtilde;
		y = factor * ytilde;
	end
	
	% Construct the output quaternion
	qGB = [w x y z];

end
% EOF