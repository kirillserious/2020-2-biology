figure;
arg_2 = linspace(0, 4, 20);
my_system = @(t, y) systemFcn(t, y, a, b, c, m);
%for i = 1:20
%    for k = 1:20
        [T, Y] = ode45(my_system, [0, 100], [b/a+0.01, 0.001, -0.1]);%[arg_2(i),arg_2(k), 0]);
        plt = plot3(Y(:,1), Y(:,2), Y(:,3), 'color', [0, 0.4470, 0.7410], 'linew', 1);
        %quiver3(Y(:,1,1:end-1), Y(:,2,1:end-1), Y(:,3,1:end-1), ...
        %    Y(:,1,2:end) - Y(:,1,1:end-1), Y(:,2,2:end) - Y(:,2,1:end-1), Y(:,3,2:end) - Y(:,3,1:end-1), 0)
        hold on
%    end
%end
xlabel('$$u$$', 'interpreter', 'latex');
ylabel('$$v$$', 'interpreter', 'latex');
zlabel('$$w$$', 'interpreter', 'latex');
axis([0 4 0 4 -4 4])
plot3(0, 0, 0, '.', 'MarkerSize', 20, 'Color', color2)
plot3(b/a, 0, 0, '.', 'MarkerSize', 20, 'Color', color2)
pp = plot3(c/(1-c), (b - a*c -b*c)/((1-c)^2), 0, '.', 'MarkerSize', 20, 'Color', color2)
legend([plt, pp], 'Траектория', 'Особые точки')
grid on
function dydx = systemFcn(t, y, a, b, c, m)
    dydx = [y(3);...
        (-c./m) .*y(2) + ((y(1).*y(2))./(m.*(1 + y(1))));
        a.*(y(1).^2) - b .* y(1) + y(1).*y(2)./(1 + y(1)) - m.*y(3)];
end