% RotmatFromEuler.m - Philipp Allgeuer - 07/03/14
% Converts ZYX Euler angles to the corresponding rotation matrix
%
% function Rotmat = RotmatFromEuler(Euler)
%

% Main function
function Rotmat = RotmatFromEuler(Euler)

	% Precalculate the sin and cos values
	cpsi = cos(Euler(1));
	cth  = cos(Euler(2));
	cphi = cos(Euler(3));
	spsi = sin(Euler(1));
	sth  = sin(Euler(2));
	sphi = sin(Euler(3));
	
	% Calculate the required rotation matrix
	Rotmat = [cpsi*cth cpsi*sth*sphi-spsi*cphi cpsi*sth*cphi+spsi*sphi;
	          spsi*cth spsi*sth*sphi+cpsi*cphi spsi*sth*cphi-cpsi*sphi;
	          -sth     cth*sphi                cth*cphi];

end
% EOF