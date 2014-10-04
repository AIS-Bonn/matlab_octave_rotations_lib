% RotmatNoFYaw.m - Philipp Allgeuer - 30/06/14
% Removes the fused yaw component of a rotation matrix
function [Rout, fyaw, Rfyaw] = RotmatNoFYaw(Rin)
	fyaw = pi + atan2(-Rotmat(1,3),Rotmat(2,3)) - atan2(-Rotmat(3,1),Rotmat(3,2));
	fyaw = pi - mod(pi - fyaw, 2*pi);
	cfyaw = cos(fyaw);
	sfyaw = sin(fyaw);
	Rfyaw = [cfyaw -sfyaw 0;sfyaw cfyaw 0;0 0 1];
	Rout = Rfyaw' * Rin;
end
% EOF