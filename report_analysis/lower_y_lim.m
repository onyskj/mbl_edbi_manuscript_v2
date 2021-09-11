function value = lower_y_lim(x)

[l,u] = bounds(x);
r = range(x);

value = l-r/10;
