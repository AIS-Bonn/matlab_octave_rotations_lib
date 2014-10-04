% ComposeRotmat.m - Philipp Allgeuer - 28/06/14
% Composes multiple rotation matrices and returns the equivalent total rotation.
% The rotations are applied right to left, that is, ComposeRotmat(R3,R2,R1) returns the rotation
% given by applying R1 then R2 then R3.
function Rout = ComposeRotmat(varargin)
	Num = length(varargin);
	if Num <= 0
		Rout = eye(3);
	else
		Rout = varargin{1};
		for k = 2:Num
			R = varargin{k};
			if size(R,1) ~= 3 || size(R,2) ~= 3
				warning('Ignoring an invalid rotation parameter!');
				continue;
			end
			Rout = Rout * R;
		end
	end
end
% EOF