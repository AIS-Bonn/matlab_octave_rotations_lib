% BeginTest.m - Philipp Allgeuer - 01/07/14
% Function to be called at the beginning of an individual test.
% Individual tests are intended to be combined into test scripts.
% Each individual test should return PASS/true (on completion), if the test is successful.
%
% function [N, varargout] = BeginTest(Title, N, ErrSize)
%
% INPUTS
% Title:   The name to use for this test
% N:       The number of test cases to use in the test
% ErrSize: A vector of zero-initialised error array sizes to be generated
%
% OUTPUTS
% N:         The number of test cases to use in the test (unmodified from the input)
% varargout: The zero-initialised error arrays (column vectors) requested via the ErrSize input.
%            If more outputs are present than numel(ErrSize), the additional arrays default to
%            being of length N.
%

% Main function
function [N, varargout] = BeginTest(Title, N, ErrSize)

	% Start timing
	tic;
	
	% Print a test header
	printf('----------------------------------------------------------------------\n');
	printf('TEST: %s\n\n', Title);
	
	% Initialise the required error vectors with zeros
	if nargin >= 2
		N = round(N);
	end
	if nargin < 3
		ErrSize = [];
	end
	for k = 1:(nargout-1)
		if k <= numel(ErrSize)
			varargout{k} = zeros(ErrSize(k),1);
		else
			varargout{k} = zeros(N,1);
		end
	end
	
	% Flush the printed output to the screen
	fflush(stdout);

end
% EOF