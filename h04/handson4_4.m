clc; close all;clear all;
%% Parâmetros do sinal 
fc=0.04;                              % Frequência do seno
Fs=10;                                % Frequência de amostragem
Ts = 1/Fs;                            % Tempo entre amostras
A = 10;                               % Amplitude do sinal
nC = 2000;                            % Número de períodos da onda   
t=0:Ts:nC/fc-Ts;                      % Vetor tempo
x=A*cos(2*pi*fc*t);                   % Gera o sinal x(n)
N = length(x);                        % Número de amostras do sinal

Nfft = 1000;
Xfft=fft(x,Nfft);                     % Encontra a FFT
Xfft = Xfft(1:end/2);
f=[0:Fs/Nfft:0.5*Fs-Fs/Nfft];         % Eixo da frequência
subplot(3,1,1);
stem (f,abs(Xfft)/Nfft);              % Plota a espectro
title('FFT do sinal');                % Configura título
xlabel('Frequência');
ylabel('Magnitude');
grid on;
axis([0 2*fc 0 A^2/4]);               % Zoom no gráfico

[pxx,f] = periodogram(x,hamming(length(x)),length(x),Fs,'power');
[pwrest,idx] = max(pxx);
subplot(3,1,2);
plot(f,pxx);
title('Peridiograma');
xlabel('Frequência');
ylabel('Potência (W)');
grid on;
axis([0 2*fc 0 A^2]);
disp(['A potência máxima ocorre em ' num2str(f(idx)) ' Hz' ] );
disp(['A potência estimada é ' num2str(pwrest) ] );
subplot(3,1,3);
periodogram(x,hamming(length(x)),length(x),Fs,'power');
axis([0 2*fc 0 10*log10(A^2)]);