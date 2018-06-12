function Psi = calc_psi(X, a, x, y)
    ## ---
    a11 = X(:,11);
    ## ----
    a21 = X(:,12);
    a12 = X(:,13);
    ## ---
    a31 = X(:,14);
    a22 = X(:,15);
    a13 = X(:,16);
    
    Psi = a11 .* sin(1*a*x) .* sin(1*y) ...
      + a21 .* sin(2*a*x) .* sin(1*y) ...
      + a12 .* sin(1*a*x) .* sin(2*y) ...
      + a31 .* sin(3*a*x) .* sin(1*y) ...
      + a22 .* sin(2*a*x) .* sin(2*y) ...
      + a13 .* sin(1*a*x) .* sin(3*y);
end