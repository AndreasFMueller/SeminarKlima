function Xprime = f(X, y)
    global beta;
    global h;
    vprime = -(beta * sin(y) * X(1) - h) / (2 * X(2));
    Xprime = [ beta * sin(y) - (X(1) / X(2)) * vprime; vprime ];
endfunction
