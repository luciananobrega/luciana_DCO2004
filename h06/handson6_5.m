close all; clear all; clc;
%% Parâmetros
T=0.002;                                                % Taxa de amostragem (500kHz)
Tf=1;                                                   % Tempo final em segundos
t=0:T:Tf-T;                                             % Definição do eixo do tempo      
fm1=3;                                                  % Frequência senoide 1      
fm2=1;                                                  % Frequência senoide 2
m_t=sin(2*pi*fm2*t)-sin(2*pi*fm1*t);                    % Sinal mensagem m(t)
ts=0.02;                                                % Nova taxa de amostragem
N_samp=round(ts/T);                                     % Número de elementos
n = 8;                                                  % Número de bits por nível
L= 2^n;                                                 % Níveis de quantização
%
%% Amostragem 
s_out=downsample(m_t,N_samp);                           % Coleta 1 amostra a cada N_samp=10 amostras do sinal  
s_out=upsample(s_out,N_samp);                           % Retorna vetor amostrado com o numero inicial de elementos
%
%% Quantização
sig_max=max(s_out);                                     % Encontra pico máximo
sig_min=min(s_out);                                     % Encontra pico mínimo
Delta=(sig_max-sig_min)/L;                              % Intervalo de quantização (separação entre um nível e outro)
q_level=sig_min+Delta/2:Delta:sig_max-Delta/2;          % Vetor com amplitudes dos Q níveis 
sigp=s_out-sig_min;                                     % Shift para cima
sigp=sigp*(1/Delta);                                    % Calcula a quantidade de nívels
sigp=sigp+1/2;                                          % Tira elementos do zero 
qindex=round(sigp);                                     % Encontra inteiro mais proximo para cada elemento
qindex=min(qindex,L);                                   % Remove o excedente de qindex 
q_out=q_level(qindex);                                  % Calcula a amplitude quantizada de cada amostra
%
%% Codificador binário
vet_bin = de2bi(qindex-1);                              % Codificando sinal 
%
%% Decodificador de binário
vet_dec_rec = bi2de(vet_bin);                           % Transforma sinal para decimal novamente
revert = q_level(vet_dec_rec+1);                        % Recupera os níveis quantizados
%
% Gráficos
fig = figure;
fig.PaperUnits = 'inches';
fig.PaperPosition = [0 0 9 9];
subplot(2,1,1)
plot(t,m_t,t,q_out)
title('Sinal Original vs Sinal Amostrado e Quantizado');
xlabel('Tempo [s]');
ylabel('Amplitude');
%
subplot(2,1,2)
plot(t,m_t,t,revert)
title('Sinal Original vs Sinal Amostrado, Quantizado, Codificado e Decodificado');
xlabel('Tempo [s]');
ylabel('Amplitude');