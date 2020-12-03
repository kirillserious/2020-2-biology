%%
a = 1;
b = 1;
c = 1;
my_system = @(t, y) systemFcn(t, y, a, b, c);

%%
figure;
draw_point(my_system, [0, 0], 0.1, 100);


function draw_point (ode_fcn, point, radius, n)
    hold on;
    grid on;
    
    start_xs = point(1) + radius .* sin(linspace(0, 2*pi, n));
    start_ys = point(2) + radius .* cos(linspace(0, 2*pi, n));
    mask = (start_xs > 0) & (start_ys > 0);
    start_xs = start_xs(mask);
    start_ys = start_ys(mask);
    
    for i = 1:numel(start_xs)
        start_point = [start_xs(i), start_ys(i)];
        [~, points] = ode45(ode_fcn, [0, 5], start_point);
        xs = points(:, 1);
        ys = points(:, 2);
        
        quiver(xs(1:end-1), ys(1:end-1), xs(2:end) - xs(1:end-1), ys(2:end) - ys(1:end-1), 0);
    end
    
    plot(point(1), point(2), 'r.', 'MarkerSize', 20);
    
    offset = radius ./ sqrt(2);
    axis([max(0, point(1)-offset), point(1)+offset, ...
            max(0, point(2)-offset), point(2)+offset]);
    xlabel('u');
    ylabel('v');
end

function dydx = systemFcn(t, y, a, b, c)
    dydx = [-a.*(y(1).^2) + b.*y(1) - ((y(1).*y(2))./(1 + y(1)));...
        (-c) .*y(2) + ((y(1).*y(2))./(1 + y(1))) ];
end