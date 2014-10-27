% TestCompose.m - Philipp Allgeuer - 22/10/14
% Tests:   Compose*
% Assumes: Rand*, *Equal, RotmatFrom*, *FromRotmat
%
% function [Pass] = TestCompose(N, Tol, Inter)
%
% N     ==> Number of test cases to use in each test
% Tol   ==> Numeric tolerance to use for testing
% Inter ==> Boolean flag whether to also run interactive tests
% Pass  ==> Boolean flag whether all tests were passed

% Main function
function [Pass] = TestCompose(N, Tol, Inter)

	% Process function inputs
	if nargin < 1 || ~isscalar(N) || N < 1
		N = 500;
	end
	N = round(N);
	if nargin < 2 || Tol <= 0
		Tol = 128*eps;
	end

	% Begin test script
	[P, Nnormal, Nlarge] = BeginTestScript('TestCompose', N, Tol);

	%
	% Rotation generation
	%
	
	% Begin test
	BeginTest('Rotation generation');
	
	% Print message to user
	fprintf('Generating random rotations for the subsequent tests...\n');
	
	% Generate random test rotations
	Ea = RandEuler(Nnormal);
	Eb = RandEuler(Nnormal);
	Ec = RandEuler(Nnormal);
	Fa = RandFused(Nnormal);
	Fb = RandFused(Nnormal);
	Fc = RandFused(Nnormal);
	Qa = RandQuat(Nnormal);
	Qb = RandQuat(Nnormal);
	Qc = RandQuat(Nnormal);
	Ra = RandRotmat(Nlarge);
	Rb = RandRotmat(Nlarge);
	Rc = RandRotmat(Nlarge);
	Ta = RandTilt(Nnormal);
	Tb = RandTilt(Nnormal);
	Tc = RandTilt(Nnormal);
	
	% End test
	P = P & EndTest();
	
	%
	% Test ComposeEuler
	%
	
	% Begin test
	[N, ErrA, ErrB] = BeginTest('ComposeEuler', Nnormal);
	B = BeginBoolean();
	
	% Boolean conditions
	B = B && all(ComposeEuler() == [0 0 0]);
	B = B && all(ComposeEuler(Ea(1,:)) == Ea(1,:));
	B = B && all(ComposeEuler(Eb(1,:)) == Eb(1,:));
	
	% Calculate composition errors
	for k = 1:N
		REa = RotmatFromEuler(Ea(k,:));
		REb = RotmatFromEuler(Eb(k,:));
		REc = RotmatFromEuler(Ec(k,:));
		[~, ErrA(k)] = EulerEqual(ComposeEuler(Ea(k,:),Eb(k,:)), EulerFromRotmat(REa*REb));
		[~, ErrB(k)] = EulerEqual(ComposeEuler(Ea(k,:),Eb(k,:),Ec(k,:)), EulerFromRotmat(REa*REb*REc));
	end
	
	% End test
	P = P & EndBoolean(B);
	P = P & EndTest(Tol, '2 arguments', ErrA, '3 arguments', ErrB);
	
	%
	% Test ComposeFused
	%
	
	% Begin test
	[N, ErrA, ErrB] = BeginTest('ComposeFused', Nnormal);
	B = BeginBoolean();
	
	% Boolean conditions
	B = B && all(ComposeFused() == [0 0 0 1]);
	B = B && all(ComposeFused(Fa(1,:)) == Fa(1,:));
	B = B && all(ComposeFused(Fb(1,:)) == Fb(1,:));
	
	% Calculate composition errors
	for k = 1:N
		RFa = RotmatFromFused(Fa(k,:));
		RFb = RotmatFromFused(Fb(k,:));
		RFc = RotmatFromFused(Fc(k,:));
		[~, ErrA(k)] = FusedEqual(ComposeFused(Fa(k,:),Fb(k,:)), FusedFromRotmat(RFa*RFb));
		[~, ErrB(k)] = FusedEqual(ComposeFused(Fa(k,:),Fb(k,:),Fc(k,:)), FusedFromRotmat(RFa*RFb*RFc));
	end
	
	% End test
	P = P & EndBoolean(B);
	P = P & EndTest(Tol, '2 arguments', ErrA, '3 arguments', ErrB);
	
	%
	% Test ComposeQuat
	%
	
	% Begin test
	[N, ErrA, ErrB] = BeginTest('ComposeQuat', Nnormal);
	B = BeginBoolean();
	
	% Boolean conditions
	B = B && all(ComposeQuat() == [1 0 0 0]);
	B = B && all(ComposeQuat(Qa(1,:)) == Qa(1,:));
	B = B && all(ComposeQuat(Qb(1,:)) == Qb(1,:));
	
	% Calculate composition errors
	for k = 1:N
		RQa = RotmatFromQuat(Qa(k,:));
		RQb = RotmatFromQuat(Qb(k,:));
		RQc = RotmatFromQuat(Qc(k,:));
		[~, ErrA(k)] = QuatEqual(ComposeQuat(Qa(k,:),Qb(k,:)), QuatFromRotmat(RQa*RQb));
		[~, ErrB(k)] = QuatEqual(ComposeQuat(Qa(k,:),Qb(k,:),Qc(k,:)), QuatFromRotmat(RQa*RQb*RQc));
	end
	
	% End test
	P = P & EndBoolean(B);
	P = P & EndTest(Tol, '2 arguments', ErrA, '3 arguments', ErrB);

	%
	% Test ComposeRotmat
	%
	
	% Begin test
	[N, ErrA, ErrB] = BeginTest('ComposeRotmat', Nlarge);
	B = BeginBoolean();
	
	% Boolean conditions
	B = B && all(all(ComposeRotmat() == eye(3)));
	B = B && all(all(ComposeRotmat(Ra(:,:,1)) == Ra(:,:,1)));
	B = B && all(all(ComposeRotmat(Rb(:,:,1)) == Rb(:,:,1)));
	
	% Calculate composition errors
	for k = 1:N
		[~, ErrA(k)] = RotmatEqual(ComposeRotmat(Ra(:,:,k),Rb(:,:,k)), Ra(:,:,k)*Rb(:,:,k));
		[~, ErrB(k)] = RotmatEqual(ComposeRotmat(Ra(:,:,k),Rb(:,:,k),Rc(:,:,k)), Ra(:,:,k)*Rb(:,:,k)*Rc(:,:,k));
	end
	
	% End test
	P = P & EndBoolean(B);
	P = P & EndTest(Tol, '2 arguments', ErrA, '3 arguments', ErrB);
	
	%
	% Test ComposeTilt
	%
	
	% Begin test
	[N, ErrA, ErrB] = BeginTest('ComposeTilt', Nnormal);
	B = BeginBoolean();
	
	% Boolean conditions
	B = B && all(ComposeTilt() == [0 0 0]);
	B = B && all(ComposeTilt(Ta(1,:)) == Ta(1,:));
	B = B && all(ComposeTilt(Tb(1,:)) == Tb(1,:));
	
	% Calculate composition errors
	for k = 1:N
		RTa = RotmatFromTilt(Ta(k,:));
		RTb = RotmatFromTilt(Tb(k,:));
		RTc = RotmatFromTilt(Tc(k,:));
		[~, ErrA(k)] = TiltEqual(ComposeTilt(Ta(k,:),Tb(k,:)), TiltFromRotmat(RTa*RTb));
		[~, ErrB(k)] = TiltEqual(ComposeTilt(Ta(k,:),Tb(k,:),Tc(k,:)), TiltFromRotmat(RTa*RTb*RTc));
	end
	
	% End test
	P = P & EndBoolean(B);
	P = P & EndTest(Tol, '2 arguments', ErrA, '3 arguments', ErrB);
	
	%
	% End of test script
	%
	
	% End test script
	EndTestScript('TestCompose', P);

	% Set the output pass flag
	if nargout >= 1
		Pass = P;
	end

end
% EOF