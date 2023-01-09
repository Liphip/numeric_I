function aufgabe_09_2_a
    % Set values of x for which to compute polynomials
    x = linspace(-1, 1, 100);

    % Initialize vector to hold Legendre polynomials
    L = zeros(11, length(x));

    % Set p0(x) = 1
    L(1,:) = 1;

    % Set p1(x) = x
    L(2,:) = x;

    % Compute Legendre polynomials with two-step recursion formula
    for k = 2:10
    % Recursively compute next polynomial in sequence
    L(k+1,:) = x .* L(k,:) - (k^2 / (4*k^2 - 1)) * L(k-1,:);
    end

    % Multiply polynomials by their coefficients
    L = (factorial(2*(0:10)') ./ (2.^(0:10)' .* (factorial(0:10)').^2)) .* L;

    % Create new figure
    fig = figure('Name', 'Abgabe 09-2-a', 'NumberTitle', 'off');

    % Plot Legendre polynomials
    plot(x, L)
    xlabel('x')
    ylabel('L_k(x)')
    legend('L_0(x)', 'L_1(x)', 'L_2(x)', 'L_3(x)', 'L_4(x)', 'L_5(x)', 'L_6(x)', 'L_7(x)', 'L_8(x)', 'L_9(x)', 'L_{10}(x)', 'Location', 'southeast', 'Orientation','horizontal', 'NumColumns', 4)

    title('Aufgabe 09-2-a');
    subtitle('Legendre Polynomials L_k(x)')
    grid on
    axis padded
    exportgraphics(fig, 'aufgabe_09_2_a.pdf') %Export fig as pdf
end