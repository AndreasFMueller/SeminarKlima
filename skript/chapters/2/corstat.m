#
# corstat.m -- stationäre lösung für coriolis effekt
#
# (c) 2018 Prof Dr Andreas Müller, Hochschule Rapperswi
#
global h;
global beta;

y0 = 1.2;
v0 = -1;
h = -0.1;
beta = 1.2;

function Xdot = f(X, y)
	global beta;
	global h;
	vprime = -(beta * sin(y) * X(1) - h) / (2 * X(2));
	Xdot = [ beta * sin(y) - (X(1) / X(2)) * vprime; vprime ];
endfunction

function simulate(yfrom, yto, v0, filename)
	global h;
	global beta;
	N = 100;
	y = yfrom + (yto - yfrom) * (0:N)/N;
	X0 = [ 0; v0 ];
	X = lsode(@f, X0, y);
	result(:,1) = y;
	result(:,2:3) = X;
	# plot the vector field
	fid = fopen(filename, "w");
	fprintf(fid, "\\def\\feld#1{\n");
	for i = (1:10:100)
		fprintf(fid, "\\draw[->,color=red] (0,%.4f)--({#1*%.4f},{%.4f+#1*%.4f});\n",
			y(i), X(i,1), y(i), X(i,2));
		fprintf(fid, "\\fill[color=red] (0,%.4f) circle[radius=0.01];\n",
			y(i));
	end
	fprintf(fid, "}\n");
	fclose(fid);
endfunction

simulate(0.2, 1.2, 1, "up.tex")
simulate(1.2, 0.2, -1, "down.tex")
