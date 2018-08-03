#
# beispiel.m
#
# (c) 2018 Prof Dr Andreas Müller, Hochschule Rapperswil
#

fid = fopen("triangle.tex", "w");

fprintf(fid, "\\pgfmathparse{180/3.14159}\n");
fprintf(fid, "\\xdef\\anglescale{\\pgfmathresult}\n");

function ret = dreieck(fid, m, name)
	n = 2 * m;
	N = 2 * n;
	y = zeros(N, 1);
	y(1:m,1) = (1:m) / m;
	y(m+1:m+n,1) = 1 - (1:n)/m;
	y(m+n+1:N,1) = (1:m) / m - 1;
	y = shift(y, 1, 1);
	ret = fft(y) / n
	fprintf(fid, "\\def\\%s{\n", name);
	fprintf(fid, "\\draw[color=red] plot[domain=0:6.283,samples=100] ({\\x},{");
	for j = (2:2:n)
		fprintf(fid, "-(%.5f)*sin(%d*\\x*\\anglescale)", imag(ret(j,1)), j - 1)
	endfor
	fprintf(fid, "});\n}\n");
endfunction

dreieck(fid, 1, "eins");
dreieck(fid, 2, "zwei");
dreieck(fid, 3, "drei");
dreieck(fid, 4, "vier");
dreieck(fid, 5, "fuenf");
dreieck(fid, 6, "sechs");
dreieck(fid, 7, "sieben");
dreieck(fid, 8, "acht");
dreieck(fid, 10, "zehn");
dreieck(fid, 20, "zwanzig");

#dreieck(fid, 1000, "tausend");

fclose(fid);

j = (1:6);
k = 2*j-1;
8./(pi^2*k.^2)
