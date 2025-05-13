% comparacion_global.m
% Comparación de métodos para resolver Ax = b

clc; clear; close all;

% Dimensión del sistema grande
n = 1000;

% Generar sistema grande y bien condicionado
A = rand(n);
for i = 1:n
    A(i,i) = sum(abs(A(i,:))) + 10;  % Hacer A diagonalmente dominante
end
b = rand(n,1);

% Solución de referencia
x_ref = A\b;

% Inicialización
methods = {'Gauss sin pivoteo', 'Gauss con pivoteo parcial', 'LU', 'Jacobi', 'Gauss-Seidel'};
results = struct();

% --- 1. Gauss sin pivoteo ---
fprintf('Ejecutando Gauss sin pivoteo...\n');
tic;
x1 = eliminacion_gaussiana(A, b, false);
time1 = toc;
error1 = norm(x_ref - x1) / norm(x_ref);
mem1 = whos('x1'); mem1 = mem1.bytes;

results(1).name = methods{1};
results(1).time = time1;
results(1).error = error1;
results(1).mem = mem1;

% --- 2. Gauss con pivoteo parcial ---
fprintf('Ejecutando Gauss con pivoteo parcial...\n');
tic;
x2 = eliminacion_gaussiana(A, b, true);
time2 = toc;
error2 = norm(x_ref - x2) / norm(x_ref);
mem2 = whos('x2'); mem2 = mem2.bytes;

results(2).name = methods{2};
results(2).time = time2;
results(2).error = error2;
results(2).mem = mem2;

% --- 3. Factorización LU ---
fprintf('Ejecutando LU...\n');
tic;
[L,U] = lu(A);
y = L\b;
x3 = U\y;
time3 = toc;
error3 = norm(x_ref - x3) / norm(x_ref);
mem3 = whos('x3'); mem3 = mem3.bytes;

results(3).name = methods{3};
results(3).time = time3;
results(3).error = error3;
results(3).mem = mem3;

% --- 4. Jacobi ---
fprintf('Ejecutando Jacobi...\n');
x0 = zeros(n,1);
tol = 1e-15; max_iter = 1000;
tic;
[x4, ~] = metodo_jacobi(A, b, x0, tol, max_iter);
time4 = toc;
error4 = norm(x_ref - x4) / norm(x_ref);
mem4 = whos('x4'); mem4 = mem4.bytes;

results(4).name = methods{4};
results(4).time = time4;
results(4).error = error4;
results(4).mem = mem4;

% --- 5. Gauss-Seidel ---
fprintf('Ejecutando Gauss-Seidel...\n');
tic;
[x5, ~] = metodo_gauss_seidel(A, b, x0, tol, max_iter);
time5 = toc;
error5 = norm(x_ref - x5) / norm(x_ref);
mem5 = whos('x5'); mem5 = mem5.bytes;

results(5).name = methods{5};
results(5).time = time5;
results(5).error = error5;
results(5).mem = mem5;

% Mostrar resultados
fprintf('\n%-25s | %-10s | %-15s | %-10s\n', 'Método', 'Tiempo (s)', 'Error Relativo', 'Mem (bytes)');
fprintf(repmat('-', 1, 70)); fprintf('\n');
for i = 1:numel(results)
    fprintf('%-25s | %-10.4f | %-15.2e | %-10d\n', ...
        results(i).name, results(i).time, results(i).error, results(i).mem);
end

