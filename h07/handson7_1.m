clc; clear all;close all;
%% Parâmetros da distribuição
vtMu = [0 -10 10];              % Valores de média da Gaussiana
vtVar = [1 5 10];               % Valores de variância da Gaussiana
x = -20:0.1:20;
sigma = sqrt(vtVar(1));
% Variando a média e plotando os gráficos
fig = figure;
chLegend = [];
for ik=vtMu
    mu = ik;
    vtPDF=normpdf(x,mu,sigma);  % Função que retorna a PDF Gaussiana 
    vtCDF=normcdf(x,mu,sigma);  % Função que retorna a CDF Gaussiana
    subplot(2,2,1);
    plot(x,vtPDF);
    hold all;
    subplot(2,2,2);
    plot(x,vtCDF);
    hold all;
    %
    chLegend = [chLegend; {['Média =  ' num2str(mu )]}];
end
subplot(2,2,1);
legend(chLegend);
subplot(2,2,2);
legend(chLegend);
% Variando a variância e plotando gráficos
mu = vtMu(1);
chLegend = [];
for ik=vtVar
    sigma = sqrt(ik);
    vtPDF=normpdf(x,mu,sigma);
    vtCDF=normcdf(x,mu,sigma);
    subplot(2,2,3);
    plot(x,vtPDF);
    hold all;
    subplot(2,2,4);
    plot(x,vtCDF);
    hold all;
    %
    chLegend = [chLegend; {['\sigma =  ' num2str(sigma)]}];
end
subplot(2,2,3);
legend(chLegend);
subplot(2,2,4);
legend(chLegend);
fig.PaperUnits = 'inches';
fig.PaperPosition = [0 0 12 6];