#
# burgdgl.m
#
# (c) 2018 Prof Dr Andreas Müller, Hochschule Rapperswil
#
global N;
N = 81;

function cdot = f(c, t)
	global N;
	cdot = zeros(N, 1);
	n = (N-1)/2;
	for k = (-n:n)
		top = n + k;
		if top > n
			top = n;
		end
		bottom = -n + k;
		if bottom < -n
			bottom = -n;
		end
		s = 0;
		for l = (bottom:top)
			j = k-l;
			s = s + l * c(j+n+1) * c(l+n+1);
		end
		cdot(k+n+1) = s;
	end
	cdot = -cdot;
endfunction

c = zeros(1, N)
c(1, (N-1)/2 - 1) = -0.5;
c(1, 2 + (N-1)/2 + 1) =  0.5;

c

steps = 20;
t = zeros(1,steps);
for j = (1:4)
	t(1,1+j) = j * 0.1;
end
for j = (1:10)
	t(1,5+j) = 0.4 + 0.02 * j;
end
for j = (1:steps-15)
	t(1,15+j) = j;
end

t

C = lsode(@f, c, t)

# compute functions form fourier coefficients

x = (-100:100) * pi / 100;
n = (N-1)/2;
k = (-n:n);

F = exp(i * x' * k);
size(F)

y = real((F * C') / i)

fid = fopen("r.tex", "w");
for j = 1:steps
	fprintf(fid, "\\def\\pfad%c{\n", 'a' + j - 1);
	fprintf(fid, "\\draw[color=red] (%.4f,%.4f)\n", x(1), y(1,j));
	for i = 2:201
		fprintf(fid, "--(%.4f,%.4f)\n", x(i), y(i,j));
	end
	fprintf(fid, ";}\n");
end
fclose(fid);

