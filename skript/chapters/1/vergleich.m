#
# vergleich.m -- compute planck radiation law distribution
#
# (c) 2018 Prof Dr Andreas Müller, Hochschule Rapperswil
#
global h = 6.62607004e-34;
global k = 1.38064852e-23;
global c = 299792458;
global Tsun = 5778
global Tearth = 278.7
global Rsun = 6.957e8
global Rearth = 6371000
global a = 1.496e11

function retval = planck(lambda, T)
	global h
	global k
	global c
	n = 2 * pi * h * c^2 / lambda^5;
	retval = n / (exp(h * c / (lambda * k * T)) - 1);
end

function retval = solar(lambda)
	global Tsun
	global Rearth
	global Rsun
	global a
	p = planck(lambda, Tsun);
	retval = pi * (Rearth^2) * p * (Rsun/a)^2;
end

function retval = earth(lambda, T)
	global Rearth
	retval = 4 * pi * planck(lambda, T) * (Rearth^2);
end

global steps = 1000
global lambdaa = 0.000000100; # 100nm
global lambdab = 0.000100000; # 100mu m
global f = exp(log(lambdab/lambdaa) / steps)

global m = 1e-24

global fid = fopen("vplot.tex", "w")

#
# Temperatur der Sonne
#
x = lambdaa;
y = m * solar(x) * (x/lambdaa)

fprintf(fid, "\\def\\sonnenkurve{\n");
fprintf(fid, "\\draw[color=red] (%.3f, %.3f)\n", x, y);
for i = 1:steps
	x = x * f;
	y = m * solar(x) * (x/lambdaa);
	fprintf(fid, "--(%.3f, %.3f)\n", log10(x) + 7, y);
endfor

fprintf(fid, ";\n");
fprintf(fid, "}\n");

x = lambdaa;

fprintf(fid, "\\def\\sonnenflaeche{\n");
fprintf(fid, "\\fill[color=red!10] (%.3f, %.3f)\n", x, y);
for i = 1:steps
	x = x * f;
	y = m * solar(x) * (x/lambdaa);
	fprintf(fid, "--(%.3f, %.3f)\n", log10(x) + 7, y);
endfor
fprintf(fid, "--cycle;\n");
fprintf(fid, "}\n");

#
# Temperatur der Erde

function	erdkurve(T, farbe)
	global lambdaa
	global m
	global steps
	global f
	global fid

	x = lambdaa;
	y = m * earth(x, T) * (x / lambdaa)

	fprintf(fid, "\\draw[color=%s] (%.3f, %.3f)\n", farbe, x, y);
	for i = 1:steps
		x = x * f;
		y = m * earth(x, T) * (x/lambdaa);
		fprintf(fid, "--(%.3f, %.3f)\n", log10(x) + 7, y);
	endfor
	fprintf(fid, ";\n")
end

fprintf(fid, "\\def\\erdkurven{\n");
erdkurve(Tearth + 5, "blue!30");
erdkurve(Tearth - 5, "blue!30");
erdkurve(Tearth, "blue");
fprintf(fid, "}\n");

fprintf(fid, "\\def\\erdflaeche{\n");
	x = lambdaa;
	y = m * earth(x, Tearth) * (x / lambdaa)
	fprintf(fid, "\\fill[color=blue!10] (%.3f, %.3f)\n", x, y);
	for i = 1:steps
		x = x * f;
		y = m * earth(x, Tearth) * (x/lambdaa);
		fprintf(fid, "--(%.3f, %.3f)\n", log10(x) + 7, y);
	endfor
	fprintf(fid, "--(3,0)--(0,0)--cycle;\n")
fprintf(fid, "}\n");

fclose(fid);

