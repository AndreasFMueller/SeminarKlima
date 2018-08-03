#
# spektrum.m
#
# (c) 2018 Prof Dr Andreas Müller, Hochschule Rapperswil
#
global n
n = 512
N = 2 * n
A = 0.5;
noise = 0.3;

global a
a = zeros(1,n+2);
a(40) = 1;
global b
b = zeros(1,n-1);
b(80) = 0.2;
b(81) = 0.24;
b(82) = 0.24;
b(83) = 0.2;

a = A * a;
b = A * b;

function ret = f(x)
	global a;
	global b;
	global n;
	s = 0;
	for i = (0:n)
		s = s + a(i+1) * cos(i*x);
	end
	for i = (1:n-1)
		s = s + b(i) * sin(i*x);
	end
	ret = s;
endfunction

t = (0:N-1) * 2 * pi / N;
y = zeros(1,N);
for i = (1:N)
	y(i) = f(t(i));
end

y = y + noise * (rand(1, N) - 0.5);

fid = fopen("sp.tex", "w");

fprintf(fid, "\\def\\funk{\n");
fprintf(fid, "\\draw[color=red] (%.4f,%.4f)\n", t(1), y(1));
for i = (2:N)
	fprintf(fid, "--(%.4f,%.4f)\n", t(i), y(i));
end
fprintf(fid, ";\n}\n");

s = fft(y);

cmax = max(abs(s))

fprintf(fid, "\\def\\spek{\n");
fprintf(fid, "\\draw[color=red] (%.4f,%.4f)\n", t(1), y(1)/cmax);
for i = (2:N)
	fprintf(fid, "--(%.4f,%.4f)\n", t(i), abs(s(i))/cmax);
end
fprintf(fid, ";\n}\n");

fclose(fid);
