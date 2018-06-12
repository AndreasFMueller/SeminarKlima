function Theta = calc_theta(X, a, x, y)
    ## ---
    b01 = X(:,1);
    ## ---
    b11 = X(:,2);
    b02 = X(:,3);

    Theta = b01 .* cos(0*a*x) .* sin(1 * y) ...
      + b11 .* cos(1*a*x) .* sin(1 * y) ...
      + b02 .* cos(0*a*x) .* sin(2 * y);
end