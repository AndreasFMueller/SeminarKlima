%% Startvariablen, Timebase, konstante Temp

y0 = [0; 0; 0; 0.035; 0.032; 0.04;];
tspan = [0 90000];
val = [7; 7; 19; 0.035; 0.035; 0.042];

%% Lösung Diffgl
[t,y] = ode45(@(t,y) odefun_3Box_1Flux(t,y,val), tspan, y0);

myui (t, y, tspan, y0, val)