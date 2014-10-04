% QuatNoFYaw.m - Philipp Allgeuer - 30/06/14
% Removes the fused yaw component of a quaternion
function [Qout, fyaw, Qfyaw] = QuatNoFYaw(Qin)
	fyaw = 2.0*atan2(Qin(4),Qin(1));
	fyaw = pi - mod(pi - fyaw, 2*pi);
	hcfyaw = cos(fyaw/2);
	hsfyaw = sin(fyaw/2);
	Qfyaw = [hcfyaw 0 0 hsfyaw];
	Qout = hcfyaw*Qin + hsfyaw*[Qin(4) Qin(3) -Qin(2) -Qin(1)];
end
% EOF