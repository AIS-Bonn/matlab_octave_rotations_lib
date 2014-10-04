% EulerFromFused.m - Philipp Allgeuer - 30/06/14
% Converts fused angles to the corresponding ZYX Euler angles
%
% The output ranges are:
% Yaw:   psi   is in (-pi,pi]
% Pitch: theta is in [-pi/2,pi/2]
% Roll:  phi   is in (-pi,pi]
%
% function [Euler, Rotmat, Tilt] = EulerFromFused(Fused)
%

% Main function
function [Euler, Rotmat, Tilt] = EulerFromFused(Fused)
	[Rotmat, Tilt] = RotmatFromFused(Fused);
	Euler = EulerFromRotmat(Rotmat);
	Euler(2) = Fused(2); % Fused pitch is equivalent to ZYX Euler pitch!
end
% EOF