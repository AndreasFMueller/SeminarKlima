% Groupsim THC-Box-1Flux
% Mathsem 2018 Klimawandel, HSR

%% Startvariablen, Timebase, Umgebungskonstanten

y0 = [2.9; 1; 28; 0.0347; 0.0347; 0.036];
tspan = [0 90000];
val = [2.9; 1; 28; 0.0347; 0.0347; 0.0356];

% Variablen für fluxberechnung
k = 1.5*10^(-6);
a = 1.5*10^(-4);
b = 8*10^(-4);

results = zeros(6,1);
counter = 0;

t1inc = (4)/7;
t2inc = (4)/7;
t3inc = (4)/7;
s1inc = (0.05-0.03)/7;
s2inc = (0.05-0.03)/7;
s3inc = (0.05-0.03)/7;


for i = 2:t1inc:6
    for j = 0:t2inc:4
            for k = 25:t3inc:29
                for l = 0.02:s1inc:0.04 
                    for m = 0.03:s2inc:0.05
                        for n = 0.03:s3inc:0.05
                            [t,y] = ode45(@(t,y) odefun_3Box_1Flux(t,y,val), tspan, y0);
                            q = k*(a*(y(:,1)-y(:,2))-b*(y(:,4)-y(:,5)));
                            if(q(end)<0)
                                results = [results [i;j;k;l;m;n]];
                            end
                            counter = counter + 1;
                            val(6) = val(6) + s3inc; 
                        end
                        val(5) = val(5) + s2inc;
                        val(6) = 0.03;
                    end
                    val(4) = val(4) + s1inc;
                    val(5) = 0.03;
                end
                val(3) = val(3) + t3inc;
                val(4) = 0.03;
            end
            val(2) = val(2) + t2inc;
            val(3)= 0;
    end  
    val(1) = val(1) + t1inc;
    val(2) = 0;
end
val(1) = 0;

save('groupsim_ws')
