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
