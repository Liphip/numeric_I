function aufgabe5_1_b ()
    MAX_N = 10; % Value for n up to which to claculate the approximations of error
    GOAL_VALUE = 10^-9; % Limit for approximations of error
    
    f = @(x) exp(x); % Function for which the apporx is claculated
     
    n_values = 0 : MAX_N; % Specific values for n for which to clac the approx
    diffs = zeros(1 ,MAX_N); % Array for storing the errors

    for n = n_values % Calc for every n
        x_values = linspace(0, 1, n + 1); % N evenly distributed values in 0:1
        p_pols = polyfit(x_values, f(x_values), n); % Calc N polynomial coefficients for f
        
        difff = @(x) abs( f(x) - polyval(p_pols, x) ); % Function for calculating the error usng polyval

        diffs(n + 1) = max(difff(0 : 10^-6 : 1)); % Insert error into error array
    end

    fig = figure('Name', 'Abgabe 5-1-b', 'NumberTitle', 'off'); %Create fig with Name and no numbered Title for exporting
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

    title('Aufgabe 5-1-b'); %Add title for fig
    subtitle(['Minimal n with max_{x\in(0,1)}(|f(x) - p_n(x)|) > 10^{-9}: ' int2str(frist_exceptable_n)]) % Add Subtitle with calculated minimal n
    xlabel('n'); %Add label to x axis
    ylabel('max_{x\in(0,1)}(|f(x) - p_n(x)|)'); %Add label to x axis
    legend('max_{x\in(0,1)}(|f(x) - p_n(x)|) > 10^{-9}','max_{x\in(0,1)}(|f(x) - p_n(x)|) \leq 10^{-9}'); %Add legend for each plot
    grid on; %Enable Grid for plot
    exportgraphics(fig, 'aufgabe_5_1_b.pdf') %Export fig as pdf
end