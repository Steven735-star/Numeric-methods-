function [x, iter, err_hist, tiempo] = jacobi(A, b, x0, tol, max_iter)
    tic;  % Iniciar cronómetro
    n = length(b);
    x = x0;
    iter = 0;
    err = tol + 1;
    err_hist = [];

    % Descomponemos A = D + L + U
    D = diag(diag(A));
    L = tril(A, -1);
    U = triu(A, 1);

    % Verificamos si la matriz D es invertible
    if any(diag(A) == 0)
        error("La matriz tiene elementos diagonales nulos, método no aplicable");
    end

    % Método de Jacobi: x^(k+1) = D^(-1) * (b - (L+U) * x^(k))
    while err > tol && iter < max_iter
        x_old = x;
        x = D \ (b - (L + U) * x_old);

        % Calculamos el error relativo
        err = norm(x - x_old) / norm(x);
        err_hist = [err_hist; err];
        iter = iter + 1;
    end

    tiempo = toc;  % Detener cronómetro

    % Verificar convergencia
    if iter == max_iter && err > tol
        warning('El método de Jacobi no convergió después de %d iteraciones', max_iter);
    end
end
