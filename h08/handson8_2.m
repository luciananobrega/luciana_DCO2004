%% AWGN complexo
clc;clear all;close all;
% Parâmetros
SNR_dB = 5;                               % Determina o valor da SNR em dB
t = 0:0.0001:5;                            % Eixo do tempo
x=2*cos(2*pi*10*t)+i*0.2*cos(2*pi*10*t);   % Sinal qualquer x(t)
%
% Geração manual das amostras de ruído 
N = length(x);                               % Calcula o comprimento de x
Ps = sum(abs(x).^2)/N;                       % Calcula a potência do sinal
SNR = 10^(SNR_dB/10);                        % Calcula a SNR linear
Pn = Ps/SNR;                                 % Calcula a potência do ruído
noiseSigma = sqrt(Pn/2);                     % Desvio padrão do ruído normalizado 
n = noiseSigma*[randn(1,N)+j* randn(1,N)];   % Vetor do ruído 
y = x + n;                                   % Sinal ruidoso na recepção
%
% Estimação da SNR pelas amostras do sinal recebido
pTx = sum(abs(x.^2))/N;                      % Potência do sinal x(t)
pNe = sum(abs(n.^2))/N;                      % Potência estimada do ruído
SNR1 = pTx/pNe;                              % Estimação da SNR linear
SNR1= 10*log10(SNR1);                        % SNR em dB
%
% Mostrar informações
disp('Estimação de SNR: ')
disp(['   SNR de entrada: ' num2str(SNR_dB) ' dB']);
disp(['   SNR de entrada: ' num2str(SNR1) ' dB']);
%
% Gráficos
fig=figure;
subplot(3,1,1);
plot(t,abs(x));
title('Sinal original')
axis([0 1 0 3]);
%
subplot(3,1,2);
plot(t,abs(y));
title('Sinal Com Ruido AWGN gerado manualmente');
axis([0 1 0 6]);
%
subplot(3,1,3);
plot(t,abs(n));
title('Ruido AWGN gerado manualmente');
axis([0 1 0 6]);
fig.PaperUnits = 'inches';
fig.PaperPosition = [0 0 12 6];