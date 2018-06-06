% Bifurktion 2Box

x0 = 0;
tspan = [0 1];

[t,x] = ode45(@(t,x) bif_ode_2Box(t,x), tspan, x0);

plot(t,x);