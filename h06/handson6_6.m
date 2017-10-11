clc; clear all;close all;
%% Parâmetros dos sinais
t=0:0.01:10;
f1=0.5;
f2=0.2;
% Neste experimento os sinais devem ter a mesma amplitude, pois a
% quantização é feita sem ajuste da amplitude (por simplicidade)
A = 10;                                                
sinal01=A*cos(2*pi*f1*t);
sinal02=A*cos(2*pi*f2*t);

%% Codificador de sinais
% Ajustando sinal 01
sig_quan01= sinal01-min(sinal01)+1;                     % Todos elementos positivos
sig_quan01= round(sig_quan01);                          % Transforma sinal em números inteiros
sig_code01= de2bi(sig_quan01);                          % Transforma em sinal binário
[x,n] = size(sig_code01);                               % n é o número de bits do codificador
% Ajustando sinal 02
sig_quan02= sinal02-min(sinal02)+1;                     % Todos elementos positivos
sig_quan02= round(sig_quan02);                          % Transforma sinal em números inteiros
sig_code02= de2bi (sig_quan02);                         % Transforma em sinal binário

%% Multiplexador de sinais por entrelaçamento de palavras N bits (N = bits do codificador)
frameSize = 4;        % Tamanho do quadro (número máximo de sinais a serem multiplexados)                               
tMat = tic;
mux_sig_mat = zeros(frameSize*length(t),n);
vtIndexS1 = 1:frameSize:length(t)*(frameSize);  % Indices de posição do sinal 1 no vetor multiplexado 
vtIndexS2 = 2:frameSize:length(t)*(frameSize);  % Indices de posição do sinal 2 no vetor multiplexado (preenchido com zeros) 
vtIndexS3 = 3:frameSize:length(t)*(frameSize);  % Indices de posição do sinal 3 no vetor multiplexado
vtIndexS4 = 4:frameSize:length(t)*(frameSize);  % Indices de posição do sinal 4 no vetor multiplexado (preenchido com zeros)
mux_sig_mat(vtIndexS1,:) = sig_code01;
mux_sig_mat(vtIndexS3,:) = sig_code02;
dtMat = toc(tMat);
disp(['Tempo de execução da implementação matricial = ' num2str(dtMat)]);
tFor = tic;
mux_sig = zeros(frameSize*length(t),n);
vtZero = zeros(1,n);
for i=1:1:length(sig_code01)
    mux_sig(4*(i-1)+1,:)    =   sig_code01(i,:);
    mux_sig(4*(i-1)+2,:)    =   vtZero;
    mux_sig(4*(i-1)+3,:)    =   sig_code02(i,:);
    mux_sig(4*(i-1)+4,:)    =   vtZero;
end
dtFor = toc(tFor);
disp(['Tempo de execução da implementação com laço = ' num2str(dtFor)]);
disp(['Ganho da implementação matricial = ' num2str(100*(dtFor-dtMat)/dtFor) ' %']);
if ( isequal(mux_sig,mux_sig_mat) == 1)
    disp('Matrizes mux_sig e mux_sig_mat iguais');
else
    disp('Matrizes mux_sig e mux_sig_mat diferentes');
end
%% Demultiplexação 
% Com laço for
demux_01 = [];
demux_02 = [];
for i=1:length(sig_code01)
    demux_01(i,:)= mux_sig((i-1)*4 + 1,:);
    demux_02(i,:)= mux_sig((i-1)*4 + 3,:);
end
% Matricial
demux_01_mat = mux_sig_mat(vtIndexS1,:); 
demux_02_mat = mux_sig_mat(vtIndexS3,:);
if ( isequal(demux_01_mat,demux_01) == 1)
    disp('Matrizes demux_01_mat e demux_01 iguais');
else
    disp('Matrizes demux_01_mat e demux_01 diferentes');
end
if ( isequal(demux_02_mat,demux_02) == 1)
    disp('Matrizes demux_02_mat e demux_02 iguais');
else
    disp('Matrizes demux_02_mat e demux_02 diferentes');
end
% Decodificação
sig_rec01 = bi2de(demux_01);
sig_rec02 = bi2de(demux_02);
% Teste de decodifcação
if ( isequal(sig_quan01,sig_rec01.') == 1)
    disp('Sinais sig_quan01 e sig_rec01 iguais: decodificação realizada com sucesso!');
else
    disp('Sinais sig_quan01 e sig_rec01 diferentes: decodificação falhou!');
end

if ( isequal(sig_quan02,sig_rec02.') == 1)
    disp('Sinais sig_quan01 e sig_rec01 iguais: decodificação realizada com sucesso!');
else
    disp('Sinais sig_quan01 e sig_rec01 diferentes: decodificação falhou!');
end