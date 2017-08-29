clc; close all;clear all;                                        % Limpa variáveis e fecha todos os gráficos
%% Geração do sinal cosenoidal
fsampling = 10;                                                  % Taxa de amostragem
tf = 200;                                                        % Tempo entre amostras
t = 0 : (1/fsampling) : tf;                                      % Eixo do tempo
fm = 0.04;                                                       % Frequência da senoide
Am = 2;                                                          % Amplitude da senoide
m = Am*cos(2*pi*fm*t);                                           % Sinal senoidal

%% Visualizando a amplitude do espectro com um tamanho arbitrário para a FFT
lfft = 1000;                                                  % Tamanho da FFT
yfft = fft(m,lfft)/lfft;                                      % Cálculo da FFT via função do Matlab
freq1 = [0 : fsampling/lfft : fsampling/2 - fsampling/lfft];  % Definição do eixo das frequências unilateral
yfftuni = yfft(1:lfft/2);                                     % Coleta da FFT unilateral
subplot(2,1,1)
stem(freq1,abs(yfftuni));                                     % Plotagem do espectro unilateral M(f)
grid on;
title(['Tamanho da FFT = ' num2str(lfft)]);
axis([ 0 0.1 0 1.2]);

%% Visualizando a amplitude do espectro com um tamanho arbitrário para a FFT
lfft2 = 512;                                                   % Tamanho da FFT
yfft2 = fft(m,lfft2)/lfft2;                                    % Cálculo da FFT via função do Matlab
freq2 = [0 : fsampling/lfft2 : fsampling/2 - fsampling/lfft2]; % Definição do eixo das frequências unilateral
yfftuni2 = yfft2(1:lfft2/2);                                   % Coleta da FFT unilateral
subplot(2,1,2)
stem(freq2,abs(yfftuni2));                                     % Plotagem do espectro unilateral M(f)
grid on;
title(['Tamanho da FFT = ' num2str(lfft2)]);
axis([ 0 0.1 0 1.2]);

%% Gráficos com a função plot()
figure;
subplot(2,1,1)
plot(freq1,abs(yfftuni));                                     % Plotagem do espectro unilateral M(f)
grid on;
title(['Tamanho da FFT = ' num2str(lfft)]);
axis([ 0 0.1 0 1.2]);
subplot(2,1,2)
plot(freq2,abs(yfftuni2));                                     % Plotagem do espectro unilateral M(f)
grid on;
title(['Tamanho da FFT = ' num2str(lfft2)]);
axis([ 0 0.1 0 1.2]);