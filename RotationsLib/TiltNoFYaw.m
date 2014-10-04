% TiltNoFYaw.m - Philipp Allgeuer - 30/06/14
% Removes the fused yaw component of a tilt angles rotation
function Tout = TiltNoFYaw(Tin)
	Tout = [0 Tin(2:3)];
end
% EOF