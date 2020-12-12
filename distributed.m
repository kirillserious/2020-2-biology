a = 2;
b = 3;
c = 0.2;
m = 4;
hold on
ode_fcn = @(t, y) systemFcn(t, y, a, b, c, m);

start_point = [b/a, 0, 0];
[zs, points] = ode45(ode_fcn, [0, 5], start_point);
us = points(:, 1);
vs = points(:, 2);
ws = points(:, 3);
plot(ws, vs)
plot(b/a, 0, '*r')
plot(c/(1-c), (b - a*c -b*c)/((1-c)^2), '*r')
%%
figure;

[u, v, w] = meshgrid(0:0.6:max([4 4 4]));
du = w;
dv = (-c./m) .*v + ((u.*v)./(m.*(1 + u)));
dw = a.*(u.^2) - b .* u + u.*v./(1+u) - m.*w;
q = quiver3(u, v, w, du, dv, dw, 2, 'color', [0, 0.4470, 0.7410]);
q.AutoScale = 'on';
q.MaxHeadSize = 5;
q.LineWidth = 0.5;
hold on;

w = -w;

du = w;
dv = (-c./m) .*v + ((u.*v)./(m.*(1 + u)));
dw = a.*(u.^2) - b .* u + u.*v./(1+u) - m.*w;
q = quiver3(u, v, w, du, dv, dw, 2, 'color', [0, 0.4470, 0.7410]);
q.AutoScale = 'on';
q.MaxHeadSize = 5;
q.LineWidth = 0.5;

xlabel('$$u$$', 'interpreter', 'latex');
ylabel('$$v$$', 'interpreter', 'latex');
zlabel('$$w$$', 'interpreter', 'latex');
color2 = [0.8500, 0.3250, 0.0980];
plot3(0, 0, 0, '.', 'MarkerSize', 20, 'Color', color2)
plot3(b/a, 0, 0, '.', 'MarkerSize', 20, 'Color', color2)
plot3(c/(1-c), (b - a*c -b*c)/((1-c)^2), 0, '.', 'MarkerSize', 20, 'Color', color2)
function dydx = systemFcn(t, y, a, b, c, m)
    dydx = [y(3);...
        (-c./m) .*y(2) + ((y(1).*y(2))./(m.*(1 + y(1))));
        a.*(y(1).^2) - b .* y(1) + y(1).*y(2)./(1 + y(1)) - m.*y(3)];
end