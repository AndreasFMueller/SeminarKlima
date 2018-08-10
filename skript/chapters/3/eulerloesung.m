y0 = 1;
x = (0:10) * 0.1;

y = lsode(@f, y0, x);
