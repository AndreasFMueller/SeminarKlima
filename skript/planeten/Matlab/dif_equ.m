addpath('equations');

latexplots = 1;
saveplots = 1;

%% static parameter
global CONST;
CONST.sigma = 5.670367e-8;    % Stefan-Bolzmann Constant
CONST.R = 8.3144598;          % Gas-constant
CONST.k = 1.38064852e-23;     % Bolzmann Constant
CONST.T_sun = 5778; %K
CONST.R_sun = 6.957e8; %m

%% Planet parameter
global PLANET;

% http://claesjohnson.blogspot.ch/2010/04/black-body-temperatures-of-planets.html

VENUS.name = 'Venus';
VENUS.v_escape = 10.36e3;
VENUS.R = 6.0519e6; %m
VENUS.A = 1.076e11; %m
VENUS.T_mean = 273+460; %K WolframAlpha   %465
VENUS.T_blackbody = 312; %K claesjohnson
VENUS.albedo = 0.65; % WolframAlpha
VENUS.cloud_cover = 0.99; %?
VENUS.mean_h2o = NaN;

EARTH.g = 9.81;
EARTH.name = 'Earth';
EARTH.v_escape = 11.186e3;
EARTH.R = 6.371e6; %m
EARTH.A = 1.499e11; %m
%EARTH.T0 = 273+10; %K
EARTH.T_mean = 273+14;  %K WolframAlpha
EARTH.T_blackbody = 275; %K claesjohnson
EARTH.albedo = 0.367; % WolframAlpha
EARTH.cloud_cover = 0.67; % https://earthobservatory.nasa.gov/images/85843/cloudy-earth
EARTH.mean_h2o = 0.44;    % http://www.climate4you.com/ClimateAndClouds.htm

MARS.name = 'Mars';
MARS.v_escape = 5.03e3;
MARS.R = 3.3895e6; %m
MARS.A = 2.353e11; %meters
MARS.T_mean = 273-47; %K WolframAlpha
MARS.T_blackbody = 229; %K claesjohnson
MARS.albedo = 0.15; % WolframAlpha
MARS.greenhouse = 0.75; % ?
MARS.cloud_cover = 0.05; % ?
MARS.mean_h2o = NaN;

MERCURY.name = 'Mercury';
%MERCURY.v_escape = 5.03e3;
MERCURY.R = 2.439e6; %m
MERCURY.A = 5.9133e10; %meters
MERCURY.T_mean = 273+179; %K WolframAlpha
MERCURY.T_blackbody = 443; %K
MERCURY.albedo = 0.106; % WolframAlpha
MERCURY.greenhouse = 0.75; %?
MERCURY.cloud_cover = 0;
MERCURY.mean_h2o = NaN;

%% Molecules
% He, o2, co2, h2o,
global MOLECULES;
MOLECULES.names = {'He', 'o2', 'co2', 'h2o'};
MOLECULES.M_mol = [4e-3; 31.9988e-3; 44.01e-3; 18.01528e-3];

%% Simulation Parameter
SIM.T_s_0    = EARTH.T_mean; %K
SIM.H_0      = EARTH.mean_h2o;
SIM.C_0 = EARTH.cloud_cover;



global PARAM
PARAM.xi1 = 1;       %dT factor     
PARAM.xi2 = 16e-3;    %vaporisation
PARAM.xi3 = 0.26e1;  %condesation     1.9e-2; 
PARAM.xi4 = 5e-0;    %precipitation
PARAM.beta_max = 0.9;     %greenhouse effect
PARAM.alpha_min = 0.15;
PARAM.alpha_max = 0.48;

% albedo only has a small deviation
% global PARAM
% PARAM.xi1 = 1;       %dT factor     
% PARAM.xi2 = 16e-3;    %vaporisation
% PARAM.xi3 = 2.6e0;  %condesation     1.9e-2; 
% PARAM.xi4 = 5e-0;    %precipitation
% PARAM.beta_max = 0.5;     %greenhouse effect
% PARAM.alpha_min = 0.15;
% PARAM.alpha_max = 0.55;




