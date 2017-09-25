clear all; clc; close all
ts = 1e-4;                                                % Tempo de amostragem
t = -0.04:ts:0.04;                                        % Vetor do tempo
fc = 300;                                                 % Frequência da portadora
% Sinal modulante (duas funções triângulo)
% m = 1-|t| , if |t|<1
% m = 0 , if |t|>1
Ta = 0.01;                                                
mp1 = (1-abs((t+0.01)/Ta)).*((t+0.01)/Ta>=-1).*((t+0.01)/Ta<1); 
mp2 = (1-abs((t-0.01)/Ta)).*((t-0.01)/Ta>=-1).*((t-0.01)/Ta<1); 
msg = mp1-mp2;                                            % Sinal modulante 
% Espectro do sinal modulante
lfft = length(t);                                         % Tamanho da FFT
Mf = fftshift(fft(msg,lfft)/lfft);                        % Espectro centralidado
freqm = (-lfft/2:lfft/2-1)/(lfft*ts);                     % Eixo de frequência
% Definição do Filtro
B_m = 100;                                                % Largura de banda B_m Hz
h = fir1(80,[B_m*ts]);                                    % Filtro passa-baixa
% Modulação FM
kf = 160*pi;
m_int = kf*ts*cumsum(msg);                                % kf*Integral de m(t)
sfm = cos(2*pi*fc*t+m_int);                               % Sinal modulado em FM
% Espectro do sinal modulado
lfft = length(t);                                         % Tamanho da FFT
Sf = fftshift(fft(sfm,lfft)/lfft);                        % Espectro de s(t)

% Demodulação FM
s_fmdiff = diff([sfm(1) sfm])/ts/kf;                      % Derivada de s(t): conversão FM para AM
s_fmrec = s_fmdiff.*(s_fmdiff>0);                         % Parte 1 da detecção de envoltória: retificação
s_dem = filter(h,1,s_fmrec);                              % Parte 2 da detecção de envoltória: filtragem 

% Espectro do sinal modulado
lfft = length(t);                                         % Tamanho da FFT
Mf_rec = fftshift(fft(s_dem,lfft)/lfft);                  % Espectro de m(t) demodulado

% Gráficos no tempo
subplot(2,2,[1 2]);
% Sinal modulado FM 
plot(t,sfm);
xlabel('Tempo [s]'); 
ylabel('s(t)');
title('Sinal modulado FM');
subplot(2,2,3);
% Sinal modulante 
plot(t,msg);
xlabel('Tempo [s]'); 
ylabel('m(t)');
title('Sinal modulante');
% Sinal demodulado
subplot(2,2,4);
plot(t,s_dem,'r');
xlabel('Tempo [s]'); 
ylabel('m(t) recuperado');
title('Sinal demodulado');

% Espectro dos sinais
figure;
subplot(2,2,[1 2]);
% Sinal modulado FM 
plot(freqm,abs(Sf));
xlabel('Frequência [Hz]'); 
ylabel('S(f)');
title('Sinal modulado FM');
axis([-500 500 0 0.3]);
subplot(2,2,3);
% Sinal modulante 
plot(freqm,abs(Mf));
xlabel('Frequência [Hz]'); 
ylabel('M(f)');
title('Sinal modulante');
axis([-500 500 0 0.3]);
% Sinal demodulado
subplot(2,2,4);
plot(freqm,abs(Mf_rec),'r');
xlabel('Frequência [Hz]'); 
ylabel('M(f) recuperado');
title('Sinal demodulado');
axis([-500 500 0 1.5]);