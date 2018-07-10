%% Startvariablen, Timebase, konstante Temp

y0 = [2.9; 2; 28; 0.0342; 0.0347; 0.036];
tspan = [0 90000];
val = [2.9; 0.3; 28.4; 0.0341; 0.0341; 0.0356];

%% Lösung Diffgl
[t,y] = ode45(@(t,y) odefun_3Box_1Flux(t,y,val), tspan, y0);

%create subplots
       p1 = subplot(1,3,1);
       p2 = subplot(1,3,2);
       p3 = subplot(1,3,3);
       
       %plot temperature
        plot(p1, t,y(:,1), t, y(:,2), t, y(:,3));
        title(p1, 'Temperature-plot')
        xlabel(p1, 'time')
        ylabel(p1, 'Temp(C)')
        legend(p1, 'T1', 'T2', 'T3')

        % Plot Salinity
        plot(p2, t,y(:,4), t, y(:,5), t, y(:,6));
        title(p2, 'Salinity-plot')
        xlabel(p2, 'time')
        ylabel(p2, 'Salinity(psu)')
        legend(p2, 'S1', 'S2', 'S3')

        % calc Flux
        k = 1.5*10^(-6);
        a = 1.5*10^(-4);
        b = 8*10^(-4);
        q = k*(a*(y(:,1)-y(:,2))-b*(y(:,4)-y(:,5)));

        % Plot Flux 
        plot(p3, t,q);
        title(p3, 'Fluss-plot')
        xlabel(p3, 'time')
        ylabel(p3, 'Fluss')
        legend(p3, 'q') 