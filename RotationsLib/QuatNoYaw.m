% QuatNoYaw.m - Philipp Allgeuer - 07/03/14
% Removes the Euler ZYX yaw component of a quaternion
function [Qout, yaw, Qyaw] = QuatNoYaw(Qin)
	yaw = atan2(Qin(1)*Qin(4)+Qin(2)*Qin(3),0.5-(Qin(3)*Qin(3)+Qin(4)*Qin(4)));
	hcyaw = cos(yaw/2);
	hsyaw = sin(yaw/2);
	Qyaw = [hcyaw 0 0 hsyaw];
	Qout = hcyaw*Qin + hsyaw*[Qin(4) Qin(3) -Qin(2) -Qin(1)];
end
% EOF