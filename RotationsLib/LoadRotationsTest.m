% LoadRotationsTest.m - Philipp Allgeuer - 01/07/14
% Add the Rotations Library test directory to the working path
disp('');
disp('Loading Rotations Library Test v1.0.1...');
ScriptPath = [pwd '/LoadRotationsTest.m'];
TestPath = [pwd '/Test'];
if exist(ScriptPath,'file') ~= 2
	disp('Error: Could not find the path to the LoadRotationsTest.m script');
	disp('Note:  This script is intended for execution using ''run path/to/LoadRotationsTest.m''');
	disp('       or when the script is in the current working directory.');
	disp('Nothing was changed.');
elseif exist(TestPath,'dir') ~= 7
	disp(['Error: Test folder not found at ' TestPath]);
	disp('Nothing was changed.');
else
	disp(['Adding path: ' pwd]);
	addpath(pwd);
	disp(['Adding path: ' TestPath]);
	addpath(TestPath);
	disp('Done.');
end
disp('');
% EOF