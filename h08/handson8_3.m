% Parâmetros
EbN0_dB = 10;                                          % Eb/N0 de entrada
Ns = 10^5;                                             % Número de símbolos simulados
% Sinal BPSK gerado manualmente
bits = rand(1,Ns) > 0.5;                               % Gera 0s e 1s com mesma probabilidade
simbolo = 2*bits-1;                                    % Modulação BPSK: 0 -> -1; 1 -> 1 
sigmaRuido = 10^(-EbN0_dB/(2*10));                     % Desvio padrão do ruído AWGN 
n = sigmaRuido/sqrt(2)*[randn(1,Ns) + j*randn(1,Ns)];  % Amostras do ruído AWGN
y = simbolo + n;    % Sinal ruidoso

% Gráficos
fig = figure;
subplot(1,2,1);
plot(y(find(real(y)>0)),'ro');
hold on;
plot(y(find(real(y)<=0)),'bs')
title('Diagrama de constelação gerado manualmente');
legend('Bit 1 transmitido','Bit 0 transmitido');
minAx = min([real(y) imag(y)]);
maxAx = max([real(y) imag(y)]);
axis([minAx maxAx minAx maxAx]);
% Sinal M-PSK gerado pela função pskmod
M = 2;                                                 % Número de símbolo da modulação
bits2 = randi([0 M-1],Ns,1);
txSig = pskmod(bits2,M);
rxSig = awgn(txSig,EbN0_dB);
% Gráficos
subplot(1,2,2);
plot(rxSig(find(real(rxSig)>0)),'ro');
hold on;
plot(rxSig(find(real(rxSig)<=0)),'bs')
title('Diagrama de constelação pela função pskmod.m');
legend('Bit 1 transmitido','Bit 0 transmitido');
minAx = min([real(rxSig)' imag(rxSig)']);
maxAx = max([real(rxSig)' imag(rxSig)']);
axis([minAx maxAx minAx maxAx]);
fig.PaperUnits = 'inches';
fig.PaperPosition = [0 0 12 6];
clear all;