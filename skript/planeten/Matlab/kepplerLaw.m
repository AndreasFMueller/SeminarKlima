%    mercury venus earth
a = [5.790918e10 1.08208e11   1.4959789e11 2.2793664e11]; %semi major axis
b = [5.66716e10  1.082064e11  1.49577e11   2.269399e11]; %semi minor axis

e = sqrt(1-((b.^2)./(a.^2)));
a_mean = a.*(1+((e.^2)./2));
a_mean2 = (3/2).*a - (b.^2)./(2.*a);
semilogy(a); hold on;
semilogy(b);
semilogy(a_mean); hold off;


%%

a = a(1);
b = b(1);

e = sqrt(1-(b/a));
N = 100;
E = zeros(1, N);
M = zeros(1, N);

for i = 1:N
    M(i) = 2*pi*(i-1)/N;
    E(i) = fsolve(@(x)x-e*sin(x) - M(i), 1);
end

v = acos((cos(E)-e)./(1 - e*cos(E)));

r = a * (1-e^2) ./ (1 + e*cos(v));

polar(v, r, 'x'); hold on
polar(M, r, 'x'); hold off
mean(r)






