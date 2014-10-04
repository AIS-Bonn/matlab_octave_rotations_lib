% RotmatFromFused.m - Philipp Allgeuer - 28/06/14
% Converts fused angles to the corresponding rotation matrix
%
% function [Rotmat, Tilt] = RotmatFromFused(Fused)
%

% Main function
function [Rotmat, Tilt] = RotmatFromFused(Fused)

	% Precalculate the sin values
	sth  = sin(Fused(2));
	sphi = sin(Fused(3));
	
	% Calculate the sin sum criterion
	crit = sth*sth + sphi*sphi;
	
	% Calculate the sin and cos of the tilt angle alpha
	if crit >= 1.0
		salpha = 1.0;
		calpha = 0.0;
	else
		salpha = sqrt(crit);
		if Fused(4) >= 0
			calpha =  sqrt(1-crit);
		else
			calpha = -sqrt(1-crit);
		end
	end
	
	% Calculate the tilt axis gamma
	gamma = atan2(sth,sphi);

	% Precalculate trigonometric terms involved in the rotation matrix expression
	cgam = cos(gamma); % Equals sphi/salpha
	sgam = sin(gamma); % Equals sth/salpha
	psigam = Fused(1) + gamma;
	cpsigam = cos(psigam);
	spsigam = sin(psigam);
	
	% Precalculate additional terms involved in the rotation matrix expression
	A = cgam * cpsigam;
	B = sgam * cpsigam;
	C = cgam * spsigam;
	D = sgam * spsigam;
	
	% Calculate the required rotation matrix
	Rotmat = [A+D*calpha B-C*calpha  salpha*spsigam;
	          C-B*calpha D+A*calpha -salpha*cpsigam;
	          -sth       sphi        calpha];
	
	% Return the tilt angles representation
	Tilt = [Fused(1) gamma acos(calpha)];

end
% EOF