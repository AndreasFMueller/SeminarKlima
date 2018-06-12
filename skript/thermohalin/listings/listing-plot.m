% create Subplots
p1 = subplot(1,3,1);
p2 = subplot(1,3,2);
p3 = subplot(1,3,3);
       
% Plot temperature
plot(p1, t,y(:,1), t, y(:,2), t, y(:,3));
title(p1, 'Temperature-plot')
xlabel(p1, 'time')
ylabel(p1, 'Temp(C)')
legend(p1, 'T1', 'T2', 'T3')
