function aufgabe_12_1 ()
    A = [40 10 20; 10 30 10; 20 10 40];
    L = [6.325 0 0; 1.581 5.244 0; 3.162 0.954 5.394];
    L_T = L';

    error = norm(L*L_T - A, "inf") / norm(A, "inf");
    
    fileID = fopen("aufgabe_12_1.txt", "w");
    String = sprintf("||LL^T - ||_\x221E / ||A||_\x221E \x2248  %1$.32g \n \x2248 %1$.4g", error)
    fprintf(fileID, String);
    fclose(fileID);
end