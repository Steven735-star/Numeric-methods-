% comparacion_metodos_convergentes.m
% Este script compara el comportamiento de Jacobi y Gauss-Seidel
% en un sistema que garantiza la convergencia con una matriz diagonalmente dominante.

clc; clear; close all;

% Definición del sistema
n = 50;  % Tamaño del sistema

% Crear matriz aleatoria diagonalmente dominante
A = rand(n, n);  % Matriz base aleatoria

% Hacer la matriz estrictamente diagonalmente dominante
for i = 1:n
    suma_fila = sum(abs(A(i,:))) - abs(A(i,i));
    % Hacemos que cada elemento diagonal sea mayor que la suma del resto de elementos en su fila
    A(i,i) = suma_fila + rand(1) * 2 + 1; % Aseguramos que es estrictamente dominante
end

b = rand(n, 1);  % Vector independiente aleatorio

% Verificar si es diagonalmente dominante
es_dominante = true;
for i = 1:n
    suma_fila = sum(abs(A(i,:))) - abs(A(i,i));
    if abs(A(i,i)) <= suma_fila
        es_dominante = false;
        break;
    end
end
fprintf('¿La matriz es diagonalmente dominante? %s\n', mat2str(es_dominante));

% Mostrar la matriz generada
disp('Matriz generada A:');
disp(A);

% Parámetros
x0 = zeros(n, 1);         % Aproximación inicial
tol = 1e-15;               % Tolerancia
max_iter = 500;           % Número máximo de iteraciones

% Ejecución de métodos
[x_jacobi, errores_jacobi] = metodo_jacobi(A, b, x0, tol, max_iter);
[x_gs, errores_gs] = metodo_gauss_seidel(A, b, x0, tol, max_iter);

% Solución exacta para referencia
x_exacta = A \ b;
err_jacobi = norm(x_jacobi - x_exacta) / norm(x_exacta);
err_gs = norm(x_gs - x_exacta) / norm(x_exacta);

fprintf('Error final Jacobi: %.10e\n', err_jacobi);
fprintf('Error final Gauss-Seidel: %.10e\n', err_gs);
fprintf('Número de iteraciones Jacobi: %d\n', length(errores_jacobi));
fprintf('Número de iteraciones Gauss-Seidel: %d\n', length(errores_gs));

% Gráfica de la convergencia
figure;
semilogy(errores_jacobi, 'b-o', 'LineWidth', 1.5, 'MarkerSize', 4);
hold on;
semilogy(errores_gs, 'r-s', 'LineWidth', 1.5, 'MarkerSize', 4);
hold off;
grid on;
xlabel('Iteración');
ylabel('Error relativo (escala log)');
title('Comparación de Jacobi y Gauss-Seidel (Sistema Convergente)');
legend('Jacobi', 'Gauss-Seidel', 'Location', 'best');

