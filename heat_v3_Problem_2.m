%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% .m - October 15 2003                                % 
% author: Jean H. Prevost + David Luet                     %
% analyses of 1,2 and 3D elastic trusses                   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear; % removes all variables from the workspace.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                          DATA                            %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%
% Conductivity %
%%%%%%%%%%%%
k = 50.0;
D = k*eye(2);
t = 0.01;
%%%%%%%%
% Mesh %
%%%%%%%%
nsd=2;   % number of space dimension
ndf=1;   % number of freedom per node 
nen=3;   % number of element nodes

nel=32;   % number of elements/triangle pieces
nnp=25;   % number of nodal points
nglx = 2;   % Gaussian coordinate x
ngly = 2;   % Gaussian coordinate y
nglz = 0;   % Gaussian coordinate z

%%%%%%%%%%%%%%%%%%%%%
% Nodal coordinates %
%%%%%%%%%%%%%%%%%%%%%
% xn(i,N):= coordinate i for node N
% N=1,...,nnp
% i=1,...,nsd
xn=zeros(nsd,nnp);
xn(1,1)=0;      xn(2,1)=0;
xn(1,2)=2.5;    xn(2,2)=0;
xn(1,3)=5;      xn(2,3)=0;
xn(1,4)=7.5;    xn(2,4)=0;
xn(1,5)=10;     xn(2,5)=0;
xn(1,6)=0;      xn(2,6)=1.25;
xn(1,7)=2.5;    xn(2,7)=1.25;
xn(1,8)=5;      xn(2,8)=1.25;
xn(1,9)=7.5;    xn(2,9)=1.25;
xn(1,10)=10;    xn(2,10)=1.25;
xn(1,11)=0;     xn(2,11)=2.5;
xn(1,12)=2.5;   xn(2,12)=2.5;
xn(1,13)=5;     xn(2,13)=2.5;
xn(1,14)=7.5;   xn(2,14)=2.5;
xn(1,15)=10;    xn(2,15)=2.5;
xn(1,16)=0;     xn(2,16)=3.75;
xn(1,17)=2.5;   xn(2,17)=3.75;
xn(1,18)=5;     xn(2,18)=3.75;
xn(1,19)=7.5;   xn(2,19)=3.75;
xn(1,20)=10;    xn(2,20)=3.75;
xn(1,21)=0;     xn(2,21)=5;
xn(1,22)=2.5;   xn(2,22)=5;
xn(1,23)=5;     xn(2,23)=5;
xn(1,24)=7.5;   xn(2,24)=5;
xn(1,25)=10;    xn(2,25)=5;
%%%%%%%%%%%%%%%%
% Connectivity %
%%%%%%%%%%%%%%%%

