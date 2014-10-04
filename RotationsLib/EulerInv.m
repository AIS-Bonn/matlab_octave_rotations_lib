% EulerInv.m - Philipp Allgeuer - 10/03/14
% Calculates the inverse rotation of a ZYX Euler rotation
function Einv = EulerInv(E)

	% Precalculate the required sin and cos values
	cpsi = cos(E(1));
	cth  = cos(E(2));
	cphi = cos(E(3));
	spsi = sin(E(1));
	sth  = sin(E(2));
	sphi = sin(E(3));

	% Extract the sin of the theta angle
	newsth = -(cpsi*sth*cphi+spsi*sphi);
	newsth = max(min(newsth,1.0),-1.0); % Note: This should only trim at most a few eps...

	% Calculate the required Euler angles
	Einv = [atan2(cpsi*sth*sphi-spsi*cphi,cpsi*cth)
	        asin(newsth)
	        atan2(spsi*sth*cphi-cpsi*sphi,cth*cphi)]';

end
% EOF