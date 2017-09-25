clc; clear all; close all;
%% Determinando os parâmetros da onda
Ts=1e-4;                                                    % Período de amostragem
fs=1/Ts;                                                    % Frequência de amostragem
t = [0:5e3]*Ts;                                             % Definição do vetor tempo
fc = 500;                                                   % Frequência da portadora.
fm = 150;                                                   % Frequência do sinal
Am=1;                                                       % Amplitude do sinal senoidal
Ac=1;                                                       % Amplitude da portadora
carrierc = Ac*cos(2*pi*fc*t);                               % Sinal portadora cosseno (em fase)
carriers = Ac*sin(2*pi*fc*t);                               % Sinal portadora seno (em quadratura)
m1_t = Am*cos(2*pi*fm*t).*exp(-t*5);                        % Sinal mensagem (em fase)
m2_t = Am*exp(-t*40);                                       % Sinal mensagem (em quadratura)
B_m=150;                                                    % Banda para filtragem 
h=fir1(40,[B_m*Ts]);                                        % Filtro
lfft = length(t);                                           % FFT com o mesmo comprimento do sinal (t , m1_t e m2_t)
lfft = 2^ceil(log2(lfft)+1);                                % Comprimento da FFT em potência de 2
freqm = (-fs/2:fs/lfft:fs/2-fs/lfft);                       % Eixo da frequência 
M1 = fftshift(fft(m1_t,lfft)/lfft);                         % Sinal m1_t na frequência
M2 = fftshift(fft(m2_t,lfft)/lfft);                         % Sinal m2_t na frequência
%% Modulação QAM
% Modulação - Soma de duas DSB-SC ortogonais
x_qam = (m1_t).*(carrierc)+(m2_t).*(carriers);              % Sinal QAM no tempo
% Sinal na frequência 
lfft = length(t);                                           % FFT com o mesmo comprimento do sinal (t , m1_t e m2_t)
lfft = 2^ceil(log2(lfft)+1);                                % Comprimento da FFT em potência de 2
X_QAM=fftshift(fft(x_qam,lfft)/lfft);                       % Sinal QAM na frequência
freqm = (-fs/2:fs/lfft:fs/2-fs/lfft);                       % Eixo da frequência 

%% Demodulação QAM
% Separando sinais
m1_dem = x_qam.*cos(2*pi*fc*t)*2;                           % Demodulando m1_t
m2_dem = x_qam.*sin(2*pi*fc*t)*2;                           % Demodulando m2_t
M1_dem = fftshift(fft(m1_dem,lfft)/lfft);                   % m1_t na frequência antes da filtragem
M2_dem = fftshift(fft(m2_dem,lfft)/lfft);                   % m2_t na frequência antes da filtragem

% Filtro passa baixa
m1_rec=filter(h,1,m1_dem);                                  % Filtrando m1_dem 
M1_rec=fftshift(fft(m1_rec,lfft)/lfft);                     % Calculando o sinal recebido m1_rec na frequência
m2_rec=filter(h,1,m2_dem);                                  % Filtrando m2_dem 
M2_rec=fftshift(fft(m2_rec,lfft)/lfft);                     % Calculando o sinal recebido m2_rec na frequência
m1_rec = (max(m1_t)/max(m1_rec))*m1_rec;                    % Amplificando o sinal m1_rec
m2_rec = (max(m1_t)/max(m2_rec))*m2_rec;                    % Amplificando o sinal m2_rec

%% Sinais na frequência
% m1(t)*c(t) não filtrado
subplot(2,2,1)
plot(freqm,abs(M1_dem))
title('m_1(t)*c(t) não filtrado')
axis([-1500 1500 0 0.03 ])
% m1(t)*c(t) filtrado = m1(t) recuperado
subplot(2,2,3)
plot(freqm,abs(M1))
hold all;
plot(freqm,abs(M1_rec))
title('m_1(t) demodulado')
legend('Original','Demodulado');
axis([-1500 1500 0 0.03 ])
% m2(t)*c(t) não filtrado
subplot(2,2,2)
plot(freqm,abs(M2_dem))
title('m_2(t)*c(t) não filtrado')
axis([-1500 1500 0 0.03 ])
% m2(t)*c(t) filtrado = m2(t) recuperado
subplot(2,2,4)
plot(freqm,abs(M2))
hold all;
plot(freqm,abs(M2_rec))
title('m_2(t) demodulado')
legend('Original','Demodulado');
axis([-1500 1500 0 0.03 ])
% Espectro QAM
figure();
plot(freqm,abs(X_QAM))
title('Espectro do sinal QAM')
axis([-1500 1500 0 0.03 ])

%% Gráficos dos sinais no tempo
figure();
% Sinal QAM
subplot(3,1,1)
plot (t,x_qam)    
title('Sinal QAM no Tempo')
axis([0 0.08 -1.2 1.2 ])
% Sinal m1(t) demodulado
subplot(3,1,2);
plot (t,m1_t,t,m1_rec);
title('Sinal em fase m_1(t) - Tempo');
xlabel('Tempo [s]')
legend('m_1(t) original','m_1(t) demodulado');
axis([0 0.08 -1.2 1.2 ])
% Sinal m2(t) demodulado
subplot(3,1,3)
plot (t,m2_t,t,m2_rec)    
title('Sinal em quadratura m_2(t) - Tempo')
legend('m_2(t) original','m_2(t) demodulado');
axis([0 0.08 -1.2 1.2 ])