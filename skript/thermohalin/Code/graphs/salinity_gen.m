% graph salinity vs. density



salinity = [0:40];
density = 1+salinity*0.0008333;

%plot(salinity, density);

figure(1)
plot(salinity,density);
xlabel('Salinity(psu)')
ylabel('Density(g/(cm)^3')
grid on;