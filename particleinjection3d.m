% Da Yang
% 3/17/2017
% 3D uniform particle injection file to fluent

close all;clear all;clc;


%% Inputs
% point coordinates to create plane
% small injection
% p1 = [-0.0075 -0.1155 -0.015]; 
% p2 = [0.0075 -0.1155 -0.015];
% p3 = [0.0075 -0.1155 -0.005]; 
% % big injection
p1 = [-0.01 -0.1155 -0.02]; 
p2 = [0.01 -0.1155 -0.02];
p3 = [0.01 -0.1155 0];
% number of nodes on one side
% small injection
% Nx = 150;
% Ny = 1;
% Nz = 100;
% % big injection
Nx = 200;
Ny = 1;
Nz = Nx;
%cases
% Casename=char('1nm1h','10nm1h','100nm1h','1um1h','10um1h','100um1h');
% Names=deblank(Casename);
% for i=1:6
% filename = Names(i,:);
% original cases
%cases=[10 20 30 40 50 60 70 80 90 100 110 120 130 140 150 160 170 180 190 200 300 400 500 600];
% adding cases for declining curve
cases=[1 2 4 6 8];
for i=1:length(cases)
filename = [num2str(cases(i)) 'nm2hbig'];

WRITE = 1;

%% Geometry Parameters

NumberofParticles = Nx*Ny*Nz;

xrange = [min([p1(1) p2(1) p3(1)]) max([p1(1) p2(1) p3(1)])];
yrange = [min([p1(2) p2(2) p3(2)]) max([p1(2) p2(2) p3(2)])];
zrange = [min([p1(3) p2(3) p3(3)]) max([p1(3) p2(3) p3(3)])];

xvector = linspace(xrange(1), xrange(2), Nx);
yvector = linspace(yrange(1), yrange(2), Ny);
zvector = linspace(zrange(1), zrange(2), Nz);

%% Particle Characteristics
% particle diameter (m)
Dp = cases(i)*10^(-9);

% particle temperature (K)
T = 209;

% particle velocity components
u = 0; v = 0; w = 0;

% particle mass flow rate
mrate = 1e-20;


%% Create particle positions
p = [];

for ii = 1:Nx
    for jj = 1:Ny
        for kk = 1:Nz
            point = [xvector(ii),yvector(jj),zvector(kk)];
            p = [p; point];
        end
    end
end

% figure
% scatter3(p(:,1),p(:,2),p(:,3),2.*ones(size(p(:,1))),'filled')
% xlabel('x')
% ylabel('y')
% zlabel('z')

%% Write to file
if WRITE == 1;
    
    fid = fopen([filename,'.inj'],'w');
    
    for ii = 1:NumberofParticles
        fprintf(fid,'((');
        fprintf(fid,'%e\t',p(ii,:),u,v,w,Dp,T,mrate);
        fprintf(fid,')');
        fprintf(fid,filename);
        fprintf(fid,':');
        fprintf(fid,num2str(ii));
        fprintf(fid,')');
        fprintf(fid,'\n');
    end
    
    fclose(fid);
    
end

end
