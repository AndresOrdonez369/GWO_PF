
function [ xcoor ] = gvxcoor(coefficients,startpoint,targetpoint)
% encuentra los coeficiones para el eje x de la linea que conecta el punto
% inicial y el objetivo
    sizee=targetpoint(1)-startpoint(1)+1; 
    a=startpoint(1);
    for c = 1:sizee
        xcoor(c)=a; %encuentra la variable dependiente de la ruta que se seguirá
        a=a+1;
    end
end