% ien(a,e)=N
% N: global node number - N=1,...,nnp
% e: element number - e=1,...,nel
% a: local node number - a=1,...,nen
ien=zeros(nen,nel);
%mat=zeros(nel);
ien(1,1)=1;    ien(2,1)=2;   ien(3,1)  = 7;
ien(1,2)=2;    ien(2,2)=3;   ien(3,2)  = 8;
ien(1,3)=3;    ien(2,3)=4;   ien(3,3)  = 9;
ien(1,4)=4;    ien(2,4)=5;   ien(3,4)  = 10;
ien(1,5)=1;    ien(2,5)=7;   ien(3,5)  = 6;
ien(1,6)=2;    ien(2,6)=8;   ien(3,6)  = 7;
ien(1,7)=3;    ien(2,7)=9;   ien(3,7)  = 8;
ien(1,8)=4;    ien(2,8)=10;  ien(3,8)  = 9;
ien(1,9)=6;    ien(2,9)=7;   ien(3,9)  = 12;
ien(1,10)=7;   ien(2,10)=8;  ien(3,10) = 13;
ien(1,11)=8;   ien(2,11)=9;  ien(3,11) = 14;
ien(1,12)=9;   ien(2,12)=10; ien(3,12) = 15;
ien(1,13)=6;   ien(2,13)=12; ien(3,13) = 11;
ien(1,14)=7;   ien(2,14)=13; ien(3,14) = 12;
ien(1,15)=8;   ien(2,15)=14; ien(3,15) = 13;
ien(1,16)=9;   ien(2,16)=15; ien(3,16) = 14;
ien(1,17)=11;  ien(2,17)=12; ien(3,17) = 17;
ien(1,18)=12;  ien(2,18)=13; ien(3,18) = 18;
ien(1,19)=13;  ien(2,19)=14; ien(3,19) = 19;
ien(1,20)=14;  ien(2,20)=15; ien(3,20) = 20;
ien(1,21)=11;  ien(2,21)=17; ien(3,21) = 16;
ien(1,22)=12;  ien(2,22)=18; ien(3,22) = 17;
ien(1,23)=13;  ien(2,23)=19; ien(3,23) = 18;
ien(1,24)=14;  ien(2,24)=20; ien(3,24) = 19;
ien(1,25)=16;  ien(2,25)=17; ien(3,25) = 22;
ien(1,26)=17;  ien(2,26)=18; ien(3,26) = 23;
ien(1,27)=18;  ien(2,27)=19; ien(3,27) = 24;
ien(1,28)=19;  ien(2,28)=20; ien(3,28) = 25;
ien(1,29)=16;  ien(2,29)=22; ien(3,29) = 21;
ien(1,30)=17;  ien(2,30)=23; ien(3,30) = 22;
ien(1,31)=18;  ien(2,31)=24; ien(3,31) = 23;
ien(1,32)=19;  ien(2,32)=25; ien(3,32) = 24;

%%%%%%%%%%%%%%%%%%%%%%%
% Boundary conditions %
%%%%%%%%%%%%%%%%%%%%%%%
% prescribed displacement (essential boundary condition)
%
% idb(i,N)=1 if the degree of freedom i of the node N is prescribed
%         =0 otherwise
%
% 1) initialize idb to 0
idb=zeros(ndf,nnp);
% 2) enter the flag for prescribed displacement boundary conditions
idb(1,1)=1; idb(1,2)=1; idb(1,3)=1; idb(1,4)=1; idb(1,5)=1;
idb(1,21)=1; idb(1,22)=1; idb(1,23)=1; idb(1,24)=1; idb(1,25)=1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% prescribed nodal displacement boundary conditions %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% g(i,N): prescribed displacement for the dof i of node N

% initialize g
g=zeros(ndf,nnp);

% enter the values
g(1,21)=100; g(1,22)=100; g(1,23)=100; g(1,24)=100;

%%%%%%%%%%%%%%%%%%%%%%%%%%%
% prescribed nodal fluxes %
%%%%%%%%%%%%%%%%%%%%%%%%%%%
% f(i,N): prescribed flux for the dof i of node N

% initialize f
f=zeros(ndf,nnp);

% enter the values
% NONE

%---------------------------------------------------------------

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% number the equations; build the id table %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[id,neq]=number_eq(idb,nnp,ndf);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Compute the Gaussian function constituents %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[point,weight]=gauss(nglx,ngly,nglz,nsd)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Compute the elemental quantities in the elemental coordinate system %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for e=1:nel
  [Ke(:,:,e)]=Ke_heat_tri(D,xn,ien(:,e),t,nen,nsd);
end;

% Contribution of the prescribed displacements to the elemental force vector
% fe=fe-Ke*Ue
fe=zeros(ndf*nen,nel);     % fe may be non zero in general
Ue=zeros(ndf*nen,nel);
for e=1:nel
    for n=1:nen
        for i=1:ndf
            Ue(i+(n-1)*ndf,e)=g(i,ien(n,e));
        end
    end
    fe(:,e)=fe(:,e)-Ke(:,:,e)*Ue(:,e);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                        Assembly operation                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%----------------
% build K and F
%----------------
K=zeros(neq,neq);
F=zeros(neq,1);

