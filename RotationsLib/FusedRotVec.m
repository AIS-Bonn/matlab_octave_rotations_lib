% FusedRotVec.m - Philipp Allgeuer - 28/06/14
% Rotate a vector by a given fused angles rotation
function vout = FusedRotVec(Fused, vin)
	vout = zeros(size(vin));
	vout(:) = RotmatFromFused(Fused) * vin(:);
end
% EOF