% TiltFromAxis.m - Philipp Allgeuer - 05/11/14
% Constructs a tilt angles rotation based on an axis-angle specification.
%
% function [Tilt, Quat] = TiltFromAxis(Axis, Angle)
%
% Axis  ==> The vector corresponding to the axis of rotation (magnitude is unimportant)
%           either given as the vector [ux uy uz] or one of {'x', 'y', 'z'}
% Angle ==> The angle of the rotation given by the right hand rule
% Tilt  ==> Equivalent tilt angles rotation
% Quat  ==> Equivalent quaternion rotation

% Main function
function [Tilt, Quat] = TiltFromAxis(Axis, Angle)

	% Handle case of missing arguments
	if nargin < 2
		Tilt = [0 0 0];
		Quat = [1 0 0 0];
		return;
	end
	
	% Wrap the rotation angle to (-pi,pi]
	Angle = pi - mod(pi - Angle, 2*pi);
	
	% Precompute the required sin and cos terms
	hcang = cos(0.5*Angle);
	hsang = sin(0.5*Angle);
	
	% Handle case of standard axis rotations
	if strcmpi(Axis, 'x')
		if Angle >= 0
			Tilt = [0 0 Angle];
		else
			Tilt = [0 pi -Angle];
		end
		Quat = [hcang hsang 0 0];
		return;
	elseif strcmpi(Axis, 'y')
		if Angle >= 0
			Tilt = [0 pi/2 Angle];
		else
			Tilt = [0 -pi/2 -Angle];
		end
		Quat = [hcang 0 hsang 0];
		return;
	elseif strcmpi(Axis, 'z')
		Tilt = [Angle 0 0];
		Quat = [hcang 0 0 hsang];
		return;
	end
	
	% Axis error checking
	if ~(isnumeric(Axis) && isvector(Axis) && length(Axis) == 3)
		error('Axis must be a 3-vector, or one of {''x'',''y'',''z''}.');
	end
	
	% Normalise the axis vector
	AxisNorm = norm(Axis);
	if AxisNorm <= 0
		Tilt = [0 0 0]; % Return the identity rotation if Axis is the zero vector
		Quat = [1 0 0 0];
		return;
	else
		Axis = Axis/AxisNorm;
	end
	
	% Construct the required rotation
	Quat = [hcang hsang*Axis(:)'];
	Tilt = TiltFromQuat(Quat);

end
% EOF