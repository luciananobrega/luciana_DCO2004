clear all;close all;      % Limpa variáveis e fecha todos os gráficos
% Parâmetros da onda
tf = 1;                   % Tempo de duração da nota
fc = 512;                 % Frequência da nota Dó
fs = 100*fc;              % Frequência de amostragem da nota. 
t = 0:1/fs:tf;            % Vetor tempo. Para cada elemento do vetor t, haverá um elemento em y correspondente.
A = 1;                    % Amplitude do sinal
y=A*cos(2*pi*fc*t);       % Sinal senoidal
y=A*cos(2*(9/8)*pi*fc*t);
p = audioplayer(y, fs);   % Reproduzir o sinal gerado
play(p);                  % Reproduzir o sinal gerado
pause(tf);                % Forçar uma pausa com a duração do som a ser escutado
plot(t,y);                % Visualizar o sinal gerado  
axis([0 0.02 -2 2 ]);     % Zoom para melhor visualização