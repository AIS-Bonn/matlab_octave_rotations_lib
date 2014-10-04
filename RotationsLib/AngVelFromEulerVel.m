% AngVelFromEulerVel.m - Philipp Allgeuer - 06/11/13
% Transform rates of change of ZYX Euler angles to an angular velocity vector (in unrotated global coordinates)
%
% function [AngVel, Rotmat] = AngVelFromEulerVel(Euler, EulerVel)
% Euler should be [phi theta psi]
% EulerVel should be [dphi dtheta dpsi]
% AngVel is [wx wy wz]
% Rotmat is the 3x3 rotation matrix corresponding to Euler

% Main function
function [AngVel, Rotmat] = AngVelFromEulerVel(Euler, EulerVel)

	% Precompute sin and cos values
	cphi=cos(Euler(1));
	sphi=sin(Euler(1));
	cth =cos(Euler(2));
	sth =sin(Euler(2));
	cpsi=cos(Euler(3));
	spsi=sin(Euler(3));
	
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