clc; clear all;close all;      % Limpa variáveis e fecha todos os gráficos
%% Parâmetros da onda
f1=30;                         % Frequência do sinal em kHz
fs=128;                        % Frequência de amostragem em kHz
N=256;                         % Número de amostras
N1=1024;                       % Número de pontos da fft
n=0:N-1;                       % Index n
f=(0:N1-1)*fs/N1;              % Definição do eixo da frequência [axis]
x=cos(2*pi*f1*n/fs);           % Gerando o sinal
XR=abs(fft(x,N1));             % Encontra a magnitude da FFT usando janela retangular (sem janela)
xh=hamming(N);                 % Define a amostra em Hamming
xw=x .* xh';                   % Colocando a janela Hamming no sinal 
XH=abs(fft(xw,N1));            % Encontra a magnitude da frequência

%% Gráficos
% Sinal sem janela (retangular)
subplot(2,1,1);
plot(f(1:N1/2),20*log10(XR(1:N1/2)/max(XR)));
title('Espectro de x(t) usando janela retangular ');
grid;
xlabel('Frequência, kHz');
ylabel('Magnitude, [dB]');
axis([f(1) f(N1/2) -300 0]);

% Sinal com janela Hamming
subplot(2,1,2);
plot(f(1:N1/2),20*log10(XH(1:N1/2)/max(XH)));
title('Espectro de x(t) usando janela tipo Hamming');
grid;
xlabel('Frequência, kHz');
ylabel('Magnitude, [dB]');
axis([f(1) f(N1/2) -300 0]);