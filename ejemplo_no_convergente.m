function ejemplo_no_convergente()
    fprintf('\n========= EJEMPLO: SISTEMA DONDE JACOBI NO CONVERGE =========\n');
    n = 50;

    % Matriz con valores diagonales muy pequeños
    A = rand(n, n) * 10;
    for i = 1:n
        A(i,i) = sum(abs(A(i,:))) / (n * 10);  % Diagonal muy pequeña
    end

    % Vector de términos independientes
    b = rand(n, 1) * 10;

    fprintf('Sistema de tamaño %dx%d con valores diagonales pequeños\n', n, n);
    fprintf('¿Es diagonalmente dominante? %d\n', es_diagonal_dominante(A));

    x0 = zeros(n, 1);  % Vector inicial
    tol = 1e-6;        % Tolerancia
    max_iter = 200;    % Máximo de iteraciones reducido

    % Solución exacta
    x_exacta = A \ b;

    % Método de Jacobi
    [x_jac, iter_jac, err_hist_jac, tiempo_jac] = jacobi(A, b, x0, tol, max_iter);
    err_jac = error_relativo(x_jac, x_exacta);

    % Mostrar resultados
    fprintf('\nResultados Jacobi:\n');
    fprintf('Iteraciones: %d\n', iter_jac);
    fprintf('Tiempo: %.6f segundos\n', tiempo_jac);
    fprintf('Error relativo: %.10e\n', err_jac);

    % Graficar convergencia
    figure;
    semilogy(1:length(err_hist_jac), err_hist_jac, 'b-', 'LineWidth', 2);
    grid on;
    xlabel('Iteración');
    ylabel('Error relativo (escala log)');
    title('Convergencia del Método de Jacobi (Sistema No Convergente)');

    % Guardar datos para análisis comparativo
    save('resultados_no_convergente.mat', 'A', 'b', 'x_exacta', 'x_jac', 'iter_jac', 'tiempo_jac', 'err_jac', 'err_hist_jac');
end
