clc; clear all; close all;
load('signal.mat')        % Abre o sinal a ser modulado
fs=1/Ts;                                   % Frequência de amostragem
Ac = 1;                                    % Amplitude da portadora
fc = 25;                                   % Frequência da portadora
c = Ac*cos(2*pi*fc*t);                     % Sinal portadora
s = c.*msg;                                % Sinal AM-DSB-SC

% Demodulação AM-DSB-SC
mr = 2*s.*c;

% Filtragem do sinal
B_m = 5;                                     % Banda do sinal
h=fir1(50,[B_m*Ts]);                         % Coeficientes do filtro
mr_filtrado=filter(h,1,mr);                 % Sinal filtrado

% Espectro do sinal antes da filtragem
subplot(3,1,1);
lfft=length(mr)*10;                         % Comprimento da fft (Arbitrário)
freq=(-fs/2:fs/lfft:fs/2-fs/lfft);          % Eixo de frequência 
Mfft=fft(mr,lfft)/lfft;                     % Calcula a FFT
M_sig=fftshift(Mfft);                       % Posiciona a FFT no centro
plot (freq ,abs(M_sig));
title('Sinal s(t)*c(t) no receptor antes da filtragem');
ylabel('Magnitude');
xlabel('Frequência [Hz]');
axis([-100 100 0 0.02]);                            

% Resposta em frequência do filtro
subplot(3,1,2);
[amp,freq] = freqz(h,fs);
plot(freq*fs/(2*pi),10*log10(abs(amp)));
title('Resposta em frequência do filtro');
ylabel('Magnitude');
xlabel('Frequência [Hz]');

% Espectro do sinal depois da filtragem
subplot(3,1,3);
lfft=length(mr_filtrado)*10;                         % Comprimento da fft (Arbitrário)
freq=(-fs/2:fs/lfft:fs/2-fs/lfft);          % Eixo de frequência 
Mfft=fft(mr_filtrado,lfft)/lfft;                     % Calcula a FFT
M_sig=fftshift(Mfft);                       % Posiciona a FFT no centro
plot (freq ,abs(M_sig));
title('Sinal s(t)*c(t) depois da filtragem');
ylabel('Magnitude');
xlabel('Frequência [Hz]');
axis([-100 100 0 0.02]);

figure;
% Gráfico do sinais modulante e demodulado
plot (t,msg,t,mr_filtrado);
legend('Sinal modulado s(t)','Sinal m(t) demodulado');
title('Demodulação AM-DSB-SC no tempo');
ylabel('Amplitude');
xlabel('Tempo [s]');