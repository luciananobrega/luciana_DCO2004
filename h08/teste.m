clear;clc;
% Parâmetros
EbN0_dB = [20 5 0];     % Eb/N0 de entrada
Ns = 10^3;              % Número de símbolos simulados
M = 8;                  % Número de símbolo da modulação BPSK

for i = 1:length(EbN0_dB)
    bits8 = randi([0 M-1],Ns,1);
    txSig = pskmod(bits8,M);
    rxSig = awgn(txSig,EbN0_dB(i));
    
    unique = unique(txSig); 
    
    % Gráficos
    figure(i);
    plot(rxSig(find(txSig==unique(1))),'ro')
    hold on;
    plot(rxSig(find(txSig==unique(2))),'bs')
    hold on;
    plot(rxSig(find(txSig==unique(3))),'g*')
    hold on;
    plot(rxSig(find(txSig==unique(4))),'k.')
    hold on;
    plot(rxSig(find(txSig==unique(5))),'mo')
    hold on;
    plot(rxSig(find(txSig==unique(6))),'co')
    hold on;
    plot(rxSig(find(txSig==unique(7))),'yo')
    hold on;
    plot(rxSig(find(txSig==unique(8))),'r*')
    hold on;
    title(['Eb/N0 = ' num2str(EbN0_dB(i)) ' dB']);
    %legend('Bit 1 transmitido','Bit 0 transmitido');
    minAx = min([real(rxSig)' imag(rxSig)']);
    maxAx = max([real(rxSig)' imag(rxSig)']);
    axis([minAx maxAx minAx maxAx]);


end