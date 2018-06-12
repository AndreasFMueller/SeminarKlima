function Psi = calc_psi(X, a, x, y)
    ## ---
    a11 = X(:,3);
    
    Psi = a11 .* sin(1*a*x) .* sin(1 * y);
end