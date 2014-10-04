% ComposeEuler.m - Philipp Allgeuer - 10/03/14
% Composes multiple ZYX Euler angle rotations and returns the equivalent total rotation.
% The rotations are applied right to left, that is, ComposeEuler(E3,E2,E1) returns the rotation
% given by applying E1 then E2 then E3.
function [Eout, Rout] = ComposeEuler(varargin)
	Num = length(varargin);
	if Num <= 0
		Eout = [0 0 0];
		Rout = eye(3);
	elseif Num == 1
		Eout = varargin{1};
		Rout = RotmatFromEuler(Eout);
	else
		Rout = RotmatFromEuler(varargin{1});
		for k = 2:Num
			E = varargin{k};
			if numel(E) ~= 3
				warning('Ignoring an invalid rotation parameter!');
				continue;
			end
			Rout = Rout * RotmatFromEuler(E);
		end
		Eout = EulerFromRotmat(Rout);
	end
end
% EOF