#
# ell.m -- Auswertung des ellipitischen Integrals (12.2) im Buch
#
# (c) 2018 Prof Dr Andreas Müller, Hochschule Rapperswil
#
global gammamax;
global theta;
gammamax = 23.4 * pi / 180;

N = 100;

function retval = f(phi)
	global theta;
	global gammamax;
	x = cos(theta)*sin(gammamax)*cos(phi)-sin(theta)*cos(gammamax);
	retval = sqrt(1 - x^2);
end

for i = (1:N-1)
	theta = (i - N/2) * pi / (N + 1);
	j = quad(@f, 0, 2 * pi) * 2 / pi^2;
	printf("%d: %f -> %f\n", i, theta, j);
end





