N = 1024;                                       % Número de amostras da janela
y1=hamming(N);                                  % Janela tipo Hamming
y2=blackman(N);                                 % Janela tipo Blackman
y3=flattopwin(N);                               % Janela tipo Flattop
x= 0:1:N-1;                                     % Determinando eixo X
plot(x,y1,x,y2,x,y3);                           % Plotando o gráfico
legend('Hamming','Blackman','Flattop');         % Legendas do gráfico
title('Janelas');                               % Título do gráfico