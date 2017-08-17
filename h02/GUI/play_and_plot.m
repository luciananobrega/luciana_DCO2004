function [t,y] = play_and_plot(r)

tf = .4;                   % Tempo de duração da nota
fc = 512;                 % Frequência da nota Dó
fs = 100*fc;              % Frequência de amostragem da nota. 
t = 0:1/fs:tf;            % Vetor tempo. Para cada elemento do vetor t, haverá um elemento em y correspondente.
A = 1;                    % Amplitude do sinal
y=A*cos(2*pi*fc*t*r);     % Sinal senoidal

p = audioplayer(y, fs);   % Reproduzir o sinal gerado
play(p);                  % Reproduzir o sinal gerado
pause(tf);                % Forçar uma pausa com a duração do som a ser escutado

play(p)