%% Startvariablen, Timebase, konstante Temp

y0 = [5; 17; 9; 0.035; 0.04; 0.032;];
tspan = [0 900000];
val = [7;19; 7; 0.035;0.04; 0.035];

%% Lösung Diffgl
[t,y] = ode45(@(t,y) odefun_3box(t,y,val), tspan, y0);

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
        q1 = k*(a*(y(:,2)-y(:,1))-b*(y(:,5)-y(:,4)));
        q2 = k*(a*(y(:,3)-y(:,2))-b*(y(:,6)-y(:,5)));

        % Plot Flux 
        plot(p3, t,q1,t,q2);
        title(p3, 'Fluss-plot')
        xlabel(p3, 'time')
        ylabel(p3, 'Fluss')
        legend(p3, 'q') 
