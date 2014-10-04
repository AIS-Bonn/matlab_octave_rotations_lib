% EndBoolean.m - Philipp Allgeuer - 01/07/14
% Convenience function for testing boolean conditions
% The value of the B input (passed unmodified out of the function) should be a boolean specifying
% whether all boolean conditions were true in a test.
%
% function B = EndBoolean(B)
%

% Main function
function B = EndBoolean(B)

	% Print a message whether the boolean conditions were satisfied
	if B
		printf('All boolean conditions passed!                                * PASS *\n');
	else
		printf('Failed due to boolean conditions!                             * FAIL *\n');
	end
	printf('\n');

end
% EOF