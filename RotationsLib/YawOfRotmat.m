% YawOfRotmat.m - Philipp Allgeuer - 30/06/14
% Calculates the ZYX yaw of a rotation matrix
function Yaw = YawOfRotmat(Rotmat)
	Yaw = atan2(Rotmat(2,1),Rotmat(1,1));
end
% EOF