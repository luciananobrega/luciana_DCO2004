clc; close all;clear all;                                     % Limpa variáveis e fecha todos os gráficos
%% Geração do sinal cosenoidal
fsampling = 10;                                               % Taxa de amostragem
tf = 200;                                                     % Tempo entre amostras
t = 0 : (1/fsampling) : tf;                                   % Eixo do tempo
fm = 0.04;                                                    % Frequência da senoide
Am = 2;                                                       % Amplitude da senoide
m = Am*cos(2*pi*fm*t);                                        % Sinal senoidal

%% Plot do sinal M(f): single-sided amplitude spectrum.
% Visualizando a amplitude do espectro com um tamanho arbitrário para a fft
lfft = 1000;
%% Construção do single-sided amplitude spectrum.
yfft = fft(m,lfft)/lfft;                                      % Cálculo da FFT via função do Matlab
freq1 = [0 : fsampling/lfft : fsampling/2 - fsampling/lfft];  % Definição do eixo das frequências unilateral
yfftuni = yfft(1:lfft/2);                                     % Coleta da FFT unilateral
subplot(1,2,1);
stem(freq1,abs(yfftuni));                                     % Plotagem do espectro unilateral M(f)
title('Espectro unilateral');                                 % Configuração do título do gráfico 
xlabel('Frequencia (kHz)');                                   % Configuração do eixo x do gráfico 
ylabel('|M(f)|');                                             % Configuração do eixo y do gráfico  
grid on;                                                      % Adiona o grid  
axis([ 0 0.1 0 1.2]);                                         % Zoom do gráfico

%% Plot do sinal M(f): double-sided amplitude spectrum.
% Colocando as frequência no lado esquerdo; 
subplot(1,2,2);
%% Construção do double-sided amplitude spectrum.
lfftd = 1000;
yfftd = fft(m,lfftd)/lfftd;                                   % Cálculo da FFT via função do Matlab
yfftd = fftshift(yfft);
% Definição do eixo das frequências unilateral
freqd = [-fsampling/2 : fsampling/lfftd : fsampling/2 - fsampling/lfftd];
stem(freqd,abs(yfftd));                                       % Plotagem do espectro unilateral M(f)
title('Espectro bilateral');                                  % Configuração do título do gráfico 
xlabel('Frequencia (kHz)');                                   % Configuração do eixo x do gráfico 
ylabel('|M(f)|');                                             % Configuração do eixo y do gráfico  
grid on;                                                      % Adiona o grid  
axis([ -0.1 0.1 0 1.2]);                                      % Zoom do gráfico