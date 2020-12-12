figure;
hold on, grid on

plot(T, Y(:, 1));
plot(T, Y(:, 2));
xlabel("$$z$$", "Interpreter", "latex")
legend("$$u$$", "$$v$$", "Interpreter", "latex")
axis([10, 50, -0.1, 1.6])
%%
figure;
hold on, grid on;

xs = 0:0.01:100;
t = 1;
us = zeros(1, numel(xs));

for i = 1:numel(xs)
   [~, idx] = min(abs(T.' - xs(i) - m*t));
   us(i) = Y(idx, 2);
end

plot(xs, us);

%%
figure;
[xs, ts] = meshgrid(0:0.01:3, 0:0.01:10);

numel(xs(1,:))
numel(xs(:, 1))

us = zeros(numel(xs(:, 1)), numel(xs(1,:)));
for i = 1:numel(xs(:, 1))
    for j = 1:numel(xs(1,:))
        %min(abs(T.' - xs(i) - m*ts(j)))
        %xs(i)
        if xs(i,j) > 1/(1-c)
            [~, idx] = min(abs(T.' - xs(i, j) - m*ts(i, j)));
        else
            [~, idx] = min(abs(T.' -( xs(i, j) + 2*(1/(1-c) - xs(i, j)) + m*ts(i, j))));
        end
        
        us(i, j) = Y(idx, 2);
    end
end


numel(xs)
numel(us)
surf(xs, ts, us);
hold on, grid on;
xlabel("$$x$$", 'Interpreter', 'latex')
ylabel("$$t$$", 'Interpreter', 'latex')
zlabel("$$u$$", 'Interpreter', 'latex')
axis([0, 3, 0, 10, 0, 3])