%% CREDITOS
% % codigo extraido de evolopy                
%Faris, Hossam, Ibrahim Aljarah, Seyedali Mirjalili, Pedro A. Castillo, and Juan Julián Merelo Guervós. 
% "EvoloPy: An Open-source Nature-inspired Optimization Framework in Python." In IJCCI (ECTA), pp. 171-177. 2016.
% https://www.scitepress.org/Papers/2016/60482/60482.pdf                                                            
%% 

function [Alpha_score,Alpha_pos,Convergence_curve]=GWO(SearchAgents_no,Max_iter,lb,ub,dim,fobj)

% Inicializo posiciones alpha, beta y theta
Alpha_pos=zeros(1,dim);
Alpha_score=inf; %Problema de minimización

Beta_pos=zeros(1,dim);
Beta_score=inf; %Problema de minimización

Delta_pos=zeros(1,dim);
Delta_score=inf;

%Inicialización de la población
Positions=rand(SearchAgents_no,dim).*(ub-lb)+lb;

Convergence_curve=zeros(1,Max_iter);


l=0;



while l<Max_iter
   
    %% ORGANIZO POBLACIÓN DEPENDIENDO DE SU FUNCION OBJETIVO
   
    for i=1:size(Positions,1)   
        Flagub=Positions(i,:)>ub;
        Flaglb=Positions(i,:)<lb;
        Positions(i,:)=(Positions(i,:).*(~(Flagub+Flaglb)))+ub.*Flagub+lb.*Flaglb;               
              
        fitness=fobj(Positions(i,:)); % Calcular funcion objetivo para cada uno de los agentes
        
        
        if fitness<Alpha_score 
            Alpha_score=fitness; % Actualizar alfa
            Alpha_pos=Positions(i,:);
        end
        
        if fitness>Alpha_score && fitness<Beta_score 
            Beta_score=fitness; % Actualizar beta
            Beta_pos=Positions(i,:);
        end
        
        if fitness>Alpha_score && fitness>Beta_score && fitness<Delta_score 
            Delta_score=fitness; % Actualizar delta
            Delta_pos=Positions(i,:);
        end
    end
    %%
    
    a=2-l*((2)/Max_iter); % Decremento lineal de 2 a 0 (Explotación)

    % Actualización de los agentes de busqueda, incluyendo omegas,
    % dependiendo de los valores de alpha, beta y deltha
    for i=1:size(Positions,1)
        for j=1:size(Positions,2)     
                       
            r1=rand(); % r1 random [0,1]
            r2=rand(); % r2 random [0,1]
            
            A1=2*a*r1-a; % Ecuación 1 para perseguir y acercarse la presa, exploración
            C1=2*r2; % Ecuación 2 para perseguir y acercarse la presa, exploración
            
            D_alpha=abs(C1*Alpha_pos(j)-Positions(i,j)); % Ecuación 3 acosar a la presa, exploración
            X1=Alpha_pos(j)-A1*D_alpha; 
                       
            r1=rand();
            r2=rand();
            
            A2=2*a*r1-a; % Ecuación 1
            C2=2*r2; % Ecuación 2
            
            D_beta=abs(C2*Beta_pos(j)-Positions(i,j)); % Ecuación 3 acosar a la presa, exploración
            X2=Beta_pos(j)-A2*D_beta; 
            r1=rand();
            r2=rand(); 
            
            A3=2*a*r1-a; 
            C3=2*r2; 
            
            D_delta=abs(C3*Delta_pos(j)-Positions(i,j)); 
            X3=Delta_pos(j)-A3*D_delta;
            Positions(i,j)=(X1+X2+X3)/3;
            
        end
    end
    
    l=l+1;    %contador de iteración
    Convergence_curve(l)=Alpha_score; %resultado final
end


