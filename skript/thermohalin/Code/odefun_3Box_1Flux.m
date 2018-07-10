function dydt = odefun_3Box_1Flux(t, y, const)


dt1 = 0;
dt2 = 0;
dt3 = 0;
ds1 = 0;
ds2 = 0;
ds3 = 0;

k = 1.5*10^(-6);
a = 1.5*10^(-4);
b = 8*10^(-4);
H = 0.0000005;
c = 0.00008;
d = 0.0009;

q = k*(a*(y(1)-y(2)) - b*(y(4)-y(5)));
if q > 0
    dt1 = c*(const(1)-y(1)) + q*(y(3)-y(1));
    dt2 = c*(const(2)-y(2)) + q*(y(1)-y(2));
    dt3 = c*(const(3)-y(3)) + q*(y(2)-y(3));
    ds1 = -H/2 + d*(const(4)-y(4)) + q*(y(6)-y(4));
    ds2 = -H/2 + d*(const(5)-y(5)) + q*(y(4)-y(5));
    ds3 =  H + d*(const(6)-y(6)) + q*(y(5)-y(6));
elseif q < 0
    dt1 = c*(const(1)-y(1)) + abs(q)*(y(2)-y(1));
    dt2 = c*(const(2)-y(2)) + abs(q)*(y(3)-y(2));
    dt3 = c*(const(3)-y(3)) + abs(q)*(y(1)-y(3));
    ds1 = -H/2 + d*(const(4)-y(4)) + abs(q)*(y(5)-y(4));
    ds2 = -H/2 + d*(const(5)-y(5)) + abs(q)*(y(6)-y(5));
    ds3 =  H + d*(const(6)-y(6)) + abs(q)*(y(4)-y(6));
end

dydt = [dt1; dt2; dt3; ds1; ds2; ds3];
