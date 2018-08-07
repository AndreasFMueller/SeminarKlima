#
# auf.m -- aufwandkurve
#
# (c) 2018 Prof Dr Andreas Müller, Hochschule Rapperswil
#
fid = fopen("auf.tex", "w");

fprintf(fid, "\\def\\nlogn{\\draw[color=red] (2,%.4f)\n", (2+log2(2))/3);
for x = 2 + 40 * (1:100) / 100
	fprintf(fid, "--(%.4f, %.4f)\n", x, (x + log2(x))/3);
end
fprintf(fid, ";\n}\n");

fclose(fid);
