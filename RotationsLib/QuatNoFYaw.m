% QuatNoFYaw.m - Philipp Allgeuer - 22/10/14
% Removes the fused yaw component of a quaternion rotation.
%
% function [Qout, FYaw, QFYaw] = QuatNoFYaw(Qin)
%
% Qin   ==> Input quaternion rotation (assumed to have unit norm)
% Qout  ==> Output quaternion rotation with zero fused yaw
% FYaw  ==> Fused yaw of the input rotation
% QFYaw ==> Quaternion representation of the fused yaw component
%           of the input rotation

% Main function
function [Qout, FYaw, QFYaw] = QuatNoFYaw(Qin)

	% Calculate the fused yaw of the input
	FYaw = 2.0*atan2(Qin(4),Qin(1));
	FYaw = pi - mod(pi - FYaw, 2*pi);
	
	% Construct the fused yaw component of the rotation
	hcFYaw = cos(0.5*FYaw);
	hsFYaw = sin(0.5*FYaw);
	QFYaw = [hcFYaw 0 0 hsFYaw];
	
	% Remove the fused yaw component of the rotation
	Qout = hcFYaw*Qin + hsFYaw*[Qin(4) Qin(3) -Qin(2) -Qin(1)];

end
% EOF