% FYawOfRotmat.m - Philipp Allgeuer - 22/10/14
% Calculates the fused yaw of a rotation matrix.
%
% function [FYaw] = FYawOfRotmat(Rotmat)
%
% Rotmat ==> Input rotation matrix
% FYaw   ==> Fused yaw of the input rotation

% Main function
function [FYaw] = FYawOfRotmat(Rotmat)

	% Calculate the fused yaw of the rotation
	FYaw = atan2(Rotmat(1,3),-Rotmat(2,3)) - atan2(-Rotmat(3,1),Rotmat(3,2));
	FYaw = pi - mod(pi - FYaw, 2*pi);

end
% EOF