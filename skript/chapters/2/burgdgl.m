#
# burgdgl.m
#
# (c) 2018 Prof Dr Andreas Müller, Hochschule Rapperswil
#
global N;
N = 41;


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
endfunction

c = zeros(1, N)
c(1, (N-1)/2) = -0.5;
c(1, 2 + (N-1)/2) =  0.5;

c

t = 0:1;

C = lsode(@f, c, t)

# compute functions form fourier coefficients

x = (-100:100) * pi / 100;
n = (N-1)/2;
k = (-n:n);

F = exp(i * x' * k);
size(F)

y = real((F * C(1,:)') / i)

fid = fprintf("r.tex", "w");
fprintf(fid, "\\draw (%.4f,%.4f)\n", x(1), y(1));
for i = 2:201
	fprintf(fid, "--(%.4f,%.4f)\n", x(i), y(i));
end
fprintf(fid, ";\n");
fclose(fid);

