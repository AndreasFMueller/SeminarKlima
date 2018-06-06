y0 = [5; 5; 0.02; 0.035];
tspan = [0 400000];
val = [7;19;0.02;0.035];

[t,y] = ode45(@(t,y) odefun_2Box(t,y,val), tspan, y0);

%% Plot Temperature
figure(1)
plot(t,y(:,1));
hold on
plot(t,y(:,2));
hold off
title('Temperature-plot')
xlabel('time')
ylabel('Temp(C)')
legend('T1', 'T2')

%% Plot Salinity
figure(2);
plot(t,y(:,3));
hold on
plot(t,y(:,4));
hold off
title('Salinity-plot')
xlabel('time')
ylabel('Salinity(psu)')
legend('S1', 'S2')

%% Berechnung Fluss
k = 1.5*10^(-6);
a = 1.5*10^(-4);
b = 8*10^(-4);
q = k*(a*(y(:,2)-y(:,1))-b*(y(:,4)-y(:,3)));


%% Plot Fluss
figure(3) 
plot(t,q);
title('Fluss-plot')
xlabel('time')
ylabel('Fluss')
legend('q1')

