

function [dBER] = simAntipodal(EbN0_dB,nMCSamples)
% Simula a BER para sinais antipodais para uma dada Eb/N0 em dB
%
% Parâmetros de Entrada:
%
%  EbN0_dB: Eb/N0, considerando Eb = 1
%  nMCSamples: número de bits transmitidos para estimar a BER
%
% Saídas
% 
%  dBER: BER estimada
%
% Essa função deve ser salva com o nome simAntipodal.m na mesma pasta 
% do arquivo h09.ipynb
%
% Exemplo de uso: [dBER] = simAntipodal(10,1e5);

% Parâmetros
dE = 1;                           % Energia do sinal s0 e s1
dEbN0 = 10^(EbN0_dB/10);          % Eb/No em escala linear
dsgma = dE/sqrt(2*dEbN0);         % Desvio padrão do ruído
%
%% Transmissão
% Geração dos números binários 0 e 1 com igual probabilidade
vtBin = randi([0 1],1,nMCSamples);
% Acha os índice de bits iguais a 0
vtIndex0 = find(vtBin == 0);
% Acha os índice de buts iguais a 1
vtIndex1 = find(vtBin == 1);
%
%% Recepção e detecção de erro
% Gera saída do correlator para cada transmissão de s0 e de s1
vtr(vtIndex0) = dE + dsgma*randn(1,length(vtIndex0));
vtr(vtIndex1) = -dE + dsgma*randn(1,length(vtIndex1));
%
% Detecção: 0 se, r > 0; e 1, se r < 0
vtBinDetec = vtr < 0;
%
% Detecção de erros (soma dos vetores originais e detectados)
% 0 + 0 = 0 (acerto)
% 1 + 1 = 2 (acerto)
% 0 + 1 = 1 (erro)
% 1 + 0 = 1 (erro)
vtError = vtBin + vtBinDetec; 
nErrors = length(find(vtError == 1));
% Cálculo da BER
dBER = nErrors/nMCSamples;


