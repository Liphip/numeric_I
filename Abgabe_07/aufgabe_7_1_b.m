function aufgabe_7_1_b
    MAX_N = 1500; % Value for n up to which to claculate the approximations of error
    GOAL_VALUE = 10^-12; % Limit for approximations of error

    f = @(x) sin(2*pi*x); % Function for which the apporx is claculated

    n_values = 1 : MAX_N; % Specific values for n for which to clac the approx
    diffs = zeros(1 ,MAX_N); % Array for storing the errors

    parfor n = n_values % Calc for every n in parallel pool
        x_values = linspace(0, 1, n + 1); % N evenly distributed values in 0:1
        pp = csape(x_values, f(x_values), 'variational'); % Calc natural cubic spline coefficients for f

        difff = @(x) abs( f(x) - ppval(pp, x) ); % Function for calculating the error usng ppval

        diffs(n) = max(difff(0 : 10^-6 : 1)); % Calculate max error with 1M points and insert max error into array
    end

    fig = figure('Name', 'Abgabe 7-1-b', 'NumberTitle', 'off'); %Create fig with Name and no numbered Title for exporting
    xlim([0, MAX_N]); % Set x limits to fit all error values
    ylim([min(diffs), max(diffs)]); % Set y limits to fit the error values
    set(gca, 'YScale', 'log') % Set scaling of y axis to log for better readability
    axis padded % Add padding to axis
    hold on % Keep all plots

    g_goal = diffs; % Get errors above the limit
    g_goal(diffs <= GOAL_VALUE) = NaN; % Set all values leq limit NaN to prevent plotting

    leq_goal = diffs; % Get errors below or on limit
    leq_goal(diffs > GOAL_VALUE) = NaN; % Set all values greater limit NaN to prevent plotting

    loglog(n_values, g_goal, '*r'); % Plot bad values red
    loglog(n_values, leq_goal, '*g'); % Plot good values green
    loglog(n_values, diffs, ':k'); % Plot graph throug errors black

    frist_exceptable_n = find(diffs == max(leq_goal)) - 1; % Calculate first n with an error below limit

    title('Aufgabe 7-1-b'); %Add title for fig
    subtitle(['Minimal n with max_{0\leqx\leq1}(|f(x) - s(x)|) \leq 10^{-12}: ' int2str(frist_exceptable_n)]) % Add Subtitle with calculated minimal n
    xlabel('n'); %Add label to x axis
    ylabel('max_{0\leqx\leq1}(|f(x) - s(x)|)'); %Add label to x axis
    legend('max_{0\leqx\leq1}(|f(x) - s(x)|) > 10^{-12}','max_{0\leqx\leq1}(|f(x) - s(x)|) \leq 10^{-12}'); %Add legend for each plot
    grid on; %Enable Grid for plot
    exportgraphics(fig, 'aufgabe_7_1_b.pdf') %Export fig as pdf
end
