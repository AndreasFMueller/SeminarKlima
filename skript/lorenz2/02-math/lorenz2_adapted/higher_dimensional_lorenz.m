## Higher Dimensional Lorenz System
function dx = higher_dimensional_lorenz(X, T, kappa, nu, a, c, T0)
  ## ---
  b11 = X(1);
  b02 = X(2);
  ## ---
  a11 = X(3);

  dx = zeros(3,1);
  dx(1) = - (a**2 + 1) * kappa * b11 ...
          + (a * T0) /  pi * a11 ...
          + a * a11 * b02;
  dx(2) = - 4 * kappa * b02 ...
          - a / 2 * a11 * b11;
  dx(3) = - (a**2 + 1) * nu * a11 ...
          + (a*c)/(a**2 + 1) * b11;
  return
end

