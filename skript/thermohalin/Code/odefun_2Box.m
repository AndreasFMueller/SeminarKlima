function [dydt] = odefun(t, y, const)

% T1C = 7;
% T2C = 19;
% T3* =
% S1C =0.02;
% S2C =0.035;
% S3* =


%Constants

k = 1.5*10^(-6);
a = 1.5*10^(-4);
b = 8*10^(-4);
H = 0.0000001;
c = 0.0001;
d = 0.00001;
%dydt = zeros(4,1);


q = k*(a*(y(2)-y(1))-b*(y(4)-y(3)));

dt1 = c*(const(1)-y(1))+abs(q)*(y(2)-y(1));
dt2 = c*(const(2)-y(2))+abs(q)*(y(1)-y(2));
ds1 = -H + d*(const(3)-y(3)) + abs(q)*(y(4)-y(3));
ds2 = H + d*(const(4)-y(4)) + abs(q)*(y(3)-y(4));

% T1 = y(1);
% T2 = y(2);
% S1 = y(3);
% S2 = y(4);


dydt = [dt1; dt2; ds1; ds2];