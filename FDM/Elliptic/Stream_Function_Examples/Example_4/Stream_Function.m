% Example-4 : Stream Function Variation
clear all; clc

% Known Values
Lx = 1; % Length of x-domain
Ly = 1; % Length of y-domain
M = 81; % Number of grid points in x-direction
N = 81; % Number of grid points in y-direction

% Calculated Values
dx = Lx/(M-1);
dy = Ly/(N-1);
x = linspace(0,Lx,M);
y = linspace(Ly,0,N);

% Coefficients
ap = 2*((1/(dx^2))+(1/(dy^2)));
ae = 1/(dx^2);
aw = 1/(dx^2);
an = 1/(dy^2);
as = 1/(dy^2);

% Initializing Stream Function Matrix
psi = zeros(N,M);

% Boundary Conditions
psi(N,:) = 0; % Bottom Boundary
psi(:,1) = 0; % Left Boundary
psi(:,M) = 0; % Right Boundary
% Top Boundary
for i=1:M
    if(0<=x(i) && x(i)<=(2/3))
        psi(1,i) = 75*x(i);
    elseif((2/3)<=x(i) && x(i)<=1)
        psi(1,i) = 150*(1-x(i));
    end
end

% Computation - Gauss-Seidel Method
epsilon = 1e-8; % Error Sensivity
err = 1; % Error
n = 0; % Iterator

while err>epsilon
    err = 0; % Error
    for j=2:N-1 % For Internal Grid points
        for i=2:M-1 % For Internal Grid points
            psi_temp = psi(j,i);
            % Psi(j,i)_(k+1)th_iteration Calculation
            psi(j,i) = (1/ap)*(ae*psi(j+1,i) + aw*psi(j-1,i) + an*psi(j,i+1) + as*psi(j,i-1));
            err = err + power(psi(j,i)-psi_temp,2);
        end
    end
    err = sqrt(err/(M*N));
    n = n+1; % Iterator
end
%psi
n
err

% Plotting
[X,Y] = meshgrid(x,y);
contourf(X,Y,psi,'ShowText','on'),colorbar,colormap(jet)
grid on;
xlabel('X'),ylabel('Y'),title('Stream Function(PSI) Contour Plot')
