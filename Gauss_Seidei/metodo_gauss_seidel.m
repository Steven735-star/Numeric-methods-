
% Implementación del método de Gauss-Seidel
function [x, errores] = metodo_gauss_seidel(A, b, x0, tol, max_iter)
    n = length(b);
    x = x0;
    errores = [];
    err = tol + 1;
    iter = 0;

    % Descomponemos A = D + L + U
    D = diag(diag(A));
    L = tril(A, -1);
    U = triu(A, 1);

    % Verificar si los elementos diagonales son no nulos
    if any(diag(A) == 0)
        error('La matriz tiene elementos diagonales nulos, método no aplicable');
    end

    % Iteraciones de Gauss-Seidel
    while err > tol && iter < max_iter
        x_old = x;

        % Método de Gauss-Seidel: (D+L)x^(k+1) = b - Ux^(k)
        x = (D + L) \ (b - U * x_old);

        % Error relativo entre iteraciones
        err = norm(x - x_old) / norm(x);
        errores = [errores; err];
        iter = iter + 1;
    end

    if iter == max_iter && err > tol
        fprintf('Gauss-Seidel no convergió después de %d iteraciones. Error: %.10e\n', max_iter, err);
    else
        fprintf('Gauss-Seidel convergió en %d iteraciones\n', iter);
    end
end
