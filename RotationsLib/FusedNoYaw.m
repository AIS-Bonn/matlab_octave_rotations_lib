% FusedNoYaw.m - Philipp Allgeuer - 30/06/14
% Removes the Euler ZYX yaw component of a fused angles rotation
% This function goes via rotation matrices as fused angles by nature use fused yaw, and not yaw,
% and so there is no easy direct way of zeroing out the yaw component.
function [Fout, Rout, yaw, Ryaw, Rin] = FusedNoYaw(Fin)
	Rin = RotmatFromFused(Fin);
	[Rout, yaw, Ryaw] = RotmatNoYaw(Rin);
	Fout = FusedFromRotmat(Rout);
end
% EOF