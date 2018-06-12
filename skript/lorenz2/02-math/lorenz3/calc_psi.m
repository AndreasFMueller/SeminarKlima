function Psi = calc_psi(X, a, x, y)
    ## ---
    a11 = X(:,7);
    ## ----
    a21 = X(:,8);
    a12 = X(:,9);
    
    Psi = a11 .* sin(1*a*x) .* sin(1 * y) ...
      + a12 .* sin(1*a*x) .* sin(2 * y) ...
      + a21 .* sin(2*a*x) .* sin(1 * y);
end