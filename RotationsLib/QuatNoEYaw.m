% QuatNoEYaw.m - Philipp Allgeuer - 05/11/14
% Removes the ZYX yaw component of a quaternion rotation.
%
% function [Qout, EYaw, QEYaw] = QuatNoEYaw(Qin)
%
% Qin   ==> Input quaternion rotation (assumed to have unit norm)
% Qout  ==> Output quaternion rotation with no ZYX yaw
% EYaw  ==> ZYX yaw of the input rotation
% QEYaw ==> Quaternion representation of the ZYX yaw component
%           of the input rotation

% Main function
function [Qout, EYaw, QEYaw] = QuatNoEYaw(Qin)

	% Calculate the ZYX yaw of the input
	EYaw = atan2(Qin(1)*Qin(4)+Qin(2)*Qin(3),0.5-(Qin(3)*Qin(3)+Qin(4)*Qin(4)));
	
	% Construct the ZYX yaw component of the rotation
	hcEYaw = cos(0.5*EYaw);
	hsEYaw = sin(0.5*EYaw);
	QEYaw = [hcEYaw 0 0 hsEYaw];
	
	% Remove the ZYX yaw component of the rotation
	Qout = hcEYaw*Qin + hsEYaw*[Qin(4) Qin(3) -Qin(2) -Qin(1)];

end
% EOF