function aufgabe3_2 ()
  x = [-10,-1,1,10]; %Array for x values to be tested
  datapoint_count = 60; %Var for datapoint count for better consistency
  n = 1:datapoint_count; %n Values to be tested
  
  relativer_fehler = zeros(length(x), datapoint_count); %create emtpy matrix for relative errors
  relativer_fehler_variante2 = zeros(length(x), datapoint_count); %create emtpy matrix for alternative relative errors
  for k=1:length(x) %iterate x values
    for i=1:datapoint_count %generate datapoints for n values
     relativer_fehler(k, i) = abs(taylorsumme(x(k), i) - exp(x(k)))/exp(x(k)); %generate ralative error with default taylor sum
     relativer_fehler_variante2(k, i) = abs(taylorsumme_variante2(x(k), i) - exp(x(k)))/exp(x(k)); %generate relative error for inverse negative taylor sum
     end
  end
  
  %Plot relative erros for normal taylor sum
  fig1 = figure('Name', 'Aufgabe_3_2_a', 'NumberTitle', 'off'); %Create fig with Name and no numbered Title for exporting
  %semilogy(n, relativer_fehler, ['-'; '--'; ':'; '-.']) %Create plots for different relative errors
  semilogy(n, relativer_fehler(1,:), '-m', n, relativer_fehler(2,:), '--b', n, relativer_fehler(3,:), ':r', n, relativer_fehler(4,:), '-.g'); %Bodge for error above
  title('Taylorsumme'); %Add title for fig
  subtitle('T_n(x)'); %Add subtitle for fig
  xlabel('n'); %Add label to x axis
  ylabel('relativer Fehler'); %Add label to y axis
  legend('x = -10','x = -1', 'x = 1', 'x = 10', 'Location', 'northeast'); %Add legend for each plot
  grid on; %Enable Grid for plot
  hold on %Keep Plot
  exportgraphics(fig1, 'aufgabe_3_2_a.pdf') %Export fig as pdf


  %Plot relative erros for inverse negative taylor sum
  fig2 = figure('Name', 'Aufgabe_3_2_b', 'NumberTitle', 'off'); %Create fig with Name and no numbered Title for exporting
  %semilogy(n, relativer_fehler_variante2, ['-'; '--'; ':'; '-.']) %create plots for different errors
  semilogy(n, relativer_fehler_variante2(1,:), '-m', n, relativer_fehler_variante2(2,:), '--b', n, relativer_fehler_variante2(3,:), ':r', n, relativer_fehler_variante2(4,:), '-.g'); %Bodge for error above
  title('Taylorsumme negative x'); %Add title for fig
  subtitle('1/T_n(-x)'); %Add subtitle for fig
  xlabel('n'); %Add label to x axis
  ylabel('relativer Fehler'); %Add label to y axis
  legend('x = -10','x = -1', 'x = 1', 'x = 10', 'Location', 'northeast'); %Add legend for each plot
  grid on; %Enable Grid for plot
  hold on %Keep Plot
  exportgraphics(fig2, 'aufgabe_3_2_b.pdf') %Export fig as pdf
end

function erg = taylorsumme(x,n)
  erg = 0; %set return value for sum to 0
  for j = 0 : n %generate sum over j from 0 to n
    erg = erg + (x^j / factorial(j)); %calculate sum step
  end
end


function erg = taylorsumme_variante2(x, n)
  erg = 1 / taylorsumme(-x, n); %claculate inverse negative taylor sum
end
