% TestRand.m - Philipp Allgeuer - 01/07/14
% Tests: Rand*
% Assumed: None
%
% function Pass = TestRand(N, Tol, Inter)
%

% Main function
function Pass = TestRand(N, Tol, Inter)

	% Process function inputs
	if nargin < 1 || ~isscalar(N) || N < 1
		N = 1000000;
	end
	N = round(N);
	if nargin < 2 || Tol <= 0
		Tol = 128*eps;
	end
	Tol = abs(Tol);
	if nargin < 3
		Inter = false;
	end

	% Begin test script
	[P, Nnormal] = BeginTestScript('TestRand',N,Tol);
	Ntiny = max(round(Nnormal/500),5);

	%
	% Test RandVec
	%

	% Begin testing
	N = BeginTest('RandVec',Nnormal);
	B = BeginBoolean();

	% Generate random vectors
	V = RandVec(N,3.0);

	% Range checking
	B = TestRanges(B, V', N, 3, [-3 -3 -3], [3 3 3]);

	% Check the vector 2-norm is in range
	Mag = sqrt(V(1,:).^2+V(2,:).^2+V(3,:).^2);
	B = B && all(Mag >= 0) && all(Mag <= 3);
	
	% Human checking
	printf('Min mag:   0.0 => %.3g\n'  , min(Mag));
	printf('Mean mag:  1.5 => %.3g\n'  , mean(Mag));
	printf('Max mag:   3.0 => %.3g\n\n', max(Mag));

	% End testing
	P = P & EndBoolean(B);
	P = P & EndTest();

	%
	% Test RandRotmat
	%
	
	% Begin testing
	[N,ErrA] = BeginTest('RandRotmat',Ntiny);
	B = BeginBoolean();
	
	% Generate a set of random rotations
	R = RandRotmat(N);
	D = zeros(N,9);
	for k = 1:N
		D(k,:) = R(:,:,k)(:)';
	end

	% Range checking
	B = TestRanges(B, D, N, 9, -ones(1,9), ones(1,9));
	
	% Check that the rotation matrices are valid by re-orthogonalising them and seeing if they stay the same
	for k = 1:N
		T = R(:,:,k);
		U = T/sqrtm(T'*T);
		ErrA(k) = norm(U-T);
	end

	% End testing
	P = P & EndBoolean(B);
	P = P & EndTest(Tol, 'Orthogonality', ErrA);

	%
	% Test RandQuat
	%
	
	% Begin testing
	[N,ErrA] = BeginTest('RandQuat',Nnormal);
	B = BeginBoolean();
	
	% Generate a set of random rotations
	D = RandQuat(N);

	% Range checking
	B = TestRanges(B, D, N, 4, -ones(1,4), ones(1,4));
	
	% Check the quaternion norm
	ErrA = sqrt(D(:,1).^2 + D(:,2).^2 + D(:,3).^2 + D(:,4).^2) - 1.0;

	% End testing
	P = P & EndBoolean(B);
	P = P & EndTest(Tol, 'Unit norm', ErrA);

	%
	% Test RandEuler
	%
	
	% Begin testing
	N = BeginTest('RandEuler',Nnormal);
	B = BeginBoolean();
	
	% Generate a set of random rotations
	D = RandEuler(N);

	% Range checking
	B = TestRanges(B, D, N, 3, [-pi -pi/2 -pi], [pi pi/2 pi]);

	% End testing
	P = P & EndBoolean(B);
	P = P & EndTest();

	%
	% Test RandFused
	%
	
	% Begin testing
	N = BeginTest('RandFused',Nnormal);
	B = BeginBoolean();
	
	% Generate a set of random rotations
	D = RandFused(N);

	% Range checking
	B = TestRanges(B, D, N, 4, [-pi -pi/2 -pi/2 -1], [pi pi/2 pi/2 1]);
	B = B && all((D(:,4) == 1) | (D(:,4) == -1));
	
	% Test the validity criterion
	crit = sin(D(:,2)).^2 + sin(D(:,3)).^2;
	B = B && all(crit >= 0.0) && all(crit <= 1.0);

	% End testing
	P = P & EndBoolean(B);
	P = P & EndTest();

	%
	% Test RandTilt
	%
	
	% Begin testing
	N = BeginTest('RandTilt',Nnormal);
	B = BeginBoolean();
	
	% Generate a set of random rotations
	D = RandTilt(N);

	% Range checking
	B = TestRanges(B, D, N, 3, [-pi -pi 0], [pi pi pi]);

	% End testing
	P = P & EndBoolean(B);
	P = P & EndTest();
	
	%
	% Interactive testing
	%
	
	% Run the interactive testing component
	if Inter
		BeginTest('Interactive');
		B = BeginBoolean();
		B = B & TestRandInter();
		P = P & EndBoolean(B);
		P = P & EndTest();
	end
	
	%
	% End of test script
	%

	% End test script
	EndTestScript('TestRand',P);

	% Set the output pass flag
	if nargout >= 1
		Pass = P;
	end

end

% Interactive testing component
function P = TestRandInter()

	% Initialise variables
	P = true;
	h = [];

	% Rand fused angle plots
	D = RandFused(10000);
	
	% Fused yaw plot
	h = [h figure()];
	hist(D(:,1),30);
	title('RandFused: Fused yaw');
	xlabel('Fused yaw');
	ylabel('Count');
	grid on;
	
	% Fused roll/pitch plot
	h = [h figure()];
	plot(D(:,2),D(:,3),'b.');
	title('RandFused: Fused roll vs Fused pitch');
	xlabel('Fused pitch');
	ylabel('Fused roll');
	grid on;
	
	% Wait for the user to appreciate the interactive testing
	printf('Press enter to close any opened figures and continue...');
	pause();
	printf('\n');
	close(h);

end

% Function to test ranges
function B = TestRanges(B, D, N, ElemSize, LBnd, UBnd)

	% Boolean conditions
	B = B && all(size(D) == [N ElemSize]);
	B = B && all(D >= repmat(LBnd,N,1)) && all(D <= repmat(UBnd,N,1));

	% Human checking
	printf('Minimums:   %s\n'  ,sprintf('%10.4g ',min(D)));
	printf('Should be:  %s\n\n',sprintf('%10.4g ',LBnd));
	printf('Means:      %s\n'  ,sprintf('%10.4g ',mean(D)));
	printf('Should be:  %s\n\n',sprintf('%10.4g ',0.5*(LBnd+UBnd)));
	printf('Maximums:   %s\n'  ,sprintf('%10.4g ',max(D)));
	printf('Should be:  %s\n\n',sprintf('%10.4g ',UBnd));

end
% EOF