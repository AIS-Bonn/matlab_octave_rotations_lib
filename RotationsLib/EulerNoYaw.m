% EulerNoYaw.m - Philipp Allgeuer - 07/03/14
% Removes the ZYX yaw component of a ZYX Euler rotation
function Eout = EulerNoYaw(Ein)
	Eout = [0 Ein(2:3)];
end
% EOF