% Función para crear un sistema diagonal dominante de tamaño n
function [A, b] = crear_sistema_diagonal_dominante(n)
    A = rand(n, n);
    % Hacer que A sea diagonalmente dominante
    for i = 1:n
        A(i,i) = sum(abs(A(i,:))) + rand();  % Asegura dominancia diagonal
    end

    % Vector de términos independientes
    b = rand(n, 1) * 10;
end
