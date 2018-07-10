#
# ein.m -- plot the dependency of 
#
# (c) 2018 Prof Dr Andreas Müller, Hochschule Rapperswil
#
gamma = pi / 6;

function retval = Phi0(theta, gamma)
	phi0 = acos(-tan(gamma)/tan(theta));
#	printf("phi0(%f) = %f\n", theta, phi0);
	retval = phi0;
endfunction

function retval = Ein(theta, gamma)
	if (gamma < 0)
		theta = pi - theta;
		gamma = - gamma;
	end
	if (theta <= gamma)
		retval = 2 * pi * cos(theta) * sin(gamma);
	elseif (theta > pi - gamma)
		retval = 0;
	else
		phi0 = Phi0(theta, gamma);
		s = 2 * phi0 * cos(theta) * sin(gamma);
		s = s + 2 * sin(theta) * cos(gamma) * sin(phi0);
		retval = s;
	end
endfunction

function retval = F(t)
	global theta
	global gammamax
	gamma = atan(tan(gammamax) * sin(t));
	retval = Ein(theta, gamma);
endfunction

N = 100

global gammamax;
global theta;

gammamax = 23.4 * pi / 180;

fid = fopen("insolation.tex", "w")
fprintf(fid, "\\draw[color=red, line width=1.4pt] ");
for i = (0:N+1)
	theta = pi * i / (N + 1);
	j = quad(@F, 0.000001, 2 * pi - 0.000001);
	printf("%d: %f -> %f\n", i, theta, j * 0.101522367)
	if (i == 0)
		fprintf(fid, "(%.3f, %.3f)\n", theta, j * 0.101522);
	else
		fprintf(fid, "--(%.3f, %.3f)", theta, j * 0.101522);
	end
end
fprintf(fid, ";\n");
fclose(fid);


