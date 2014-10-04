% FusedInv.m - Philipp Allgeuer - 28/06/14
% Calculates the inverse rotation of a fused angles rotation (fused yaw, fused pitch, fused roll, hemisphere)
function Finv = FusedInv(F)
	Finv = FusedFromRotmat(RotmatFromFused(F)'); % There's pretty much no way to be more efficient than going via a rotation matrix...
end
% EOF