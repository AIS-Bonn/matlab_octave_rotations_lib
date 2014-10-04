% LoadRotations.m - Philipp Allgeuer - 01/07/14
% Add the Rotations Library directory to the working path
disp('');
disp('Loading Rotations Library v1.0.1...');
ScriptPath = [pwd '/LoadRotations.m'];
if exist(ScriptPath,'file') ~= 2
	disp('Error: Could not find the path to the LoadRotations.m script');
	disp('Note:  This script is intended for execution using ''run path/to/LoadRotations.m''');
	disp('       or when the script is in the current working directory.');
	disp('Nothing was changed.');
else
	disp(['Adding path: ' pwd]);
	addpath(pwd);
	disp('Done.');
end
disp('');
% EOF