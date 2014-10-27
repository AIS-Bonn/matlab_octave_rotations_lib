% RunAllTests.m - Philipp Allgeuer - 22/10/14
% Run all available/known test scripts of the Rotations Library.
%
% function [Pass] = RunAllTests(Speed, Inter)
%
% This function executes a collection of test scripts (e.g. TestRand, TestCompose, etc),
% each containing some number of individual tests. The number of test cases N used for
% each individual test script should be kept to a number such that, as a rule of thumb,
% each of the tests that constitute a test script take approximately 10s to execute in
% normal speed mode, or quicker if time is not a constraint in a particular test. If a
% test script fails then all remaining test scripts are still executed.
%
% Speed ==> One of 'Fast', 'Normal', 'Slow' or 'Ultraslow' (string)
% Inter ==> Boolean flag whether to also run interactive tests
% Pass  ==> Boolean flag whether all tests were passed

% Main function
function [Pass] = RunAllTests(Speed, Inter)

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
	fprintf('######################################################################\n');
	fprintf('##################  Rotations Library => Run Tests  ##################\n');
	fprintf('######################################################################\n');
	fprintf('Speed: %s\n',Speed);
	if Inter
		fprintf('Interactive tests: True\n');
	else
		fprintf('Interactive tests: False\n');
	end
	fprintf('\n');

	% Initialise the pass flag
	P = true;

	% Error tolerances to choose from for each test script
	LTol = 512*eps;
	MTol = 128*eps;
	HTol = 32*eps;

	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  Start of testing  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

	% Tests:   Rand*, RandAng, RandVec, RandUnitVec
	% Assumes: None
	P = P & TestRand(1000000*S, MTol, Inter);

	% Tests:   Compose*
	% Assumes: Rand*, *Equal, RotmatFrom*, *FromRotmat
	P = P & TestCompose(500*S, HTol, Inter);

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
	fprintf('######################################################################\n');
	fprintf('###########  End of Rotations Library testing => * %s *  ###########\n', PStr);
	fprintf('######################################################################\n');
	fprintf('\n');

	% Set the output pass flag
	if nargout >= 1
		Pass = P;
	end

end
% EOF