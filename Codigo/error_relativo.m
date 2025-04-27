% Función para evaluar el error relativo con respecto a la solución exacta
function err = error_relativo(x_aprox, x_exacta)
    err = norm(x_aprox - x_exacta) / norm(x_exacta);
end

