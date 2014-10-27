% QuatFromTilt.m - Philipp Allgeuer - 22/10/14
% Converts a tilt angles rotation to the corresponding quaternion representation.
%
% function [Quat] = QuatFromTilt(Tilt)
%
% The output quaternion is in the format [w x y z].
%
% Tilt ==> Input tilt angles rotation
% Quat ==> Equivalent quaternion rotation

% Main function
function [Quat] = QuatFromTilt(Tilt)

	% Evaluate the required intermediate angles
	hpsi = 0.5*Tilt(1);
	halpha = 0.5*Tilt(3);
	hgampsi = Tilt(2) + hpsi;
	
	% Precalculate trigonometric terms involved in the quaternion expression
	chpsi = cos(hpsi);
	shpsi = sin(hpsi);
	chalpha = cos(halpha);
	shalpha = sin(halpha);
	chgampsi = cos(hgampsi);
	shgampsi = sin(hgampsi);
	
	% Calculate the required quaternion
	Quat = [chalpha*chpsi shalpha*chgampsi shalpha*shgampsi chalpha*shpsi];

end
% EOF