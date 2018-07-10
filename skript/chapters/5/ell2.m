#
# ell2.m -- Auswertung des elliptischen Integrals
#
# (c) 2018 Prof Dr Andreas Müller, Hochschule Rapperswil
#

global earthgamma = 23.4 * pi / 180;
global gamma;
global theta;

function retval = f(phi)
	global gamma
	global theta
	y = sin(gamma) * sin(theta) * cos(phi) + cos(gamma) * cos(theta);
	retval = sqrt(1 - y * y) / (2 * pi^2);
endfunction

fid = fopen("elltheta.tex", "w");

function	plotcurve(fid, g, color, linewidth)
	global gamma
	global theta
	gamma = g;
	fprintf(fid, "\\draw[color=%s,line width=%.1fpt]\n", color, linewidth);
	theta = 0;
	thetastep = pi / 100;
	scale = 4;
	first = 1;
	while (theta < pi + thetastep/2)
		i = 4 * quad(@f, 0, 2*pi);
		if (first == 1)
			fprintf(fid, "(%f,%f)\n", theta, i);
			first = 0;
		else
			fprintf(fid, "--(%f,%f)\n", theta, i);
		end
		theta = theta + thetastep
	end
	fprintf(fid, ";\n");
end

for i = (0:9)
	g = 10 * i * pi / 180;
	plotcurve(fid, g, "red!20", 1.0);
end

plotcurve(fid, earthgamma, "red", 1.4)

fclose(fid);


