% AngVelFromEulerVel.m - Philipp Allgeuer - 22/10/14
% Convert a ZYX Euler angles velocity to an angular velocity vector
%
% function [AngVel, Rotmat] = AngVelFromEulerVel(Euler, EulerVel)
%
% The angular velocity vector is expressed in the unrotated global coordinates.
%
% Euler    ==> [phi theta psi]
% EulerVel ==> [dphi dtheta dpsi]
% AngVel   ==> [wx wy wz]
% Rotmat   ==> The 3x3 rotation matrix corresponding to Euler

% Main function
function [AngVel, Rotmat] = AngVelFromEulerVel(Euler, EulerVel)

	% Precompute sin and cos values
	cphi = cos(Euler(1));
	sphi = sin(Euler(1));
	cth  = cos(Euler(2));
	sth  = sin(Euler(2));
	cpsi = cos(Euler(3));
	spsi = sin(Euler(3));
	
	% Calculate the rotation matrix corresponding to the current orientation
	Rotmat = [cphi*cth cphi*sth*spsi-sphi*cpsi cphi*sth*cpsi+sphi*spsi;
	          sphi*cth sphi*sth*spsi+cphi*cpsi sphi*sth*cpsi-cphi*spsi;
	           -sth            cth*spsi                cth*cpsi      ];
	
	% Store Euler angle velocities in conveniently named variables
	dphi = EulerVel(1);
	dth  = EulerVel(2);
	dpsi = EulerVel(3);
	
	% Calculate the angular velocity vector in unrotated global coordinates
	AngVel = [dpsi*cth*cphi-dth*sphi ; dpsi*cth*sphi+dth*cphi ; dphi-dpsi*sth];
	
end
% EOF