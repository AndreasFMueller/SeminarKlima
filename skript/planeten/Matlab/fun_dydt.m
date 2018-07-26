function dydt = fun_dydt(t,y)
%DTDT Summary of this function goes here
%   Detailed explanation goes here

    global PLANET;
    global CONST;
    global PARAM

    T_s = y(1);
    H   = y(2);
    C   = y(3); 
    
    S_solar = CONST.sigma * CONST.T_sun^4 * (CONST.R_sun / PLANET.A)^2;
    P_solar = S_solar * pi* PLANET.R^2;
    
    P_blackbody = 4* pi * PLANET.R^2 * CONST.sigma * T_s.^4;
    
    alpha = ((PARAM.alpha_max - PARAM.alpha_min) * C) + PARAM.alpha_min;
    beta =  PARAM.beta_max * H;
    
    P_in  = P_solar * (1 - alpha);
    P_out = P_blackbody  * (1 - beta);
    A = (4* pi * PLANET.R^2);
    
    T_grad = PARAM.xi3 * 1./(C);  % * T_s); 
    
    d_T_s  = PARAM.xi1 * (P_in - P_out)/A                                                  ;
    d_H    = PARAM.xi2 * T_s    - PARAM.xi3 * (H^9 + H) * T_grad                           ;    
    d_C    =                      PARAM.xi3 * (H^9 + H) * T_grad   - PARAM.xi4 * (C^5 + C) ;
   
    dydt = [d_T_s; d_H; d_C];
end
