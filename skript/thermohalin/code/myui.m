% GUI for THC calculations
% Jonas Gruendler, HSR 
% Based on GUI for Schwarzschild calculations, Mathsem 2017, Sascha Jecklin

function myui (t, y, tspan, y0, val)


% create figure
f = figure('Visible','off', 'units','normalized','outerposition',[0 0 1 1]);
% figure('units','normalized','outerposition',[0 0 1 1])
update;

%create Sliders
salinity_Sp = uicontrol(f, 'Style', 'slider',... 
               'Min', 0.03, 'Max', 0.05, 'Value', val(4,1),...
               'Position', [1500 300 200 30]);
addlistener(salinity_Sp, 'Value', 'PostSet', @salinity_SpCallBack);

salinity_Se = uicontrol(f, 'Style', 'slider',... 
               'Min', 0.03, 'Max', 0.05, 'Value', val(6,1),...
               'Position', [1500 370 200 30]);
addlistener(salinity_Se, 'Value', 'PostSet', @salinity_SeCallBack);

temp_Tp = uicontrol(f, 'Style', 'slider',... 
               'Min', 0, 'Max', 25, 'Value', val(1,1),...
               'Position', [1500 440 200 30]);
addlistener(temp_Tp, 'Value', 'PostSet', @temp_TpCallBack);

temp_Te = uicontrol(f, 'Style', 'slider',... 
               'Min', 0, 'Max', 25, 'Value', val(3,1),...
               'Position', [1500 510 200 30]);
addlistener(temp_Te, 'Value', 'PostSet', @temp_TeCallBack);

%create labels for sliders      
Salinity_SpTxt = uicontrol(f, 'Style','text',...
    'Position',[1700 300 60 30],...
    'String','Salnity Sp');

Salinity_SeTxt = uicontrol('Style','text',...
    'Position',[1700 370 60 30],...
    'String','Salnity Se');

temp_TpTxt = uicontrol('Style','text',...
    'Position',[1700 440 60 30],...
    'String','Temp Tp');

temp_TeTxt = uicontrol('Style','text',...
    'Position',[1700 510 60 30],...
    'String','Temp Te');

% Create Values for salinity and temp
salinity_SpVal = uicontrol('Style', 'Text',...
    'Position', [1550 330 120 20],...
    'String', num2str(roundn(val(4,1), -4)));

salinity_SeVal = uicontrol('Style', 'Text',...
    'Position', [1550 400 120 20],...
    'String', num2str(roundn(val(6,1), -4)));

temp_TpVal = uicontrol('Style', 'Text',...
    'Position', [1550 470 120 20],...
    'String', num2str(roundn(val(1,1), -1)));

temp_TeVal = uicontrol('Style', 'Text',...
    'Position', [1550 540 120 20],...
    'String', num2str(roundn(val(3,1), -1)));

% make visible after adding all components
f.Visible = 'on';

    function salinity_SpCallBack(hObj, event)
        val(4,1) = get(event.AffectedObject, 'Value');
        set(salinity_SpVal, 'String', num2str(roundn(val(4,1), -4))); 
    end

    function salinity_SeCallBack(hObj, event)
        val(6,1) = get(event.AffectedObject,'Value');
        set(salinity_SeVal, 'String', num2str(roundn(val(6,1),-4)));
        update;
    end
        
    function temp_TpCallBack(hObj, event)
        val(1,1) = get(event.AffectedObject,'Value');
        set(temp_TpVal, 'String', num2str(roundn(val(1,1),-4)));
        update;
    end

    function temp_TeCallBack(hObj, event)
        val(3,1) = get(event.AffectedObject,'Value');
        set(temp_TeVal, 'String', num2str(roundn(val(3,1),-4)));
        update;
    end

    %GUI update
   function update
        hold off;
        [t,y] =  ode45(@(t,y) odefun_3Box_1Flux(t,y,val), tspan, y0); 
        plotGraphs;
   end

    %Draw plots
    function plotGraphs
       %create subplots
       p1 = subplot(1,4,1);
       p2 = subplot(1,4,2);
       p3 = subplot(1,4,3);
       
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
        q = k*(a*(y(:,2)-y(:,1))-b*(y(:,5)-y(:,4)));
        % q2 = k*(a*(y(:,3)-y(:,2))-b*(y(:,6)-y(:,5)));

        % Plot Flux 
        plot(p3, t,q);
        title(p3, 'Fluss-plot')
        xlabel(p3, 'time')
        ylabel(p3, 'Fluss')
        legend(p3, 'q') 
       
    end

end
