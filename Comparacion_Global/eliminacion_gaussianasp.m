function x = eliminacion_gaussiana(A, b, pivot)
    n = length(b);
    Ab = [A b];
    for i = 1:n-1
        if pivot
            [~, idx] = max(abs(Ab(i:n, i)));
            idx = idx + i - 1;
            Ab([i, idx], :) = Ab([idx, i], :);
        end
        for j = i+1:n
            m = Ab(j,i)/Ab(i,i);
            Ab(j,:) = Ab(j,:) - m*Ab(i,:);
        end
    end
    % Sustitución regresiva
    x = zeros(n,1);
    for i = n:-1:1
        x(i) = (Ab(i,end) - Ab(i,1:n)*x) / Ab(i,i);
    end
end

