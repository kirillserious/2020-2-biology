%%
a = 2;
b = 3;
c = 0.1;
my_system = @(t, y) systemFcn(t, y, a, b, c);

%%
figure;
draw_point(my_system, [b/a, 0], 0.1, 250);
%%
figure;
draw_point(my_system, [c/(1-c), (b - b*c - a*c)/(1-c)^2], 0.01, 5);
IsP3Exists = c < (b/(a + b))
Discremenant = (c/(1-c))^2*(-a+b-(a+b)*c)^2 - 4*(b - (a+b)*c)

%%
figure;
draw_all(my_system, 5, 10);
IsP3Exists = c < (b/(a + b))
Discremenant = (c/(1-c))^2*(-a+b-(a+b)*c)^2 - 4*(b - (a+b)*c)

color2 = [0.8500, 0.3250, 0.0980];
color3 = [0.9290, 0.6940, 0.1250];


plot([c/(1-c), c/(1-c)], [0, 5], 'Color', color3, 'LineWidth', 2)
xs = 0:0.01:5;
plt1 = plot(xs, -a*(xs.^2) + (b-a)*xs + b, 'Color', color3, 'LineWidth', 2)
plt2 = plot([0, b/a, c/(1-c)], [0, 0, (b - b*c - a*c)/(1-c)^2], '.', 'MarkerSize', 15, 'Color', color2)
legend([plt2, plt1], 'Особые точки', 'Изоклины')
function draw_point (ode_fcn, point, radius, n)
    hold on;
    grid on;
    color1 = [0, 0.4470, 0.7410];
    color2 = [0.8500, 0.3250, 0.0980];

    start_xs = point(1) + radius .* sin(linspace(0, 2*pi, n));
    start_ys = point(2) + radius .* cos(linspace(0, 2*pi, n));
    mask = (start_xs > 0) & (start_ys > 0);
    start_xs = start_xs(mask);
    start_ys = start_ys(mask);
    
    for i = 1:numel(start_xs)
        start_point = [start_xs(i), start_ys(i)];
        [~, points] = ode45(ode_fcn, [0, 1000], start_point);
        xs = points(:, 1);
        ys = points(:, 2);
        
        quiver(xs(1:end-1), ys(1:end-1), xs(2:end) - xs(1:end-1), ys(2:end) - ys(1:end-1), 0, 'Color', color1);
    end
    
    dotPlt = plot(point(1), point(2), '.', 'MarkerSize', 20, 'Color', color2);
    
    offset = radius ./ sqrt(2);
    axis([max(0, point(1)-offset), point(1)+offset, ...
            max(0, point(2)-offset), point(2)+offset]);
    xlabel('$$u$$', 'Interpreter', 'latex');
    ylabel('$$v$$', 'Interpreter', 'latex');
    legend(dotPlt, 'Особая точка', 'Location', 'northeast');
end

function draw_all(ode_fcn, square, n)
    color1 = [0, 0.4470, 0.7410];
    
    hold on, grid on;
    start_xs = linspace(0.01, square, n);
    start_ys = linspace(0.01, square, n);
    for i = 1:numel(start_xs)
        for j = 1:numel(start_ys)
            start_point = [start_xs(i), start_ys(j)];
            [~, points] = ode45(ode_fcn, [0, 10], start_point);
            xs = points(:, 1);
            ys = points(:, 2);
            quiver(xs(1:end-1), ys(1:end-1), xs(2:end) - xs(1:end-1), ys(2:end) - ys(1:end-1), 0, 'Color', color1);
        end
    end
    xlabel('$$u$$', 'Interpreter', 'latex');
    ylabel('$$v$$', 'Interpreter', 'latex');
    axis([0, square, 0, square])
end

function dydx = systemFcn(t, y, a, b, c)
    dydx = [-a.*(y(1).^2) + b.*y(1) - ((y(1).*y(2))./(1 + y(1)));...
        (-c) .*y(2) + ((y(1).*y(2))./(1 + y(1))) ];
end