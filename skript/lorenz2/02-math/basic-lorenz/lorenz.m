graphics_toolkit("gnuplot")

## Using LSODE to solve the ODE system.
clear all
close all
lsode_options("absolute tolerance",1e-3)
lsode_options("relative tolerance",1e-4)
t = linspace(0,25,1e3); X0 = [0,1,1.05];
[X,T,MSG]=lsode(@lorenz_attractor,X0,t);
T
MSG
figure(1);
plot3(X(:,1),X(:,2),X(:,3))
view(45,45)

figure(2);
plot(X);