% input the prescribed nodal forces in F
for N=1:nnp
    for i=1:ndf
        if (id(i,N) > 0)
            P=id(i,N);
            F(P)=f(i,N);
        end
    end
end

% compute global K and F
if (neq > 0)
    for e=1:nel
        K = addstiff(K,id,Ke(:,:,e),ien(:,e),nen,ndf);
        F = addforce(F,id,fe(:,e),ien(:,e),nen,ndf);
    end
end

% Solve the system
if (neq > 0)
    U=K\F;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                     post processing                      %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%
% complete U %
%%%%%%%%%%%%%%
Ucomp=zeros(ndf,nnp);
for N=1:nnp
    for i=1:ndf
        if (id(i,N) == 0) 
            Ucomp(i,N)=g(i,N);
        else
            P=id(i,N);
            Ucomp(i,N)=U(P);
        end
    end
end
% print results
disp('Nodal Displacements:')
disp(' node     d1     d2')
for N=1:nnp
   disp(sprintf('%5d %7g %7g',N,Ucomp(:,N)))
end 
disp(' ')

%%%%%%%%%%%%%
% REACTIONS %
%%%%%%%%%%%%%
% build the idb table; overwrite original idb table
% idb(i,N): equation number associated with dof i of node N
ineq=0; % number of equations
%for i=1:ndf
%for N=1:nnp
%        if (idb(i,N) > 0)  % assign an equation number to all prescribed nodes
%            ineq=ineq+1;
%            idb(i,N)=ineq;
%        end;
%    end;
%end;

% Contribution of the displacement to the elemental force vector
% fe=Ke*Ue
for e=1:nel
    Ue(:,e)=zeros(ndf*nen,1);
    for n=1:nen
        for i=1:ndf
            Ue(i+(n-1)*ndf,e)=Ucomp(i,ien(n,e));
        end
    end
    fe(:,e)=Ke(:,:,e)*Ue(:,e);
end;

% compute reactions R %
%R=zeros(ineq,1);
%for e=1:nel
%    R = addforce(R,idb,fe(:,e),ien(:,e),nen,ndf);
%end

% Collect reactions
%Rcomp=zeros(ndf,nnp);
%for N=1:nnp
%    for i=1:ndf
%        if (idb(i,N) > 0)
%            Rcomp(i,N)=R(idb(i,N));
%        end
%    end
%end
% print results
%disp('Nodal Reactions')
%disp(' node     R1     R2')
%for N=1:nnp
%   disp(sprintf('%5d %7g %7g',N,Rcomp(:,N)))
%end 
%disp(' ')

%%%%%%%%%%%%%%%%%%%%%%%%%
% AXIAL FORCES/STRESSES %
%%%%%%%%%%%%%%%%%%%%%%%%%
%for e=1:nel
%    Ue(:,e)=zeros(ndf*nen,1);
%    for n=1:nen
%        for i=1:ndf
%            Ue(i+(n-1)*ndf,e)=Ucomp(i,ien(n,e));
%        end
%    end
%    if (nsd > 1)
%        axial(:,e)=ke(:,:,e)*Qe(:,:,e)*Ue(:,e);
%    else
%        axial(:,e)=ke(:,:,e)*Qe(e)*Ue(:,e);
%    end;
%    stress(e)=axial(2,e)/A(mat(e));
%    strain(e)=stress(e)/E(mat(e));
%end;
% print results
%disp('Element Axial force/stress/strain')
%disp(' elem  force  stress  strain')
%for e=1:nel
%   disp(sprintf('%5d %7g %7g %7g',e,axial(2,e),stress(e),strain(e)))
%end 
%disp(' ')

%%%%%%%%%%%%%%%%%%%%
% plot the results %
%%%%%%%%%%%%%%%%%%%%
RComp=1;           % Dummy value
plot_results_heat('heat',xn,f,idb,Ucomp,RComp,ien,nel,nen,nsd,ndf,nnp);
