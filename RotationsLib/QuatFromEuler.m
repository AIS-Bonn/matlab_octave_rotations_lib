% QuatFromEuler.m - Philipp Allgeuer - 09/12/13
% Converts ZYX Euler angles to the corresponding quaternion representation
%
% function Quat = QuatFromEuler(Euler)
%

% Main function
function Quat = QuatFromEuler(Euler)

	% Halve the euler angles
	hpsi = Euler(1)/2.0;
	hth  = Euler(2)/2.0;
	hphi = Euler(3)/2.0;
	
	% Precalculate the sin and cos values
	cpsi = cos(hpsi);
	spsi = sin(hpsi);
	cth  = cos(hth);
	sth  = sin(hth);
	cphi = cos(hphi);
	sphi = sin(hphi);
	
	% Calculate the required quaternion
	Quat = [cphi*cth*cpsi+sphi*sth*spsi sphi*cth*cpsi-cphi*sth*spsi cphi*sth*cpsi+sphi*cth*spsi cphi*cth*spsi-sphi*sth*cpsi];

end
% EOF