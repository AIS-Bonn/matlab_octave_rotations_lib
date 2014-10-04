% EulerFromQuat.m - Philipp Allgeuer - 09/12/13
% Converts a quaternion orientation into ZYX Euler angles
%
% The output ranges are:
% Yaw:   psi   is in (-pi,pi]
% Pitch: theta is in [-pi/2,pi/2]
% Roll:  phi   is in (-pi,pi]
%
% function Euler = EulerFromQuat(Quat)
%

% Main function
function Euler = EulerFromQuat(Quat)

	% Extract the sin of the theta angle
	sth = 2.0*(Quat(1)*Quat(3)-Quat(4)*Quat(2));
	sth = max(min(sth,1.0),-1.0); % Note: If Quat is valid then this should only trim at most a few eps...

	% Calculate the required Euler angles
	Euler = [atan2(Quat(1)*Quat(4)+Quat(2)*Quat(3),0.5-(Quat(3)*Quat(3)+Quat(4)*Quat(4)))
	         asin(sth)
	         atan2(Quat(1)*Quat(2)+Quat(3)*Quat(4),0.5-(Quat(2)*Quat(2)+Quat(3)*Quat(3)))]';
	
end
% EOF