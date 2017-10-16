clc;clear all; close all;
%% Parâmetros da Gaussiana
lambda = 1;                                            % Média
nSamples = [1e5];                                      % Número de amostras
% Amostras geradas pelo método de inversão
vtU = rand(1,nSamples);                                % Amostras com distribuição uniforme
vtX = -lambda*log(1-vtU);                              % Amostras exponenciais geradas pelo método de inversão
% Gráficos
fig = figure;
fig.PaperUnits = 'inches';
fig.PaperPosition = [0 0 12 6];
subplot(2,1,1);
% PDF das amostras geradas
binWidth = 0.01;
vtBins = min(vtX):binWidth:max(vtX);
[y,x] = hist(vtX,vtBins);
plot(x,y/(binWidth*nSamples));
axis([0 6 0 1.2])
% PDF teórica
vtPDF = exppdf(vtBins, lambda);  % Distribuição 
hold all;
plot(x,vtPDF);
legend('PDF das amostras - método da inversão','PDF teórica');
subplot(2,1,2);
% CDF teórica
vtCDF = expcdf(vtBins, lambda);  % Distribuição
plot(vtBins,vtCDF);
hold all;
% CDF estimada pelas amostras
vtCDFEst = cdfplot(vtX);  
legend('CDF teórica', 'CDF das amostras - método da inversão');
% para colocar marcador somente em alguns pontos
vtPontos = 1:ceil(length(vtCDFEst.XData)/5)-1:length(vtCDFEst.XData);
plot(vtCDFEst.XData(vtPontos), vtCDFEst.YData(vtPontos), 'o');

