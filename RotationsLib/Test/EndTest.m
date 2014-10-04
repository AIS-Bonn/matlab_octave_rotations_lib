% EndTest.m - Philipp Allgeuer - 01/07/14
% Function to be called at the conclusion of an individual test.
% Individual tests are intended to be combined into test scripts.
% Each individual test should return PASS/true (on completion), if the test is successful.
%
% function Pass = EndTest(Tol, varargin)
%
% INPUTS
% Tol:      The numerical bound below which errors in this test are acceptable
% varargin: Variable number of error arrays (column vectors or matrices) to display and check
%           The order is 'name1', Err1, 'name2', Err2,...
%
% OUTPUTS
% Pass: Boolean flag whether this test was passed
%

% Main function
function Pass = EndTest(Tol, varargin)

	% Default tolerance value
	if nargin < 1 || Tol <= 0
		Tol = 128*eps;
	end
	
	% Print the error statistics and see whether the test was passed
	Pass = true;
	for k = 1:2:(nargin-2)
		Pass = Pass & PrintErrStats(varargin{k+1},varargin{k}, Tol);
	end
	
	% Stop timing
	toc;
	printf('\n');
	
	% Flush the printed output to the screen
	fflush(stdout);

end
% EOF