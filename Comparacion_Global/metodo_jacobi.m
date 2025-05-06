function [x, errores] = metodo_jacobi(A, b, x0, tol, max_iter)
    D = diag(diag(A));
    R = A - D;
    x = x0;
    errores = [];
    for k = 1:max_iter
        x_new = D \ (b - R*x);
        err = norm(x_new - x)/norm(x_new);
        errores(end+1) = err;
        if err < tol
            break;
        end
        x = x_new;
    end
end

