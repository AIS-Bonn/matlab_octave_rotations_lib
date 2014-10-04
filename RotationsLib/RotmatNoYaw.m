% RotmatNoYaw.m - Philipp Allgeuer - 14/02/14
% Removes the Euler ZYX yaw component of a rotation matrix
function [Rout, yaw, Ryaw] = RotmatNoYaw(Rin)
	yaw = atan2(Rin(2,1),Rin(1,1));
	cyaw = cos(yaw);
	syaw = sin(yaw);
	Ryaw = [cyaw -syaw 0;syaw cyaw 0;0 0 1];
	Rout = Ryaw' * Rin;
end
% EOF