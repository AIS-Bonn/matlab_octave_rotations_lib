% FYawOfRotmat.m - Philipp Allgeuer - 30/06/14
% Calculates the fused yaw of a rotation matrix
function FYaw = FYawOfRotmat(Rotmat)
	FYaw = pi + atan2(-Rotmat(1,3),Rotmat(2,3)) - atan2(-Rotmat(3,1),Rotmat(3,2));
	FYaw = pi - mod(pi - FYaw, 2*pi);
end
% EOF