function analizar_condiciones_iniciales()
    fprintf('\n========= ANÁLISIS DE DEPENDENCIA DE CONDICIONES INICIALES =========\n');
    n = 50;
    [A, b] = crear_sistema_diagonal_dominante(n);

    % Solución exacta
    x_exacta = A \ b;

    tol = 1e-6;
    max_iter = 1000;

    % Diferentes vectores iniciales
    x0_ceros = zeros(n, 1);
    x0_unos = ones(n, 1);
    x0_rand = rand(n, 1) * 10;

    fprintf('\nCondición inicial: Vector de ceros\n');
    [x_jac1, iter_jac1, err_hist_jac1, tiempo_jac1] = jacobi(A, b, x0_ceros, tol, max_iter);
    err_jac1 = error_relativo(x_jac1, x_exacta);

    fprintf('\nCondición inicial: Vector de unos\n');
    [x_jac2, iter_jac2, err_hist_jac2, tiempo_jac2] = jacobi(A, b, x0_unos, tol, max_iter);
    err_jac2 = error_relativo(x_jac2, x_exacta);

    fprintf('\nCondición inicial: Vector aleatorio\n');
    [x_jac3, iter_jac3, err_hist_jac3, tiempo_jac3] = jacobi(A, b, x0_rand, tol, max_iter);
    err_jac3 = error_relativo(x_jac3, x_exacta);

    % Mostrar resultados
    fprintf('\nResultados con diferentes condiciones iniciales:\n');
    fprintf('Jacobi (ceros): %d iteraciones, tiempo: %.6f segundos, error: %.10e\n', iter_jac1, tiempo_jac1, err_jac1);
    fprintf('Jacobi (unos): %d iteraciones, tiempo: %.6f segundos, error: %.10e\n', iter_jac2, tiempo_jac2, err_jac2);
    fprintf('Jacobi (aleatorio): %d iteraciones, tiempo: %.6f segundos, error: %.10e\n', iter_jac3, tiempo_jac3, err_jac3);

    % Graficar convergencia con diferentes condiciones iniciales
    figure;
    semilogy(1:length(err_hist_jac1), err_hist_jac1, 'b-', 'LineWidth', 2);
    hold on;
    semilogy(1:length(err_hist_jac2), err_hist_jac2, 'r--', 'LineWidth', 2);
    semilogy(1:length(err_hist_jac3), err_hist_jac3, 'g-.', 'LineWidth', 2);
    grid on;
    title('Convergencia de Jacobi con diferentes condiciones iniciales');
    legend('Ceros', 'Unos', 'Aleatorio');

    % Guardar datos para análisis comparativo
    save('resultados_condiciones_iniciales.mat', 'A', 'b', 'x_exacta', ...
        'x_jac1', 'iter_jac1', 'tiempo_jac1', 'err_jac1', 'err_hist_jac1', ...
        'x_jac2', 'iter_jac2', 'tiempo_jac2', 'err_jac2', 'err_hist_jac2', ...
        'x_jac3', 'iter_jac3', 'tiempo_jac3', 'err_jac3', 'err_hist_jac3');
end
