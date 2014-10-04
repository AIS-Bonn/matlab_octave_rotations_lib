% YawOfQuat.m - Philipp Allgeuer - 30/06/14
% Calculates the ZYX yaw of a quaternion
function Yaw = YawOfQuat(Quat)
	Yaw = atan2(Quat(1)*Quat(4)+Quat(2)*Quat(3),0.5-Quat(3)*Quat(3)-Quat(4)*Quat(4));
end
% EOF