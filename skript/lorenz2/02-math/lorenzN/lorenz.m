## Using LSODE to solve the ODE system.
clear all
close all

graphics_toolkit("gnuplot");

disp(strcat("Starting script, ", asctime(localtime(time))));
tic();

figure("visible", "off");

save_X = true;
save_IC = true;
save_timing = true;
plot_X = true;
should_plot_basic = true;
should_plot_3d = false;
should_plot_contour = false;

absolute_tolerance = 1e-12;1e-3;
relative_tolerance = 1e-13;1e-4;

lsode_options("absolute tolerance", absolute_tolerance)
lsode_options("relative tolerance", relative_tolerance)

spacesize = 1e4;
t0 = 0;
tN = 200;

t = linspace(t0,tN,spacesize);

s = load("lorenz_order.m", "order");
order = s.("order");

A = zeros(order + 1);
B = zeros(order + 1);

index_offset = 1;

B(0 + index_offset, 2 + index_offset) = 1.05;
B(1 + index_offset, 1 + index_offset) = 1;

X0 = transpose([flatten_multi_index_matrix(A, order) flatten_multi_index_matrix(B, order)]);

a = sqrt(1/2);
T0 = 5;
c = 82;(27*7*pi)/(9.81*T0);

nu = 0.143 * 1e1;
kappa = nu / 10;

if save_IC
  save("lorenz_ic.m", "X0", "a", "T0", "c", "nu", "kappa");
endif

offset_A = 0;
offset_B = vector_offset(order);

lorenz_func = @(x, t) lorenz_diff(x, t, kappa, nu, a, c, T0, order);

disp("Starting LSODE...");

[X,T,MSG]=lsode(lorenz_func, X0, t);
T
MSG

if save_X
  save("X.m", "X");
endif

if plot_X
#  figure(1);
  plot(X);
  print -color -depsc2 X.eps
endif

if should_plot_basic
#  figure(7)
  plot3(X(:,vector_index(1,1,offset_A)),X(:,vector_index(1,1,offset_B)),X(:,vector_index(0,2,offset_B)))
  print -color -depsc2 butterfly.eps
endif

if (should_plot_3d || should_plot_contour)
  y = linspace(0,2 * pi,spacesize);
  x = linspace(0,a/2,spacesize);

  psi = calc_psi(X, a, x, y);
  theta = calc_theta(X, a, x, y);

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
  endif
endif

elapsed_time = toc();
if save_timing
  save("timing.m", "elapsed_time");
endif

disp(strcat("Time used: ", num2str(elapsed_time)));
disp(strcat("Finished at script, ", asctime(localtime(time))));