% with temp gradient depandant on Temperature
% PARAM.xi1 = 1;       %dT factor     
% PARAM.xi2 = 10e-5;    %vaporisation
% PARAM.xi3 = 0.26e1;  %condesation     1.9e-2; 
% PARAM.xi4 = 5e-2;    %precipitation
% PARAM.beta_max = 0.6;     %greenhouse effect
% PARAM.alpha_min = 0.15;
% PARAM.alpha_max = 0.65;

planets = {EARTH, MARS, VENUS, MERCURY};

colors = {[0,113,188]/255, [216,82,24]/255, [236,176,31]/255, [153,51,0]/255};

for i = 1:4
	p = planets(i);
	PLANET = p{1};

    %% Solve diff equation
    tspan = [0 10];
    y0 = [SIM.T_s_0; SIM.H_0; SIM.C_0];

    [t,y] = ode45(@(t,y) fun_dydt(t, y), tspan, y0);
    y_end = y(end, :)';

    T_s  = y(:,1);
    H    = y(:,2);
    C    = y(:,3);

    %% other parameters

%     T_grad = T_s - T_t;
%     T_grad = param(3)* 1./(clouds .* T_s); 
% 
%     P_in = P_absorption() .* (1-albedo(clouds));
%     P_out = P_blackbody(T_s) .* (1-greenhouse(h2o));
    
%     f1 = param(2) * h2o.*T_s;
%     f2 = -param(3) * P_blackbody(T_t) .* albedo(clouds);
%     f3 = param(4) * (T_grad .* h2o);
%     
    %%save to struct
    planets{i}.t = t;
    
    planets{i}.y.T_s = T_s;
    planets{i}.y.H = H;
    planets{i}.y.C = C;
    
%     planets{i}.y.P_in = P_in;
%     planets{i}.y.P_out = P_in;
    planets{i}.y.albedo     = ((PARAM.alpha_max - PARAM.alpha_min) * C) + PARAM.alpha_min;
    planets{i}.y.greenhouse = ( PARAM.beta_max * H);
    
    
    
    
    
    %% Plot  
    
    if (latexplots == 0)

        PLANET.name
        f = figure(i);
        f.set('name',PLANET.name);

        subplot(4,1,1);
        plot(t, T_s, '-', 'color', colors{1}); hold on;
        plot(t, ones(1,length(t)) * PLANET.T_mean, '-.', 'color', colors{1}); hold on;
        plot(t, T_t, '-', 'color', colors{2}); hold off
        title([ PLANET.name ' Temperature']);
        ylabel('Temperature / K');
        xlabel('Time');
        ylim([180 350]);
        legend({'Surface', 'Measured blackbody', 'Tropopause'});
        grid

        subplot(4,1,2)
        plot(t, h2o * 100, '-', 'color', colors{1}); hold on;
        plot(t, clouds * 100, '-', 'color', colors{2});
        plot(t, ones(1,length(t)) * PLANET.cloud_cover * 100, '-.', 'color', colors{2}); hold off;
        title('Atmospheric abundance');
        legend({'Humidity', 'Cloud cover', 'Current cloud cover'});
        ylabel('%');
        xlabel('Time');
        ylim([0, 110]);
        grid;

        subplot(4,1,3)
        plot(t, 100 * albedo(clouds), 'color', colors{1}); hold on;
        plot(t, 100 * ones(1,length(t)) * PLANET.albedo, '-.', 'color', colors{1});
        plot(t, 100 * greenhouse(h2o)), 'color', colors{2}; hold off;
        title('Albedo % Greenhouse effect')
        legend({'Albedo', 'Current albedo', 'Greenhouse'});
        ylim([-100*0.1, 100*1.1]);
        xlabel('Time');
        ylabel('%');
        grid

        subplot(4,1,4)
        plot(t, P_in); hold on
        plot(t, P_out); hold off;
        title('Power budget')
        legend({'P_{in}' 'P_{out}'});
        xlabel('Time');
        ylabel('Watts per m^2');
        grid

        %% Plot f1f2f3

        subplot(4,1,4)
        plot(t, T_grad); hold on;hold off
        title('f1f2f3');
        ylabel('T_grad');
        xlabel('Time');
        legend({'convection', 'blackbody radiation', 'heat transfer'});
        grid
    
    end
    
