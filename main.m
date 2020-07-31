%% CREDITOS 
%  Codigo extraido de evolopy                                      
%F aris, Hossam, Ibrahim Aljarah, Seyedali Mirjalili, Pedro A. Castillo, and Juan Julián Merelo Guervós. 
% "EvoloPy: An Open-source Nature-inspired Optimization Framework in Python." In IJCCI (ECTA), pp. 171-177. 2016.
% https://www.scitepress.org/Papers/2016/60482/60482.pdf    
% y el trabajo realizado por Seyedali Mirjalili                  
% Pagina web: http://www.alimirjalili.com                          
%%
clear all 
clc
global Positions; 
global fitness;
global xcoor;
global ycoor;
global xo;
global yo;
global Startpoint;
global Targetpoint;
global dim
global obstacles
global no_obstables
global obstaclesRange
global obstaclesDanger
global xnew
global obstacle 
global sizee;

%% INICIALIZACIÓN POSICIÓN AGENTE, OBJETIVO Y OBSTACULOS

Startpoint=[0,0];
Targetpoint=[18,15];
no_obstables=2;
obstacles=[2 12; 4 9 ];
obstaclesRange=2;
obstaclesDanger=10;

%% INICIALICIÓN COEFICIENTES, COORDENADAS, FUNCIÓN OBJETIVO

coeff=mathoperations( Startpoint(1),Startpoint(2),Targetpoint(1),Targetpoint(2)); %Encontrar los coeficientes de nuestro punto de partida y objetivo
xcoor=gvxcoor(coeff,Startpoint,Targetpoint); %coordenadas que el agente seguirá
ycoor=gvycoor(coeff,Startpoint,Targetpoint,xcoor); %coordenadas que el agente seguirá
SearchAgents_no=50; % Numero de agentes de nuestra población
Function_name='PF'; % Elección de función objetivo, en este caso es pathfinding
Max_iteration=5000; % Número máximo de iteraciones
[lb,ub,dim,fobj]=Get_Functions_details(Function_name); %Inicialización de los detalles de la función

%% CALCULO ALGORITMO GWO CON LA FUNCIÓN OBJETIVO PF Y MEJOR SALIDA DE LA POSICIÓN INICIAL AL OBJETIVO

[Best_score,Best_pos,GWO_cg_curve]=GWO(SearchAgents_no,Max_iteration,lb,ub,dim,fobj); %Calculo función GWO Best_Score = Valor Alpha, Best_pos = Posición alpha, 
bestoutput = [ycoor(1) Best_pos(1:end) ycoor(end)]; %Coordenada del agente al bojetivo de acuerdo a la mejor ubicación del agente

%% GRAFICAR RECORRIDO Y OBSTACULOS

LineH =plot(xcoor,bestoutput,'b--o',obstacles(1,:),obstacles(2,:),'x');
title('Grafica 1: Plan de ruta y obstaculos')
axis([0 20 0 20]);
set(LineH, 'YLimInclude', 'off');
grid on;


%% RESULTADO EN PANTALLA

display(['El valor optimo del algoritmo GWO para la función objetivo (coste(obsataculo-punto de inflexion)) es: : ', num2str(Best_score)]);
display(['Mejor valor del agente para cada dimensión : ', num2str(bestoutput)]);

         


