% RotmatRotVec.m - Philipp Allgeuer - 10/03/14
% Rotate a vector by a given rotation matrix
function vout = RotmatRotVec(Rotmat, vin)
	vout = zeros(size(vin));
	vout(:) = Rotmat * vin(:);
end
% EOF