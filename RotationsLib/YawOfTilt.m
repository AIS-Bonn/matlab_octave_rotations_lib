% YawOfTilt.m - Philipp Allgeuer - 30/06/14
% Calculates the ZYX yaw of a tilt angles rotation
function Yaw = YawOfTilt(Tilt)

	% Precalculate trigonometric terms involved in the rotation matrix expression
	psigam = Tilt(1) + Tilt(2);
	cpsigam = cos(psigam);
	spsigam = sin(psigam);
	cgam = cos(Tilt(2));
	sgam = sin(Tilt(2));
	calpha = cos(Tilt(3));
	A = sgam * calpha;
	
	% Calculate the ZYX yaw
	Yaw = atan2(cgam*spsigam-A*cpsigam, cgam*cpsigam+A*spsigam);
	
end
% EOF