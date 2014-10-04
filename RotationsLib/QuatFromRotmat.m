% QuatFromRotmat.m - Philipp Allgeuer - 10/03/14
% Converts a rotation matrix to the corresponding quaternion rotation.
% Note that Quat and -Quat are both valid and completely equivalent outputs here,
% so we have the freedom to arbitrarily choose the sign of *one* of the quaternion
% parameters during the conversion. At the end of the conversion we then change the
% sign of the whole quaternion so that the w component is non-negative.
%
% function Quat = QuatFromRotmat(Rotmat)
%

% Main function
function Quat = QuatFromRotmat(Rotmat)

	% Perform the conversion
	t = trace(Rotmat);
	if t >= 0.0
		r = sqrt(1+t);
		s = 0.5/r;
		Quat = [0.5*r s*(Rotmat(3,2)-Rotmat(2,3)) s*(Rotmat(1,3)-Rotmat(3,1)) s*(Rotmat(2,1)-Rotmat(1,2))];
	elseif Rotmat(3,3) >= Rotmat(2,2) && Rotmat(3,3) >= Rotmat(1,1)
		r = sqrt(1 - Rotmat(1,1) - Rotmat(2,2) + Rotmat(3,3));
		s = 0.5/r;
		Quat = [s*(Rotmat(2,1)-Rotmat(1,2)) s*(Rotmat(1,3)+Rotmat(3,1)) s*(Rotmat(3,2)+Rotmat(2,3)) 0.5*r];
	elseif Rotmat(2,2) >= Rotmat(1,1)
		r = sqrt(1 - Rotmat(1,1) + Rotmat(2,2) - Rotmat(3,3));
		s = 0.5/r;
		Quat = [s*(Rotmat(1,3)-Rotmat(3,1)) s*(Rotmat(2,1)+Rotmat(1,2)) 0.5*r s*(Rotmat(3,2)+Rotmat(2,3))];
	else
		r = sqrt(1 + Rotmat(1,1) - Rotmat(2,2) - Rotmat(3,3));
		s = 0.5/r;
		Quat = [s*(Rotmat(3,2)-Rotmat(2,3)) 0.5*r s*(Rotmat(2,1)+Rotmat(1,2)) s*(Rotmat(1,3)+Rotmat(3,1))];
	end

	% Make sure that the w component is non-negative
	if Quat(1) < 0
		Quat = -Quat;
	end

end
% EOF