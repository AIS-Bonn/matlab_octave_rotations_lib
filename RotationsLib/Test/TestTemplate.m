% TESTTEMPLATE.m - Philipp Allgeuer - DATE
% Tests: FUNCTION_LIST1
% Assumed: FUNCTION_LIST2
%
% function Pass = TESTTEMPLATE(N, Tol)
%

% Main function
function Pass = TESTTEMPLATE(N, Tol)

	% Process function inputs
	if nargin < 1 || ~isscalar(N) || N < 1
		N = 100;
	end
	N = round(N);
	if nargin < 2
		Tol = 128*eps;
	end
	Tol = abs(Tol);

	% Begin test script
	[P, Nnormal] = BeginTestScript('TESTTEMPLATE',N,Tol);

	% Generate random test rotations
	BeginTest('Rotation generation');
	printf('Generating random rotations for the subsequent tests...\n');
	GENERATE_REQUIRED_ROTATIONS;
	P = P & EndTest();

	% Test FUNCTION
	[N,ErrA,ErrB] = BeginTest('FUNCTION',Nnormal,[]);
	TEST_FUNCTION;
	P = P & EndTest(Tol,'TESTITEM1',ErrA,'TESTITEM2',ErrB);

	% End test script
	EndTestScript('TESTTEMPLATE',P);

	% Set the output pass flag
	if nargout >= 1
		Pass = P;
	end

end
% EOF