function parametros_comparacion()
    fprintf('\n========= PARÁMETROS DE COMPARACIÓN PARA MÉTODO DE JACOBI =========\n');

    % Crear sistemas de diferentes tamaños
    tamanos = [50, 100, 200, 500];

    % Inicializar arrays para almacenar resultados
    tiempos = zeros(length(tamanos), 1);
    iteraciones = zeros(length(tamanos), 1);
    errores = zeros(length(tamanos), 1);
    memorias = zeros(length(tamanos), 1);

    fprintf('Parámetros para diferentes tamaños de sistemas:\n');
    fprintf('----------------------------------------------\n');
    fprintf('Tamaño | Tiempo (s) | Iteraciones | Error       | Memoria (KB)\n');
    fprintf('--------------------------------------------------------\n');

    for i = 1:length(tamanos)
        n = tamanos(i);
        [A, b] = crear_sistema_diagonal_dominante(n);
        x0 = zeros(n, 1);
        tol = 1e-6;
        max_iter = 1000;

        % Solución exacta
        x_exacta = A \ b;

        % Jacobi
        memory_start = memory();
        [x_jac, iter_jac, err_hist_jac, tiempo_jac] = jacobi(A, b, x0, tol, max_iter);
        memory_end = memory();
        mem_jac = (memory_end.MemUsedMATLAB - memory_start.MemUsedMATLAB) / 1024;  % en KB
        err_jac = error_relativo(x_jac, x_exacta);

        % Guardar resultados
        tiempos(i) = tiempo_jac;
        iteraciones(i) = iter_jac;
        errores(i) = err_jac;
        memorias(i) = mem_jac;

        fprintf('%4d  | %9.6f | %11d | %9.2e | %11.2f\n', ...
                n, tiempo_jac, iter_jac, err_jac, mem_jac);
    end

    % Prueba de robustez con perturbaciones
    fprintf('\nPrueba de robustez con perturbaciones en la matriz:\n');

    n = 100;
    [A, b] = crear_sistema_diagonal_dominante(n);
    x0 = zeros(n, 1);
    tol = 1e-6;
    max_iter = 1000;

    % Perturbar la matriz
    perturbaciones = [0.01, 0.05, 0.1, 0.2];

    % Inicializar arrays para resultados de perturbaciones
    iter_perturb = zeros(length(perturbaciones), 1);
    tiempo_perturb = zeros(length(perturbaciones), 1);
    error_perturb = zeros(length(perturbaciones), 1);
    convergencia = zeros(length(perturbaciones), 1);  % 1=converge, 0=no converge

    for i = 1:length(perturbaciones)
        p = perturbaciones(i);
        fprintf('\nPerturbación: %.2f\n', p);

        % Crear perturbación
        delta_A = p * randn(size(A));
        A_pert = A + delta_A;

        % Solución exacta del sistema perturbado
        x_exacta_pert = A_pert \ b;

        % Métodos iterativos
        try
            [x_jac, iter_jac, ~, tiempo_jac] = jacobi(A_pert, b, x0, tol, max_iter);
            err_jac = error_relativo(x_jac, x_exacta_pert);
            fprintf('Jacobi: %d iteraciones, tiempo: %.6f segundos, error: %.10e\n', ...
                    iter_jac, tiempo_jac, err_jac);

            % Guardar resultados
            iter_perturb(i) = iter_jac;
            tiempo_perturb(i) = tiempo_jac;
            error_perturb(i) = err_jac;
            convergencia(i) = 1;
        catch e
            fprintf('Jacobi: Error - %s\n', e.message);
            convergencia(i) = 0;
        end
    end

    % Guardar todos los datos para análisis comparativo
    save('resultados_comparacion.mat', 'tamanos', 'tiempos', 'iteraciones', 'errores', 'memorias', ...
        'perturbaciones', 'iter_perturb', 'tiempo_perturb', 'error_perturb', 'convergencia');

    % Graficar resultados por tamaño
    figure;
    subplot(2,2,1);
    plot(tamanos, tiempos, 'o-', 'LineWidth', 2);
    grid on;
    xlabel('Tamaño del sistema');
    ylabel('Tiempo (s)');
    title('Tiempo de ejecución vs Tamaño');

    subplot(2,2,2);
    plot(tamanos, iteraciones, 'o-', 'LineWidth', 2);
    grid on;
    xlabel('Tamaño del sistema');
    ylabel('Iteraciones');
    title('Iteraciones vs Tamaño');

    subplot(2,2,3);
    semilogy(tamanos, errores, 'o-', 'LineWidth', 2);
    grid on;
    xlabel('Tamaño del sistema');
    ylabel('Error relativo (log)');
    title('Error vs Tamaño');

    subplot(2,2,4);
    plot(tamanos, memorias, 'o-', 'LineWidth', 2);
    grid on;
    xlabel('Tamaño del sistema');
    ylabel('Memoria (KB)');
    title('Uso de memoria vs Tamaño');
end
