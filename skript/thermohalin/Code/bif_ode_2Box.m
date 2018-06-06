function dydt = bif_ode_2Box(t, x)

dx = t-abs(1-x)*x;

dydt = dx;