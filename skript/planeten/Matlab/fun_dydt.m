function dydt = fun_dydt(t,y, p)
%DTDT Summary of this function goes here
%   Detailed explanation goes here

    T_s    = y(1);
    T_t    = y(2);
    h2o    = y(3);
    clouds = y(4);

    %T_grad = T_s - T_t; 
    
    P_in = P_absorption() * (1-albedo(clouds));
    P_out = P_blackbody(T_s) * (1-greenhouse(h2o));
    
    T_grad = p(3) * 1./(clouds * T_s); 
    
    d_T_s    =    p(1)*(P_in - P_out); %- p(2)*h2o*T_s;
    %d_T_t   =                          p(2)*h2o*T_s - p(3)*P_blackbody(T_t)*albedo(clouds) + p(4)*(T_grad * h2o);
    d_h2o    =    p(5)*(P_in) - p(6)*((h2o^9 + h2o) * T_grad);    
    d_clouds =                  p(6)*((h2o^9 + h2o) * T_grad) - p(7)*(clouds^5 + clouds); % - clouds * convection;
   
    d_T_t=0;
    
%     d_h2o = vaporisation(T_s) *1e-1 + ( -escape(T_t) - precipitation(T_s) ) * h2o;

    dydt = [d_T_s; d_T_t; d_h2o; d_clouds];
end
