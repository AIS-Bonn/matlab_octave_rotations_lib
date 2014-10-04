% ComposeFused.m - Philipp Allgeuer - 28/06/14
% Composes multiple fused angles rotations and returns the equivalent total rotation.
% The rotations are applied right to left, that is, ComposeFused(F3,F2,F1) returns the rotation
% given by applying F1 then F2 then F3.
function [Fout, Rout] = ComposeFused(varargin)
	Num = length(varargin);
	if Num <= 0
		Fout = [0 0 0 1];
		Rout = eye(3);
	elseif Num == 1
		Fout = varargin{1};
		Rout = RotmatFromFused(Fout);
	else
		Rout = RotmatFromFused(varargin{1});
		for k = 2:Num
			F = varargin{k};
			if numel(F) ~= 4
				warning('Ignoring an invalid rotation parameter!');
				continue;
			end
			Rout = Rout * RotmatFromFused(F);
		end
		Fout = FusedFromRotmat(Rout);
	end
end
% EOF