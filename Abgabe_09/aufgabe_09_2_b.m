function aufgabe_09_2_b
    % Initialize matrix A
    A = zeros(10, 10);

    % Fill matrix A with values aik
    for i = 0:9
        for k = 0:9
            if mod(i+k, 2) == 0
                A(i+1,k+1) = 2/(i+k+1);
            end
        end
    end

    % Calculate cond_infty(A)
    for n = 1:10
    cond_inf(n) = cond(A(1:n,1:n), inf);
    end

    % Display values of cond_infty(A)
    sprintf('%f ', cond_inf)

    % Plot values of cond_infty(A)
    fig = figure('Name', 'Abgabe 09-2-b', 'NumberTitle', 'off');
    semilogy(cond_inf, '*')
    xlabel('n')
    ylabel('cond_{\infty}(A_n)')
    legend('cond_{\infty}(A)', 'Location','northwest')

    title('Aufgabe 09-2-b')
    subtitle('Condition Number of Matrix A for Different Values of n')
    grid on
    axis padded
    exportgraphics(fig, 'aufgabe_09_2_b.pdf') %Export fig as pdf
end