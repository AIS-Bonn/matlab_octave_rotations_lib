% QuatRotVec.m - Philipp Allgeuer - 10/03/14
% Rotate a vector by a given quaternion.
% The input quaternion is assumed to be of unit norm.
function vout = QuatRotVec(Quat, vin)
	vout = zeros(size(vin));
	vin = vin(:)';
	vout(:) = (Quat(1)*Quat(1) - Quat(2)*Quat(2) - Quat(3)*Quat(3) - Quat(4)*Quat(4))*vin + 2*dot(Quat(2:4),vin)*Quat(2:4) + 2*Quat(1)*cross(Quat(2:4),vin);
end
% EOF