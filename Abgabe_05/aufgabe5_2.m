function aufgabe5_2 ()
    [interpolation, schema] = neville(61.7, [55.7 1048; 57.7 1080; 59.3 1111; 62.6 1196; 65.6 1354]);
    fprintf('Tageslänge in Minuten am Ort F bei 61.7°: %g\n Berechnet mit Neville-Schema: \n', interpolation)
    disp(schema)
end

function [interpolation, schema] = neville (x, bases) 
    %   NEVILLE  Function for claculating interpolation at given point using
    %   Neville-Schema.
    %
    %   [INTERPOLATION, SCHEMA] = NEVILLE(X, BASES) Calculate interpolation
    %   at X using given BASES.
    %
    %   X The x value for the interpolation to be claculated at.
    %
    %   BASES The Bases of the interpolation given as a Nx2 Matrix where
    %   the first column contains the x values and the second column
    %   contains the function values at the given x values.

    n = length(bases); % Get lentgh of columns in bases matrix
    schema = zeros(n,n); % Create NxN matrix for the calculated polynomes
    
    for i = 1:n % Fill schema matrix at first point with inital function values from bases matrix
        schema(i,1) = bases(i, 2);
    end
 
    d = zeros(1,n); 
    d(1) = x-bases(1, 1);
    
    for i = 1:n-1
        
        d(i+1) = x-bases(i+1, 1);
        for j = 1:i
            schema(i+1,j+1) = (d(i+1)*schema(i,j)-d(i-j+1)*schema(i+1,j))/(d(i+1)-d(i-j+1));
        end
    end

    interpolation = schema(n,n);
end