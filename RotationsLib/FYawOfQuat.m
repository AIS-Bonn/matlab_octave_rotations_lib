% FYawOfQuat.m - Philipp Allgeuer - 30/06/14
% Calculates the fused yaw of a quaternion
function FYaw = FYawOfQuat(Quat)
	FYaw = 2.0*atan2(Quat(4),Quat(1));
	FYaw = pi - mod(pi - FYaw, 2*pi);
end
% EOF