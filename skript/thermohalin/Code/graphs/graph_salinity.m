%Tabelle Salinität und Temperatur
%Einfluss auf Dichte

density = [1, 1.0083, 1.017, 1.025, 1.0327];
salinity = (0:10:40);

figure(1);
plot(salinity, density)
%title('Temperature-plot')
xlabel('Salinity(psu)')
ylabel('Density(g/cm^3')
grid on;



density2 = [0.9997, 0.9999, 1, 0.9999, 0.9997, 0.9995, 0.9992, 0.9988, 0.9983, 0.9977, 0.9971, 0.9965, 0.9957];
temperature = [0,     2.5,  5,   7.5,    10,     12.5,    15,     17.5,   20,    22.5,   25,     27.5,   30];
figure(2);
plot(temperature, density2)
xlabel('Temperature (C)')
ylabel('Density(g/cm^3')
grid on;