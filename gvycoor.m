function [ ycoor ] = gvycoor(coefficients,startpoint,targetpoint,xcoor)
% Encuentra los coeficientes para el eje y de la línea que
% conecta el punto inicial y el objetivo.
    a=coefficients(1);
    b=coefficients(2);
    sizee=targetpoint(1)-startpoint(1)+1; 
    for c = 1:sizee
        ycoor(c)=a*xcoor(c)+b; %Encuentra la linea total que habra entre la posición inicial y el objetivo
    end
end