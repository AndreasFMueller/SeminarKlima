## Higher Dimensional Lorenz System
function dx = higher_dimensional_lorenz(X, T, kappa, nu, a, c, T0)
  b01 = X(1);
  ## ---
  b11 = X(2);
  b02 = X(3);
  ## ---
  a11 = X(4);

  order = 2;

  dx = zeros(order^2,1);
  dx(1) = - kappa * b01;
  dx(2) = - (a**2 + 1) * kappa * b11 ...
          + (a * T0) /  pi * a11 ...
          + a * a11 * b02;
  dx(3) = - 4 * kappa * b02 ...
          - a / 2 * a11 * b11;
  dx(4) = - (a**2 + 1) * nu * a11 ...
          + (a*c)/(a**2 + 1) * b11;
  return
end

