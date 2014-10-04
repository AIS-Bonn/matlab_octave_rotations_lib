% TestCompose.m - Philipp Allgeuer - 01/07/14
% Tests: Compose*
% Assumed: Rand*, *Equal, RotmatFrom*, *FromRotmat
%
% function Pass = TestCompose(N, Tol, Inter)
%

% Main function
function Pass = TestCompose(N, Tol, Inter)

	% Process function inputs
	if nargin < 1 || ~isscalar(N) || N < 1
		N = 500;
	end
	N = round(N);
	if nargin < 2
		Tol = 128*eps;
	end
	Tol = abs(Tol);

	% Begin test script
	[P, Nnormal, Nlarge] = BeginTestScript('TestCompose',N,Tol);

	% Generate random test rotations
	BeginTest('Rotation generation');
	printf('Generating random rotations for the subsequent tests...\n');
	Ra = RandRotmat(Nlarge);
	Rb = RandRotmat(Nlarge);
	Rc = RandRotmat(Nlarge);
	Qa = RandQuat(Nnormal);
	Qb = RandQuat(Nnormal);
	Qc = RandQuat(Nnormal);
	Qaa = quaternion(Qa(:,1),Qa(:,2),Qa(:,3),Qa(:,4));
	Qbb = quaternion(Qb(:,1),Qb(:,2),Qb(:,3),Qb(:,4));
	Qcc = quaternion(Qc(:,1),Qc(:,2),Qc(:,3),Qc(:,4));
	Ea = RandEuler(Nnormal);
	Eb = RandEuler(Nnormal);
	Ec = RandEuler(Nnormal);
	Fa = RandFused(Nnormal);
	Fb = RandFused(Nnormal);
	Fc = RandFused(Nnormal);
	P = P & EndTest();

	% Test ComposeRotmat
	[N,ErrA,ErrB] = BeginTest('ComposeRotmat',Nlarge);
	B = BeginBoolean();
	B = B && all(ComposeRotmat() == eye(3));
	B = B && all(ComposeRotmat(Ra(:,:,1)) == Ra(:,:,1));
	B = B && all(ComposeRotmat(Rb(:,:,1)) == Rb(:,:,1));
	for k = 1:N
		[~, ErrA(k)] = RotmatEqual(ComposeRotmat(Ra(:,:,k),Rb(:,:,k)), Ra(:,:,k)*Rb(:,:,k));
		[~, ErrB(k)] = RotmatEqual(ComposeRotmat(Ra(:,:,k),Rb(:,:,k),Rc(:,:,k)), Ra(:,:,k)*Rb(:,:,k)*Rc(:,:,k));
	end
	P = P & EndBoolean(B);
	P = P & EndTest(Tol,'2 arguments',ErrA,'3 arguments',ErrB);
	
	% Test ComposeQuat
	[N,ErrA,ErrB] = BeginTest('ComposeQuat',Nnormal);
	B = BeginBoolean();
	B = B && all(ComposeQuat() == [1 0 0 0]);
	B = B && all(ComposeQuat(Qa(1,:)) == Qa(1,:));
	B = B && all(ComposeQuat(Qb(1,:)) == Qb(1,:));
	for k = 1:N
		prod2 = Qaa(k)*Qbb(k);
		prod3 = Qaa(k)*Qbb(k)*Qcc(k);
		[~, ErrA(k)] = QuatEqual(ComposeQuat(Qa(k,:),Qb(k,:)), [prod2.w prod2.x prod2.y prod2.z]);
		[~, ErrB(k)] = QuatEqual(ComposeQuat(Qa(k,:),Qb(k,:),Qc(k,:)), [prod3.w prod3.x prod3.y prod3.z]);
	end
	P = P & EndBoolean(B);
	P = P & EndTest(Tol,'2 arguments',ErrA,'3 arguments',ErrB);
	
	% Test ComposeEuler
	[N,ErrA,ErrB] = BeginTest('ComposeEuler',Nnormal);
	B = BeginBoolean();
	B = B && all(ComposeEuler() == [0 0 0]);
	B = B && all(ComposeEuler(Ea(1,:)) == Ea(1,:));
	B = B && all(ComposeEuler(Eb(1,:)) == Eb(1,:));
	for k = 1:N
		Ra = RotmatFromEuler(Ea(k,:));
		Rb = RotmatFromEuler(Eb(k,:));
		Rc = RotmatFromEuler(Ec(k,:));
		[~, ErrA(k)] = EulerEqual(ComposeEuler(Ea(k,:),Eb(k,:)), EulerFromRotmat(Ra*Rb));
		[~, ErrB(k)] = EulerEqual(ComposeEuler(Ea(k,:),Eb(k,:),Ec(k,:)), EulerFromRotmat(Ra*Rb*Rc));
	end
	P = P & EndBoolean(B);
	P = P & EndTest(Tol,'2 arguments',ErrA,'3 arguments',ErrB);
	
	% Test ComposeFused
	[N,ErrA,ErrB] = BeginTest('ComposeFused',Nnormal);
	B = BeginBoolean();
	B = B && all(ComposeFused() == [0 0 0 1]);
	B = B && all(ComposeFused(Fa(1,:)) == Fa(1,:));
	B = B && all(ComposeFused(Fb(1,:)) == Fb(1,:));
	for k = 1:N
		Ra = RotmatFromFused(Fa(k,:));
		Rb = RotmatFromFused(Fb(k,:));
		Rc = RotmatFromFused(Fc(k,:));
		[~, ErrA(k)] = FusedEqual(ComposeFused(Fa(k,:),Fb(k,:)), FusedFromRotmat(Ra*Rb));
		[~, ErrB(k)] = FusedEqual(ComposeFused(Fa(k,:),Fb(k,:),Fc(k,:)), FusedFromRotmat(Ra*Rb*Rc));
	end
	P = P & EndBoolean(B);
	P = P & EndTest(Tol,'2 arguments',ErrA,'3 arguments',ErrB);
	
	% End test script
	EndTestScript('TestCompose',P);

	% Set the output pass flag
	if nargout >= 1
		Pass = P;
	end

end
% EOF