% RunTests.m - Philipp Allgeuer - 01/07/14
% Run all test scripts that we know about for the Rotations Library
% If a test script fails, the remaining test scripts are still executed.
%
% function Pass = RunTests(Speed)
%
% INPUTS
% Speed: One of 'Fast', 'Normal', 'Slow' or 'Ultraslow' (string variable)
% Inter: Boolean flag whether to run interactive tests
%
% OUTPUTS
% Pass: Boolean flag specifying whether all tests were passed
%
% This function executes a collection of test scripts, each containing some number of
% individual tests. The number of test cases for each script should be kept to a number
% such that, as a rule of thumb, each of the tests that constitute a test script take
% approximately 10s to execute in normal speed mode.
%

% Main function
function Pass = RunTests(Speed, Inter)

	% Process input parameters
	if nargin < 1
		Speed = 'Normal';
	end
	if nargin < 2 || ~isscalar(Inter) || ~islogical(Inter)
		Inter = false;
	end

	% Process speed parameter
	switch Speed
		case 'Fast'
			S = 1;
		case 'Normal'
			S = 5;
		case 'Slow'
			S = 20;
		case 'Ultraslow'
			S = 50;
		otherwise
			error('Unrecognised speed parameter!');
	end

	% Print a header
	printf('######################################################################\n');
	printf('##################  Rotations Library => Run Tests  ##################\n');
	printf('######################################################################\n');
	printf('Speed: %s\n',Speed);
	if Inter
		printf('Interactive tests: True\n');
	else
		printf('Interactive tests: False\n');
	end
	printf('\n');

	% Initialise the pass flag
	P = true;

	% Initialise the error tolerances to choose from
	LTol = 512*eps;
	MTol = 128*eps;
	HTol = 32*eps;

	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  Start of testing  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

	% Tests: Rand*
	% Assumed: None
	P = P & TestRand(1000000*S,MTol,Inter);

	% Tests: Compose*
	% Assumed: Rand*, *Equal, RotmatFrom*, *FromRotmat
	P = P & TestCompose(500*S,HTol,Inter);

	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  End of testing  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

	% Convert the pass flag into a string
	if P
		PStr = 'PASS';
	else
		PStr = 'FAIL';
	end

	% Summarise the test results
	printf('######################################################################\n');
	printf('###########  End of Rotations Library testing => * %s *  ###########\n', PStr);
	printf('######################################################################\n');
	printf('\n');

	% Set the output pass flag
	if nargout >= 1
		Pass = P;
	end

end
% EOF