% BeginTestScript.m - Philipp Allgeuer - 01/07/14
% Function to be called at the beginning of a test script.
% Each test script may contain a multitude of individual tests.
% If each individual test returns PASS/true, then the entire test script returns PASS/true.
%
% function [Pass, Nnormal, Nlarge, Nsmall] = BeginTestScript(Title, N, Tol)
%
% INPUTS
% Title:   The name to use for this test script
% N:       The nominal number of test cases to use in each individual test
% Tol:     The nominal numerical bound below which errors are acceptable
%
% OUTPUTS
% Pass:    A pass flag to use that has been already initialised to true (use as Pass = Pass & EndTest(...))
% Nnormal: The number of test cases to use for normal tests
% Nlarge:  The number of test cases to use for fast tests
% Nsmall:  The number of test cases to use for slow tests
%

% Main function
function [Pass, Nnormal, Nlarge, Nsmall] = BeginTestScript(Title, N, Tol)

	% Print header
	printf('======================================================================\n');
	printf('TEST SCRIPT: %s\n', Title);
	printf('N = %d\n',N);
	printf('Tol = %.3e\n',Tol);
	printf('\n');
	
	% Work out the various options for N
	Nlarge = max(round(10*N),5);
	Nnormal = max(round(N),5);
	Nsmall = max(round(N/10),5);
	
	% Initialise the pass flag
	Pass = true;

end
% EOF