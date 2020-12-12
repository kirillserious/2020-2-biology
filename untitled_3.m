figure;


[us, vs] = meshgrid(-5:0.1:5, -5:0.1:5);
ws = -a./m.*us.*us + b./m.*us - (us.*vs)./(m.*(1 + us));
surf(us, vs, ws);
hold on, grid on;
xlabel("$$u$$", 'Interpreter', 'latex')
ylabel("$$v$$", 'Interpreter', 'latex')
zlabel("$$w$$", 'Interpreter', 'latex')
axis([0, 3, 0, 3, -3, 3])
ws = ws .* 0;
surf(us, vs, ws);
ws = meshgrid(-5:0.1:5);
us = us .* 0 + 1./(1-c);
surf(us,vs,ws)