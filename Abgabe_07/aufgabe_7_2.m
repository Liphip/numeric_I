function aufgabe_7_2
    syms   a10      a11      a12      a13      a20      a21      a22      a23 % Vars for lin sys of eq
    eqn1 = a10                                                                == 1; % Equation 1 for the system
    eqn2 = a10 +    a11 +    a12 +    a13                                     == 0; % Eq2
    eqn3 =          a11 +  2*a12 +  3*a13          -    a21 -  2*a22 -  3*a23 == 0; % Eq3
    eqn4 =                 2*a12 +  6*a13                   -  2*a22 -  6*a23 == 0; % Eq4
    eqn5 =                                     a20 +    a21 +    a22 +    a23 == 0; % Eq5
    eqn6 =                                     a20 +  2*a21 +  4*a22 +  8*a23 == 2; % Eq6
    eqn7 =                 2*a12                                              == 0; % Eq7
    eqn8 =                                                     2*a22 + 12*a23 == 0; % Eq8

    [A, b] = equationsToMatrix([eqn1, eqn2, eqn3, eqn4, eqn5, eqn6, eqn7, eqn8],[a10, a11, a12, a13, a20, a21, a22, a23]); % Create a matirx and a vector from the system
    X = linsolve(A, b); % Solve the linear system of equations from the matrix and vector with result as a vector
    fprintf('Calculated solution for linear system of equations in vector form: \n')
    disp(X) % Display solution Vector

    % FIXME MATLAB solving derivatives incorrect
    sp1 = @(x) X(1) + X(2)*x + X(3)*x.^2 + X(4)*x^3; % Create function s_{2,1} 
    sp11 = @(x) X(2) + 2*X(3)*x + 3*X(4)*x^2; % Create function s_{2,1}' by hand
    sp12 = @(x) 2*X(3) + 2*3*X(4)*x; % Create function s_{2,1}'' by hand

    sp2 = @(x) X(5) + X(6)*x + X(7)*x.^2 + X(8)*x^3; % Create function s_{2,1}
    sp21 = @(x) X(6) + 2*X(7)*x + 3*X(8)*x^2; % Create function s_{2,2}' by hand
    sp22 = @(x) 2*X(7) + 2*3*X(8)*x; % Create function s_{2,2}'' by hand

    s = @(x) ((0 <= x) & (x < 1)).*(sp1(x)) + ((1 <= x) & (x <= 2)).*(sp2(x)); % Create s(x) with cases from s_{2,1} and s_{2,2}
    s1 = @(x) ((0 <= x) & (x < 1)).*(sp11(x)) + ((1 <= x) & (x <= 2)).*(sp21(x)); % Create s'(x) with cases from s_{2,1}' and s_{2,2}'
    s2 = @(x) ((0 <= x) & (x < 1)).*(sp12(x)) + ((1 <= x) & (x <= 2)).*(sp22(x)); % Create s''(x) with cases from s_{2,1}'' and s_{2,2}''
    
    fig = figure('Name', 'Abgabe 7-2', 'NumberTitle', 'off'); %Create fig with Name and no numbered Title for exporting
    hold on % Keep all plots
    xlim([-0.25, 2.25]); % Set x limits to fit all error values
    ylim([-2.25, 5.25]); % Set y limits to fit the error values

    plot([0, 1, 2],[1, 0, 2], '*k'); % Plot node
    fplot(s, '-r'); % Plot s(x)
    fplot(s1, '--b'); % Plot s'(x)
    fplot(s2, '-.g'); % Plot s''(x)


    title('Aufgabe 7-2'); %Add title for fig
    xlabel('x'); %Add label to x axis
    ylabel('f(x)'); %Add label to x axis
    legend('Nodes', 's(x)', 's`(x)', 's``(x)'); %Add legend for each plot
    grid on; %Enable Grid for plot
    exportgraphics(fig, 'aufgabe_7_2.pdf') %Export fig as pdf
end