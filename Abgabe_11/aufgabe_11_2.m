function aufgabe_11_2()
    max_n = 80;
    max_n_a = 20;
    min_n= 5;
    error = ones(max_n - min_n + 1, 1);
    vector = min_n:1:max_n;
    lr_time = zeros(max_n - min_n + 1, 1);
    fw_time = zeros(max_n - min_n + 1, 1);
    bw_time = zeros(max_n - min_n + 1, 1);

    for i=min_n:1:max_n
        A = testmatrix(i);
        b = ones(i,1);
        tic
        [L,R] = LR_Decomposition(A);
        lr_time(i-min_n+1) = toc;
        tic
        y = forwards(L,b);
        fw_time(i-min_n+1) = toc;
        tic
        x = backwards(R,y);
        bw_time(i-min_n+1) = toc;
        error(i-min_n+1) = norm(L*R*x-b, Inf);
    end
    fig = figure('Name', 'Abgabe 11-2-a', 'NumberTitle', 'off');
    semilogy(vector(1:max_n_a-min_n+1), error(1:max_n_a-min_n+1), '-*');
    axis padded
    hold on
    title('Aufgabe 11-2-a');
    xlabel('n');
    ylabel('|| LRx - b ||_{\infty}');
    legend('|| LRx - b ||_{\infty}', 'Location','northwest');
    grid on;
    exportgraphics(fig, 'aufgabe_11_2_a.pdf')


    fig2 = figure('Name', 'Abgabe 11-2-b', 'NumberTitle', 'off');
    semilogy(vector, lr_time .* 1000, '-', vector, fw_time .* 1000, '--', vector, bw_time .* 1000, '.-', vector, vector.^2, ':', vector, vector.^3, '-');
    axis padded
    hold on
    title('Aufgabe 11-2-a');
    xlabel('n');
    ylabel('time [milisec]');
    legend('LR Decomposition', 'Forwards', 'Backwards', 'O(n^2)', 'O(n^3)', 'Location','east');
    grid on;
    exportgraphics(fig2, 'aufgabe_11_2_b.pdf')
end

%Berechnet die Matrix von Blatt 9 fuer gegebenes n. Hier ist nichts zu tun.
function matrix = testmatrix(n)
  for i=0:n-1
    for j=0:n-1
      if(mod((i+j),2)== 0)
        matrix(i+1,j+1)=2/(i+j+1);
      else
        matrix(i+1,j+1)=0;
      end
    end
  end
end


function [L,R] = LR_Decomposition(A)
  n = length(A);
  L = eye(n,n);
  for j = 1:n
    for k=j:1:n
        sum1 = 0;
      for i=1:1:j-1
        sum1 = sum1 + L(j,i)*R(i,k);
      end
      R(j,k) = A(j,k) - sum1;
    end
    for k=j+1:1:n
      sum2 = 0;
      for i=1:1:j-1
        sum2 = sum2 + L(k,i)*R(i,j);
      end
      L(k,j) = 1/R(j,j) * (A(k,j) - sum2);
    end
  end
end

function y = forwards(L,b)
  n=length(L);
  y=zeros(n,1);
  for i = 1:n
      y(i) = 1/L(i,i) * (b(i) - sum( sum( L(i, 1:i-1) .* y(1:i-1) ) ));
  end
end

function x = backwards(R,y)
  n=length(R);
  x=zeros(n,1);
  for i = n-1:-1:1
      x(i) = 1/R(i,i) * (y(i) - sum ( sum( R(i,i+1:n) .* x(i+1:n) ) ));
  end
end
