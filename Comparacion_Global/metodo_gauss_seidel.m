function [x, errores] = metodo_gauss_seidel(A, b, x0, tol, max_iter)
    n = length(b);
    x = x0;
    errores = [];
    for k = 1:max_iter
        x_old = x;
        for i = 1:n
            x(i) = (b(i) - A(i,1:i-1)*x(1:i-1) - A(i,i+1:end)*x_old(i+1:end)) / A(i,i);
        end
        err = norm(x - x_old)/norm(x);
        errores(end+1) = err;
        if err < tol
            break;
        end
    end
end

