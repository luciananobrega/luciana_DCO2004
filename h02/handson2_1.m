clear all;close all;      % Limpa variáveis e fecha todos os gráficos
% Parâmetros da onda
tf = 1;                   % Tempo de duração da nota
fc = 512;                 % Frequência da nota Dó
fs = 100*fc;              % Frequência de amostragem da nota. 
t = 0:1/fs:tf;            % Vetor tempo. Para cada elemento do vetor t, haverá um elemento em y correspondente.
A = 1;                    % Amplitude do sinal
y=A*cos(2*pi*fc*t);       % Sinal senoidal

p = audioplayer(y, fs);   % Reproduzir o sinal gerado
play(p);                  % Reproduzir o sinal gerado
pause(tf);                % Forçar uma pausa com a duração do som a ser escutado
axis([0 0.02 -2 2 ]);     % Zoom para melhor visualização

plot(t,y)
axis([0 0.003 -1.1 1.1 ]);     % Zoom para melhor visualização
hold on

y=A*cos(2*(9/8)*pi*fc*t);
plot(t,y)
y=A*cos(2*(9/8)*pi*fc*t);
plot(t,y)
y=A*cos(2*(5/4)*pi*fc*t);
plot(t,y)
y=A*cos(2*(4/3)*pi*fc*t);
plot(t,y)
y=A*cos(2*(3/2)*pi*fc*t);
plot(t,y)
y=A*cos(2*(5/3)*pi*fc*t);
plot(t,y)
y=A*cos(2*(15/8)*pi*fc*t);
plot(t,y)
hold off