% Geração de Variável aleatória
clc;clear all; close all;
%% Parâmetros da Gaussiana
mu = 10;                                            % Média
sigma = 2;                                          % Desvio padrâo
vtnSamples = [1e2 1e3 1e5];                         % Número de amostras
vtSamples = sigma * randn(1,max(vtnSamples)) + mu;  
chLegend =[];
fig = figure;
fig.PaperUnits = 'inches';
fig.PaperPosition = [0 0 12 6];
for ik = 1:length(vtnSamples)
    nSamples = vtnSamples(ik);
    subplot(length(vtnSamples),1,ik)
    % PDF estimada
    binWidth = 0.1;
    vtCurrentS = vtSamples(1:nSamples);
    vtBins = min(vtCurrentS):binWidth:max(vtCurrentS);
    [y,x] = hist(vtCurrentS ,vtBins);
    plot(x,y/(binWidth*nSamples));
    hold all;
    % Pode ser feito também com
    % histogram(vtSamples(1:nSamples),'Normalization','pdf');
    %
    % PDF real
    vtPDF=normpdf(x,mu,sigma);
    plot(x,vtPDF);
    legend(['PDF Estimada = ' num2str(nSamples) ' amostras'],'PDF Real');
end


