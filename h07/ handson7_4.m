clear all;clc;close all;
% Estimar valor de pi por meio do método de monte carlo
lQuadrado = 5;                                          % Comprimento do quadrado
rCirculo = lQuadrado;                                   % Raio do circulo
vtPontos = [ 1e3 1e4 1e7 ];                             % Número de precisão
disp([ 'Valor real de pi =  ' num2str(pi)  ]);          % Mostra valor verdadeiro de pi

for ik = 1:length(vtPontos)
    nPontos = vtPontos(ik);
    % Pocisionar ponto no quadrado: Mutiplicando um número aleatório de 0 a
    % 1 pelo comprimento do quadrado para distribuir aleatoriamente nas
    % duas dimenções.
    vtSamples = lQuadrado*rand(1,nPontos) + i*lQuadrado*rand(1,nPontos);
    % Testa: 
    % Caso o modulo do vetor > raio do circulo --> 0 
    % Caso o modulo do vetor <= raio do circulo --> 1  
    indexPontCirculo = ( abs(vtSamples) <= rCirculo ); 
    % Encontra o numero de elementos dentro da area do circulo.
    razaoArea = length(find(indexPontCirculo))/nPontos;
    % Multiplica por 4 pois foi realizado apenas para 1/4 da area do circulo
    valordePi = 4*razaoArea;
    % Retorna o valor de pi estimado  
    disp([ ' ---- Experimento ' num2str(ik) ' ----------']);
    disp([ ' - Número de pontos = ' num2str(nPontos)   ]);
    disp([ ' - Razão entre as areas =  ' num2str(razaoArea)]);
    disp([ ' - pi estimado =  ' num2str(valordePi)  ]);
    disp([ ' - Erro =  ' num2str(pi-valordePi)  ]);  
    % Gráficos
    figure;
    vtPontosCirculo = vtSamples(indexPontCirculo); 
    plot(vtPontosCirculo,'.');
    title(['Simulação com ', num2str(nPontos), ' elementos' ])
        
end

