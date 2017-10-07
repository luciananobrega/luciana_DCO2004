clc; clear all; close all;
% Para diminuir o tamanho do código desse experimento, coletaremos todos os dados Passo 1 da Prática 1
% e trabalharemos com o sinal gerado lá. Todas as variáveis terão o mesmo nome.
% O arquivo .mat deve sempre está na pasta em que o script está. Se necessário, rode o Passo 1 da Prática 1!!!
load('./Amostragem.mat');

%% Reconstrução realizando a filtragem no domínio da frequência
% Largura máxima de banda do filtro é dada por Bw = floor((lfft/N_samp)/2);
BW=10;                                                          % Largura de banda de 10
H_lpf=zeros(1,lfft);                                            % Zera vetor filtro
H_lpf(lfft/2-BW:lfft/2+BW-1)=1;                                 % Define 1 na frequência desejada (passa-banda)
S_recv=N_samp*S_out.*H_lpf;                                     % Filtragem ideal no domínio da frequência
s_recv=real(ifft(fftshift(S_recv)));                            % Reconstroi o sinal no tempo via ifft
s_recv=s_recv(1:lfft);                                          % Corrige numero de elementos 
s_recv=s_recv*(max(m_t)/max(s_recv));                           % Dá ganho pro sinal reconstruído

%%  Reconstrução realizando a filtragem no domínio do tempo por meio 
%   de uma interpolação explícita (usando a função sinc)
nSamples = length(s_out);                                       % Mede-se o comprimento do sinal
xSamples = 0 : nSamples-1;                                      % Vetor ordenado de amostras
trec = nSamples/Tf*[0:T:Tf];                                    % Eixo do tempo do sinal recuperado
Tsinc = 0.002;                                                  % Passo de tempo da sinc
Tfsinc = 50;                                                    % Tempo Final da sinc
tsinc = 0:Tsinc:Tfsinc;                                         % Eixo de tempo da sinc
s_recvSinc =0;                                                  % Cria o vetor da reconstrução
Bs = fm1;                                                       % Banda da transmissão (frequência do sinal original)
% Gera laço para somatório (interpolação explícita)
for ik = xSamples      
   Nx_sinc = s_out(ik+1)*sinc(2*pi*Bs*(tsinc-ik*T));            % Cria sinc para a amostra ik
   s_recvSinc = s_recvSinc+Nx_sinc;                             % Faz somatórios das sincs
end
s_recvSinc=s_recvSinc(1:lfft);                                  % Corrige comprimento do vetor
s_recvSinc=s_recvSinc*(max(m_t)/max(s_recvSinc));               % Ajusta o ganho
S_recvSinc=fftshift(fft(s_recvSinc,lfft)/lfft);                 % Espectro do sinal regenerado

%% Gráficos Reconstrução realizando a filtragem no domínio da frequência
% Plota espectro do sinal regenerado pelos dois métodos
fig = figure;
fig.PaperUnits = 'inches';
fig.PaperPosition = [0 0 12 9];
subplot(3,2,1);
plot(freq,abs(S_out));
title('Espectro do sinal amostrado');
axis([-150 150 0 .06]);
subplot(3,2,3);
plot(freq,abs(S_recv));
title('Regeneração no domínio da frequência');
xlabel('Frequência [Hz]');
axis([-150 150 0 .6]);
subplot(3,2,5);
plot(freq,abs(S_recvSinc));
title('Regeneração no domínio do tempo');
xlabel('Frequência [Hz]');
axis([-150 150 0 .6]);
% Plota sinal regenerado pelos dois métodos
subplot(3,2,2);
plot(t,m_t);
title('Sinal original');
subplot(3,2,4);
plot(t,s_recv(1:lfft));
title('Regeneração no domínio da frequência');
subplot(3,2,6);
plot(t,s_recvSinc(1:lfft));
title('Regeneração no domínio do tempo');
xlabel('Frequência [Hz]');