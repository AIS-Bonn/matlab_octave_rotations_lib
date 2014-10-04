% PrintErrStats.m - Philipp Allgeuer - 01/07/14
% Prints statistics about an error array that was generated as part of a test item (constituent of an individual test)
% If all of the errors are below the specified tolerance in absolute terms, the test item is declared as passed.
%
% Pass = PrintErrStats(Err, Title, Tol)
%
% INPUTS
% Err:   The error data to print the statistics for
% Title: The name to use for this test item
% Tol:   The numerical bound below which errors are acceptable
%
% OUTPUTS
% Pass: Boolean flag whether this test item was passed
%

% Main function
function Pass = PrintErrStats(Err, Title, Tol)

	% Default tolerance value
	if nargin < 3
		Tol = 128*eps;
	end
	
	% Initialise the pass flag
	Pass = false;
	
	% Print header for the results
	printf('TEST ITEM: %s\n', Title);
	
	% Ensure that error data is actually available
	if size(Err,1) < 2
		printf('WARNING: No error data was available (need >1 rows)!          * FAIL *\n');
		return;
	end
	
	% Calculate the error maxima and minima
	abserr = abs(Err);
	absmin = min(abserr);
	absmax = max(abserr);
	maxabsmax = max(absmax);
	
	% Evaluate the pass criterion
	Pass = (maxabsmax <= Tol);
	if Pass
		str = 'PASS';
	else
		str = 'FAIL';
	end
	
	% Print the error maxima and minima, and whether the test was passed
	printf('Err     minimum: %s\n', sprintf('%11.3e ',min(Err)));
	printf('Err     maximum: %s\n', sprintf('%11.3e ',max(Err)));
	printf('Err abs minimum: %s\n', sprintf('%11.3e ',absmin));
	printf('Err abs maximum: %s <--- ABS MAX:  %11.3e      * %s *\n', sprintf('%11.3e ',absmax),maxabsmax,str);
	
	% Partition the error values into logarithmically spaced bins
	bins = [0 10.^(-15:0) Inf];
	count = histc(abserr,bins,1);
	while all(count(end,:) == 0)
		count(end,:) = [];
	end
	bincumul = cumsum(count,1);
	
	% Issue warnings if we detect infinite and/or NaN values
	total = size(Err,1);
	if ~all(isfinite(Err))
		printf('WARNING: There are non-finite values in the array!\n');
	end
	if any(bincumul(end,:) ~= total)
		printf('WARNING: Sums don''t match => There be NaNs!\n');
	end
	
	% Print out a list of the error bins and the corresponding exceedance frequencies
	printf('Less than %5.0e:   %s\n', bins(2), sprintf('%d  ',bincumul(1,:)));
	for k = 1:size(bincumul,1)
		if k+1 <= numel(bins)
			printf('More than %5.0e:   %s\n', bins(k+1), sprintf('%d  ',total-bincumul(k,:)));
		end
	end
	printf('\n');

end
% EOF