function aufgabe2_2
  h = [2^-2 2^-3 2^-4 2^-5 2^-6]; %Vector with h Values
  a = [7.095485351135761 7.047858597600531 7.023726226390662 7.011579000356371 7.005485409034109]; %Vector with a(h) values
  b = [8.971800326329658 8.992881146463981 8.998220339291473 8.999559782988968 8.999895247704067]; %Vector with ab(h) values

  fig = figure('Name', 'Abgabe 2-2', 'NumberTitle', 'off'); %Create fig with Name and no numbered Title for exporting
  loglog(h, abs(a-7), '-+', h, abs(b-9), '--*', h, h, ':.', h, h.^2, '-.x'); %Create multiple logarithmic plots with h in x axis and different line types
  xlimit = xlim(); %Get x limits of fig for scaling
  xlim([xlimit(1) xlimit(2)/2.5]); %Scale x limit for better readability
  ylimit = ylim(); %Same as before
  ylim([ylimit(1)/1.5 ylimit(2)]); %ame as before
  title('Aufgabe 2-2'); %Add title for fig
  xlabel('h'); %Add label to x axis
  legend('|a(h)-7|','|b(h)-9|', 'O(h)', 'O(h^2)', 'Location', 'northwest'); %Add legend for each plot
  grid on; %Enable Grid for plot
  hold on %Keep Plot
  exportgraphics(fig, 'aufgabe_2_2.pdf') %Export fig as pdf
end
