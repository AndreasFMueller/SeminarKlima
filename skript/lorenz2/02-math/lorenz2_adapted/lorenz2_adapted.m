graphics_toolkit("gnuplot")

## Using LSODE to solve the ODE system.
clear all
close all

should_plot_2d = true;
should_plot_3d = false;
should_plot_contour = false;

lsode_options("absolute tolerance",1e-12)
lsode_options("relative tolerance",1e-13)

spacesize = 1e4;

t = linspace(0,100,spacesize);
X0 = transpose([ ...
    1,1.05, ...
    0]);

#X0 = [ ...
#    1,1.05, ...
#    0,];

a = sqrt(1/2);
T0 = 1;
c = 100;(27*7*pi)/(9.81*T0);

nu = 0.143 * 1e1;
kappa = nu / 10;

f = @(x, t) higher_dimensional_lorenz(x, t, kappa, nu, a, c, T0);

[X,T,MSG]=lsode(f,X0,t);
T
MSG

y = linspace(0,2*pi,spacesize);
#x = linspace(0,a/2,1e3);
x = linspace(0,2*pi,spacesize);

psi = calc_psi(X, a, x, y);
theta = calc_theta(X, a, x, y);

figure(1);
plot(X);

if should_plot_2d
  figure(2);
  hold on;
  plot3(X(:,3),X(:,1),X(:,2))
  view(0,90);
endif

if should_plot_3d
  figure(3);
  plot3(x,y,psi)

  figure(5);
  plot3(x,y,theta)

endif

if should_plot_contour
  figure(4);
  contour3(x,y,psi)

  figure(6);
  contour3(x,y,theta)
end