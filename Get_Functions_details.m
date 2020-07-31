% Información completa de la función objetivo
% lb es el limite inferior
% up es el limite superior
% dim es las dimensiones del problema

%% PARAMETROS FUNCIÓN OBJETIVO

function [lb,ub,dim,fobj] = Get_Functions_details(FUNCTION)


    switch FUNCTION
     case 'PF'
        global Startpoint
        global Targetpoint
        global sizee    
        global dim
        sizee=Targetpoint(1)-Startpoint(1)-1;  
         fobj = @PF;
        ub=100;
        lb=-100;
        dim=sizee;
  
    end

end

%%

function o = PF(x)

    global Startpoint
    global Targetpoint
    global xo;
    global yo;
    global xcoor;
    global ycoor;
    global sizee
    global xnew
    xo=xcoor;
    yo=ycoor;
    
    %% SE EVALUA EL COSTO DE LA RUTA RESPECTO A LOS PUNTOS DE INFLEXIÓN
    
    sizee=Targetpoint(1)-Startpoint(1); %determinar cuantos puntos de inflexion hay entre el objetivo y el agente
    cost=0;
   
    xnew = [ycoor(1) x(1:end) ycoor(end)]; % ruta en x realizada por el agente
    
    for c = 1:sizee
        distance=CalcDistance(xcoor(c),xnew(c),xcoor(c+1),xnew(c+1)); %Calcula la distancia euclidiana entre la nueva ruta generada y 
        cost=cost+distance;
    end
    
    %%
    
    global obstacles
    global no_obstacles
    global obstaclesRange
    global obstaclesDanger
    global obstacle
    
    %% SE EVALUA EL COSTO CON RESPECTO A LLOS OBSTACULOS
    
    obstacleCost=0;
    sizeee=sizee+1;
    for c = 1:sizeee
        for n = 1:no_obstacles    
            obstacle=CalcDistance(xcoor(c),xnew(c),obstacles(1,n),obstacles(2,n));
            if obstacle<=obstaclesRange
            obstacleCost=(obstacle*obstaclesDanger)+obstacleCost;   
            end
        end
    end
    
    %% SE EVALUA EL COSTO CON RESPECTO A LLOS OBSTACULOS
    
cost=cost+obstacleCost; % Se suman el costo de inflexión y el costo de cada uno de los obstaculos
o=cost;
end