#
# expl.m
#
# (c) 2018 Prof Dr Andreas Müller, Hochschule Rapperswil
#
N = 1001;
M = 80;
u = zeros(3, N);
d = 800;
for i = (100:100 + d)
	x = pi * (i - 100) / d;
	u(2,i) = sin(x);
	u(1,i) = u(2,i);
end

fid = fopen("bw.tex", "w");

steps = [ 1, 50, 55, 58, 61, 63 ];
k = 0

for j = (1:M)
	for i = (1:N)
		u(3,i) = u(2,i);
		u(2,i) = u(1,i);
		if 1 == i
			u(1,i) = u(3,i) - u(2,i) * u(2,i+1);
		elseif N == i 
			u(1,i) = u(3,i) + u(2,i) * u(2,i-1);
		else
			u(1,i) = u(3,i) - u(2,i) * (u(2,i+1)-u(2,i-1));
		end
	end
	if k < size(steps)(2)
		printf("j=%d == steps(%d)=%d?\n", j, k+1, steps(k+1));
		if j == steps(k+1)
			fprintf(fid, "\\def\\pfad%c{\n", 'a' + k);
			fprintf(fid, "\\begin{scope}\n");
			fprintf(fid, "\\clip (0,-0.5) rectangle (12,3);\n");
			fprintf(fid, "\\draw[color=red] (0,%.4f)\n", u(1,1));
			for i = (2:N)
				fprintf(fid, "--(%.4f,%.4f)\n",
					12 * (i-1)/(N-1), 2 * u(1,i));
			end
			fprintf(fid, ";\n");
			fprintf(fid, "\\end{scope}\n");
			fprintf(fid, "\\node at (11,2.5) [right] {$N=%d$};\n", j);
			fprintf(fid, "}\n");
			k = k + 1;
		end
	end
end


fclose(fid);
