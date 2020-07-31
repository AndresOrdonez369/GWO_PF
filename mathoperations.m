function [ coefficients ] = mathoperations( x1,y1,x2,y2 )
    coefficients = polyfit([x1, x2], [y1, y2], 1); %devuelve los coeficientes de la posición inicial y el objetivo
end