#
# euler.m
#
# (c) 2018 Prof Dr Andreas Mueller, Hochschule rapperswil
#
a = 1
y0 = 1
n = 10
h = 1 / n

q0 = (1 - a*h);
q1 = (1 - a*h + 1/2 * a^2*h^2);

y = zeros(11,8);
y(:,1) = h * (0:10)';
y(:,2) = y0 * exp(-(0:10)*h)';
y(:,3) = y0 * q0.^(0:10)';
y(:,6) = y0 * q1.^(0:10)';

n = 100
h = 1 / n

q0 = (1 - a*h);
q1 = (1 - a*h + 1/2 * a^2*h^2);
y(:,4) = y0 * q0.^(0:10:100)';
y(:,7) = y0 * q1.^(0:10:100)';

n = 1000
h = 1 / n

q0 = (1 - a*h);
q1 = (1 - a*h + 1/2 * a^2*h^2);
y(:,5) = y0 * q0.^(0:100:1000)';
y(:,8) = y0 * q1.^(0:100:1000)';



format long

y

y(:,3) = y(:,5);
y(:,4) = y(:,8);

x = (0:10) * 0.1;

global counter;
counter = 0;

function ret = f(y, x)
	global counter;
	counter = counter + 1;
	ret = -y;
endfunction

y(:,5) = lsode(@f, y0, x);
y(:,1:5)

counter
