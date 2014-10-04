% QuatInv.m - Philipp Allgeuer - 07/03/14
% Calculates the inverse rotation of a quaternion
function Qinv = QuatInv(Q)
	Qinv = [Q(1) -Q(2:4)];
end
% EOF