% Groupsim THC-Box-1Flux
% Mathsem 2018 Klimawandel, HSR

%% Startvariablen, Timebase, Umgebungskonstanten

y0 = [5; 5; 5; 0.032; 0.032; 0.042;];
tspan = [0 90000];
val = [0; 0; 0; 0.03; 0.03; 0.03];


% Variablen für fluxberechnung
k = 1.5*10^(-6);
a = 1.5*10^(-4);
b = 8*10^(-4);

results = zeros(4,1);
counter = 0;

iinc = (20)/10;
jinc = (20)/10;
kinc = (0.05-0.03)/10;
linc = (0.05-0.03)/10;


for i = 0:iinc:25
    for j = 0:jinc:25
        for k = 0.03:kinc:0.05 
            for l = 0.03:linc:0.05
                [t,y] = ode45(@(t,y) odefun_3Box_1Flux(t,y,val), tspan, y0);
                q = k*(a*(y(:,2)-y(:,1))-b*(y(:,5)-y(:,4)));
                if(q(end)<0)
                    results = [results [i;j;k;l]];
                end
                counter = counter + 1;
                val(6) = val(6) + linc;               
            end
            val(4) = val(4) + kinc;
            val(6) = 0.03;
        end
        val(3) = val(3) + jinc;
        val(4) = 0.03;
    end  
    val(1) = val(1) + iinc;
    val(3) = 5;
end
val(1) = 5;

save('groupsim_ws')
