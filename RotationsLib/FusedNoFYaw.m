% FusedNoFYaw.m - Philipp Allgeuer - 28/06/14
% Removes the fused yaw component of a fused angles rotation
function Fout = FusedNoFYaw(Fin)
	Fout = [0 Fin(2:4)];
end
% EOF