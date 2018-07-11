function dydt = fun_dydt(t,y)
%DTDT Summary of this function goes here
%   Detailed explanation goes here

    global PLANET;
    global CONST;
    global PARAM

    T_s = y(1);
    H   = y(2);
    C   = y(3); 
    
    P = pi * PLANET.R^2 * CONST.sigma * CONST.T_sun^4 * (CONST.R_sun / PLANET.A)^2;
    P_absorption = P / (4* pi * PLANET.R^2); %W/m^2
    
    P = 4* pi * PLANET.R^2 * CONST.sigma * T_s.^4;
    P_blackbody  = P / (4* pi * PLANET.R^2); %W/m^2
    
    P_in  = P_absorption * (1 - (((PARAM.alpha_max - PARAM.alpha_s) * C) + PARAM.alpha_s) );
    P_out = P_blackbody  * (1 - ( PARAM.xi8 * H)         );
    
    T_grad = PARAM.xi3 * 1./(C * T_s); 
    
    d_T_s  = PARAM.xi1 * (P_in - P_out)                                                    ;
    d_H    = PARAM.xi2 * T_s    - PARAM.xi3 * (H^9 + H) * T_grad                           ;    
    d_C    =                      PARAM.xi3 * (H^9 + H) * T_grad   - PARAM.xi4 * (C^5 + C) ;
   
    dydt = [d_T_s; d_H; d_C];
end
