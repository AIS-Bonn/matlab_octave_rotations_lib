% EulerNoFYaw.m - Philipp Allgeuer - 30/06/14
% Removes the fused yaw component of a ZYX Euler rotation
function [Eout, FYaw] = EulerNoFYaw(Ein)
	FYaw = FYawOfEuler(Ein);
	Eout = [Ein(1)-FYaw Ein(2:3)];
end
% EOF