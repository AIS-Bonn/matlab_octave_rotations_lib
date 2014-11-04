% QuatFromEuler.m - Philipp Allgeuer - 05/11/14
% Converts a ZYX Euler angles rotation to the corresponding quaternion representation.
%
% function [Quat] = QuatFromEuler(Euler)
%
% The output quaternion is in the format [w x y z].
%
% Euler ==> Input ZYX Euler angles rotation
% Quat  ==> Equivalent quaternion rotation

% Main function
function [Quat] = QuatFromEuler(Euler)

	% Halve the Euler angles
	hpsi = 0.5*Euler(1);
	hth  = 0.5*Euler(2);
	hphi = 0.5*Euler(3);
	
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