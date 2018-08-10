a = linspace(-1.2,1.2,200);

fig = figure(1);
plot(a, a); hold on
% for i = 2:10
% plot(a, a + a.^(i*2 - 1));
% end
plot(a, a + a.^7); hold on
hold off;
ylim([-2,2])
xlim([-1.2,1.2])
xlabel('x')
ylabel('f(x)')
grid

saveas(fig,'figures/limiter', 'epsc')