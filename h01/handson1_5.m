clear all;clc;close all;
dPasso = 5;                          % Resolução do grid
dDim = 200;                          % Dimensão do grid
nl = (dDim-2*dPasso)/dPasso + 1;     % Número de pontos de medição
%% Código sem Laço
t2 = tic;                            % Abre um contador de tempo identificado por t2
% Matriz com posição de cada ponto do grid (posição relativa ao canto inferior direito)
[px,py] = meshgrid(dPasso:dPasso:dDim-dPasso, dPasso:dPasso:dDim-dPasso);
% Matrizes com posição de cada ponto do grid relativa a cada BS
pbs0SF = px + j*py - ( dDim/2 + 0.8*dDim*j);
pbs1SF = px + j*py - ( dDim/2 + 0.2*dDim*j);
% Cálculo da potência recebida em cada roteador
pl0SF = 10*log10(1./(abs(pbs0SF).^4)/1e-3);
pl1SF = 10*log10(1./(abs(pbs1SF).^4)/1e-3);
% Cálculo da melhor potência e cada ponto do grid
plfSF = max(pl0SF,pl1SF);
tempoSemFor = toc(t2); % fecha contador de tempo e guarda tempo na variável tempoComFor
disp(['Tempo sem Laço FOR = ' num2str(tempoSemFor)]); % Mostra tempo de execuçao do código
%% Gráficos para código com e sem laços for
% Plota as posiçoes dos pontos do grid para os dois roteadores
subplot(1,2,1); plot(pbs0SF,'ko');title('Roteador 0 sem Laço');
subplot(1,2,2); plot(pbs1SF,'ko');title('Roteador 1 sem Laço');
figure;
% Plota a mapa de cores relativo a potência para os dois roteadores separadamente
subplot(1,2,1); pcolor(pl0SF);title('Roteador 0 sem Laço');
subplot(1,2,2); pcolor(pl1SF);title('Roteador 1 sem Laço');
figure;
% Plota a mapa de cores relativo a melhor potência em cada ponto do grid (melhor entre os dois roteadores)
pcolor(plfSF);title(['Sistema sem Laço - tempo ' num2str(tempoSemFor)]);