end

%% latex plots

if (latexplots == 1)

    fig1 = figure(1);
    fig1.set('name', 'surfaceTemperature');
    for i = 1:4
        plot(planets{i}.t, planets{i}.y.T_s, '-', 'color', colors{i}); hold on;
    end
    for i = 1:4
        o = ones(1, length(planets{i}.t));
        plot(planets{i}.t, o*planets{i}.T_mean, '-.', 'color', colors{i});
    end
    hold off;
    title('Surface temperature');
    ylabel('Temperature / K');
    xlabel('Time');
    ylim([0, 800])
    legend({planets{1}.name, planets{2}.name, planets{3}.name, planets{4}.name});
    grid


    fig2 = figure(2);
    fig2.set('name', 'cloudCover');
    for i = 1:4
        plot(planets{i}.t, 100*planets{i}.y.C, '-', 'color', colors{i}); hold on;
    end
    for i = 1:4
        o = ones(1, length(planets{i}.t));
        plot(planets{i}.t, 100*o*planets{i}.cloud_cover, '-.', 'color', colors{i});
    end
    hold off;
    title('Cloud cover');
    ylabel('%');
    xlabel('Time');
    ylim([0 110])
    legend({planets{1}.name, planets{2}.name, planets{3}.name, planets{4}.name});
    grid


    fig3 = figure(3);
    fig3.set('name', 'humidity');
    for i = 1:4
        plot(planets{i}.t, 100*planets{i}.y.H, '-', 'color', colors{i}); hold on;
    end
    for i = 1:4
        o = ones(1, length(planets{i}.t));
        plot(planets{i}.t, 100*o*planets{i}.mean_h2o, '-.', 'color', colors{i});
    end
    hold off;
    title('Humidity');
    ylabel('%');
    ylim([0 100])
    xlabel('Time');
    legend({planets{1}.name, planets{2}.name, planets{3}.name, planets{4}.name});
    grid


    fig4 = figure(4);
    fig4.set('name', 'albedo');
    for i = 1:4
        plot(planets{i}.t, 100*planets{i}.y.albedo, '-', 'color', colors{i}); hold on;
    end
    for i = 1:4
        o = ones(1, length(planets{i}.t));
        plot(planets{i}.t, 100*o*planets{i}.albedo, '-.', 'color', colors{i});
    end
    hold off;
    title('Albedo');
    ylabel('%');
    xlabel('Time');
    ylim([10 80])
    legend({planets{1}.name, planets{2}.name, planets{3}.name, planets{4}.name});
    grid

    if saveplots == 1
        saveas(fig1,['figures/' fig1.Name], 'epsc')
        saveas(fig2,['figures/' fig2.Name], 'epsc')
        saveas(fig3,['figures/' fig3.Name], 'epsc')
        saveas(fig4,['figures/' fig4.Name], 'epsc')
    end
end



%% scrap

% 
%     planets(i).y.T_s = T_s;
%     planets(i).y.T_t = T_t;
%     planets(i).y.h2o = h2o;
%     planets(i).y.clouds = clouds;
%     
%     planets(i).y.P_in = P_in;
%     planets(i).y.P_out = P_in;
%     planets(i).y.albedo = albedo(clouds);
%     planets(i).y.greenhouse = greenhouse(h2o);
%     
%     
%     subplot(4,1,1);
%     plot(t, T_s, '-', 'color', colors{1}); hold on;
%     plot(t, ones(1,length(t)) * PLANET.T_blackbody, '-.', 'color', colors{1}); hold on;
%     plot(t, T_t, '-', 'color', colors{2}); hold off
%     
% 
%     subplot(4,1,2)
%     plot(t, h2o * 100, '-', 'color', colors{1}); hold on;
%     plot(t, clouds * 100, '-', 'color', colors{2});
%     plot(t, ones(1,length(t)) * PLANET.cloud_cover * 100, '-.', 'color', colors{2}); hold off;
%     title('Atmospheric abundance');
%     legend({'Humidity', 'Cloud cover', 'Current cloud cover'});
%     ylabel('%');
%     xlabel('Time');
%     ylim([0, 110]);
%     grid;
%     
