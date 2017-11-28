clear all; close all; clc;

% Parâmetros
N = 1e4;                           % Número de símbolos BPSK a serem transmitidos
EbN0dB = -5:2:20;        % Valores EbN0 a simular
EbN0=10.^(EbN0dB/10);               % EbN0 em escala linear
totPower=1;                         % Potência total (LOS + NLOS)
K=[0,5,30];                           % Valores K Ricianos a simular
% Transmissor
d=rand(N)>0.5;                     % Dados binários 
x = 2*d -1;                        % Símbolos BPSK: 0 representado por -1 e 1 representado por 1

% Configuração da figuras e linhas
figure(1)
%plotStyleSim=['b-*','r-o','k-d','g-^','m->','c-<']

% Loop de K Riciano
for index=1:length(K)
    k = K(index);                   % Valor de K corrente
    % Mensagem de progresso da simulação
    disp(['Simulando K = ', num2str(k)])
    % Canal
    % Parâmetro de não-centralidade e sigma de Rice
    s = sqrt( k/(k+1)*totPower ); 
    sigma = totPower/sqrt(2*(k+1));
   
    % Loop de EbNo
    for i= 1:length(EbN0dB)
        % Continuação do Canal
 
        % Ruído AWGN complexo com média 0 e variância 1 (vetor base)
        noise = 1/sqrt(2)*(randn(1,N)+1j*randn(1,N));
        % Vetor de ruído com potência proporcional a EbNo corrente    
        n = noise*10.^(-EbN0dB(i)/20); 
        % Desvanecimento Rice
        h = ((sigma*randn(1,N)+s)+1j*(randn(1,N)*sigma+0));
     
        % Receptor
        % Sinal recebido do canal Rice e AWGN
        y_ricean=h*x+n;
        % Receptor coerente: equalização + decisão
        y_ricean_cap=y_ricean/h; 
        r_ricean=real(y_ricean_cap)>0;
        % Contador de erro
        simBER_ricean(i)=sum(xor(d,r_ricean));
        % Fim do loop de EbN0
    end
    
    % Cálculo da BER para o valor de K corrente
    simBER_ricean=simBER_ricean/N;
    
    % Gráficos
    semilogy(EbN0dB,simBER_ricean,plotStyleSim(index))
end

% # Pes Teóricas
% # Implementação direta da equação de Pe para o canal Rayleigh+AWGN
% BER_rayleigh_teorica = 0.5*(1-np.sqrt(EbN0/(1+EbN0))) 
% # Implementação direta da equação de Pe para o canal somente AWGN
% BER_awgn_teorica = 0.5*erfc(np.sqrt(EbN0))
% #
% # Graficos
% # Rayleigh teórico
% plt.semilogy(EbN0dB,BER_rayleigh_teorica,'k-',label='Rayleigh teórica')
% # AWGN teórico
% plt.semilogy(EbN0dB,BER_awgn_teorica,'b--',label='AWGN teórica')
% plt.legend()
% plt.title('Eb/N0 Vs BER for BPSK over Rician Fading Channels with AWGN noise')
% plt.xlabel('Eb/N0(dB)')
% plt.ylabel('Bit Error Rate or Symbol Error Rate')
% plt.axis([-5,20,10**(-5),10**0])
% plt.show()