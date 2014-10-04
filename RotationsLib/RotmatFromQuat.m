% RotmatFromQuat.m - Philipp Allgeuer - 07/03/14
% Converts a quaternion orientation into a rotation matrix
%
% function Rotmat = RotmatFromQuat(Quat)
%

% Main function
function Rotmat = RotmatFromQuat(Quat)

	% Data aliases
	w = Quat(1);
	x = Quat(2);
	y = Quat(3);
	z = Quat(4);

	% Construct the required rotation matrix (assuming the quaternion is normalised)
	Rotmat = [1-2*(y*y+z*z)  2*(x*y-z*w)   2*(x*z+y*w) ;
	           2*(x*y+z*w)  1-2*(x*x+z*z)  2*(y*z-x*w) ;
	           2*(x*z-y*w)   2*(y*z+x*w)  1-2*(x*x+y*y)];

end
% EOF