% EulerFromRotmat.m - Philipp Allgeuer - 10/03/14
% Converts a rotation matrix to the corresponding ZYX Euler angles
%
% The output ranges are:
% Yaw:   psi   is in (-pi,pi]
% Pitch: theta is in [-pi/2,pi/2]
% Roll:  phi   is in (-pi,pi]
%
% function Euler = EulerFromRotmat(Rotmat)
%

% Main function
function Euler = EulerFromRotmat(Rotmat)

	% Extract the sin of the theta angle
	sth = -Rotmat(3,1);
	sth = max(min(sth,1.0),-1.0); % Note: If Rotmat is valid then this should only trim at most a few eps...

	% Calculate the required Euler angles
	Euler = [atan2(Rotmat(2,1),Rotmat(1,1))
	         asin(sth)
	         atan2(Rotmat(3,2),Rotmat(3,3))]';

end
% EOF