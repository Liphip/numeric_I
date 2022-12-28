function aufgabe8_2
    XK = @(k, n) k * ((2*pi)  / (n + 1));
    YK = @(x_k) sin(x_k) * cos (x_k);
    YK2 = @(x_k) ((0 <= x_k) & (x_k < pi)).*(-1) + ((pi <= x_k) & (x_k < 2*pi)).*(1);


    f1 = @(x) sin(x) * cos(x);
    f2 = @(x) ((0 <= x) & (x < pi)).*(-1) + ((pi <= x) & (x < 2*pi)).*(1);
    
    fig1 = figure('Name', 'Aufgabe_8_2_a', 'NumberTitle', 'off'); %Create fig with Name and no numbered Title for exporting
    hold on %Keep Plot
    fplot(f1, [0 4*pi], '-k');
    fplot(eval_trig_poly(2, XK, YK), [0 4*pi], '--b');
    fplot(eval_trig_poly(4, XK, YK), [0 4*pi], ':r');
    fplot(eval_trig_poly(8, XK, YK), [0 4*pi], '-.g');
    title('Aufgabe 8-2'); %Add title for fig
    xlabel('x'); %Add label to x axis
    ylabel('f(x)'); %Add label to y axis
    legend('f', 'n = 2', 'n = 4', 'n = 8'); %Add legend for each plot
    grid on; %Enable Grid for plot
    exportgraphics(fig1, 'aufgabe_8_2_a.pdf') %Export fig as pdf


    fig2 = figure('Name', 'Aufgabe_8_2_b', 'NumberTitle', 'off'); %Create fig with Name and no numbered Title for exporting
    hold on %Keep Plot
    fplot(f2, [0 2*pi], '-k');
    fplot(eval_trig_poly(128, XK, YK), [0 2*pi], '--b');
    fplot(eval_trig_poly(128, XK, YK2), [0 2*pi], ':r');
    title('Aufgabe 8-2 Bonus'); %Add title for fig
    xlabel('x'); %Add label to x axis
    ylabel('f(x)'); %Add label to y axis
    legend('f', 'n = 128', 'n = 128 with adjusted y_k'); %Add legend for each plot
    grid on; %Enable Grid for plot
    exportgraphics(fig2, 'aufgabe_8_2_b.pdf') %Export fig as pdf
end

function [t] = eval_trig_poly (n, x_k, y_k)
    x_n = calc_x_n(n, x_k);
    y_n = calc_y_n(x_n, y_k);
    a_n = calc_a_n(n, x_n, y_n);
    b_n = calc_b_n(n, x_n, y_n);
    t = calc_tirg_poly(n, a_n, b_n);
end

function [t] = calc_tirg_poly (n, a_n, b_n)
    if (~mod(n,2)) 
        m = 1/2 * n;
        d = 0;
    else
        m = 1/2 * (n-1);
        d = 1;
    end
    
    t = @(x) (1/2 * a_n (1)) + csum(@(k) (a_n( k+1 ) * cos(k * x)) + (b_n( k+1 ) * sin(k * x)), 1, m) + (d/2 * a_n(m+1) * cos((m+1) * x));
end


function [x_n] = calc_x_n (n, x_k)
    x_n = x_k(0 : n, n);
end

function [y_n] = calc_y_n (x_n, y_k)
    y_n = arrayfun(y_k, x_n);
end

function [a_n] = calc_a_n (n, x_n, y_n)
    func = @(k) 2/(n+1) * csum(@(j) y_n( j+1 ) * cos(j * x_n( k+1 )), 0, n);
    a_n = arrayfun(func, 0:n);
end

function [b_n] = calc_b_n (n, x_n, y_n)
    func = @(k) 2/(n+1) * csum(@(j) y_n( j+1 ) * sin(j * x_n( k+1 )), 0, n);
    b_n = arrayfun(func, 0:n);
end

function [sumv] = csum (func, from, to)
    sumv = 0;
    for i = from : to
        sumv = sumv + func(i);
    end
end