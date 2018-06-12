function Theta = calc_theta(X, a, x, y)
    ## ---
    b11 = X(:,1);
    b02 = X(:,2);

    Theta = b11 .* cos(1*a*x) .* sin(1 * y) ...
      + b02 .* cos(0*a*x) .* sin(2 * y);
end