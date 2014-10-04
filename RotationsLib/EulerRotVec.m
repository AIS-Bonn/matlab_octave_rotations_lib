% EulerRotVec.m - Philipp Allgeuer - 10/03/14
% Rotate a vector by a given ZYX Euler rotation
function vout = EulerRotVec(Euler, vin)
	vout = zeros(size(vin));
	vout(:) = RotmatFromEuler(Euler) * vin(:);
end
% EOF