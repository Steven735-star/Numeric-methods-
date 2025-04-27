% Función para verificar si una matriz es diagonalmente dominante
function es_dom = es_diagonal_dominante(A)
    n = size(A, 1);
    es_dom = true;

    for i = 1:n
        if abs(A(i,i)) <= sum(abs(A(i,:))) - abs(A(i,i))
            es_dom = false;
            break;
        end
    end
end

% Función para evaluar el error relativo con respecto a la solución exacta
function err = error_relativo(x_aprox, x_exacta)
    err = norm(x_aprox - x_exacta) / norm(x_exacta);
end

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
