% comparacion_metodos_no_convergentes.m
% Este script compara el comportamiento de Jacobi y Gauss-Seidel
% en un sistema que no satisface la condición de convergencia.
% Ninguno de los métodos debería converger.

clc; clear; close all;

% Definición del sistema
n = 5;  % Tamaño del sistema
A = [ 2,  3,  1,  5,  7;
      4,  2,  8,  1,  3;
      1,  7,  2,  4,  6;
      5,  1,  3,  2,  9;
      3,  4,  6,  7,  2 ]; % Matriz no diagonalmente dominante

b = rand(n, 1);           % Vector independiente aleatorio

% Parámetros
x0 = zeros(n, 1);         % Aproximación inicial
tol = 1e-6;               % Tolerancia
max_iter = 100;           % Número máximo de iteraciones

% Ejecución de métodos
[x_jacobi, errores_jacobi] = metodo_jacobi(A, b, x0, tol, max_iter);
[x_gs, errores_gs] = metodo_gauss_seidel(A, b, x0, tol, max_iter);

% Gráfica de la convergencia
figure;
semilogy(errores_jacobi, 'b-o', 'LineWidth', 1.5, 'MarkerSize', 4);
hold on;
semilogy(errores_gs, 'r-s', 'LineWidth', 1.5, 'MarkerSize', 4);
hold off;
grid on;
xlabel('Iteración');
ylabel('Error relativo (escala log)');
title('Comparación de Jacobi y Gauss-Seidel (Sistema No Convergente)');
legend('Jacobi', 'Gauss-Seidel', 'Location', 'best');

