% EndTestScript.m - Philipp Allgeuer - 01/07/14
% Function to be called at the conclusion of a test script.
% Each test script may contain a multitude of individual tests.
% If each individual test returns PASS/true, then the entire test script returns PASS/true.
%
% function EndTestScript(Title, Pass)
%
% INPUTS
% Title: The name to use for this test script
% Pass:  Boolean flag specifying whether all the individual tests were passed
%

% Main function
function EndTestScript(Title, Pass)

	% Print a summary of the test script results
	printf('----------------------------------------------------------------------\n');
	printf('TEST SCRIPT: %s\n', Title);
	if Pass
		printf('Total result: * PASS *\n');
	else
		printf('Total result: * FAIL *\n');
	end
	printf('Completed!\n');
	printf('\n');

end
% EOF