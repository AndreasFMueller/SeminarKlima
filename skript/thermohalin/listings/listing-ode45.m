%% Loesung Diffgl
[t,y] = ode45(@(t,y) odefun_3box(t,y,val), tspan, y0);