% YawOfFused.m - Philipp Allgeuer - 30/06/14
% Calculates the ZYX yaw of a fused angles rotation
function Yaw = YawOfFused(Fused)

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

	% Calculate the tilt axis gamma
	gamma = atan2(sth,sphi);

	% Precalculate trigonometric terms involved in the rotation matrix expression
	psigam = Fused(1) + gamma;
	cpsigam = cos(psigam);
	spsigam = sin(psigam);
	cgam = cos(gamma);
	sgam = sin(gamma);
	A = sgam * calpha;

	% Calculate the ZYX yaw
	Yaw = atan2(cgam*spsigam-A*cpsigam, cgam*cpsigam+A*spsigam);

end
% EOF