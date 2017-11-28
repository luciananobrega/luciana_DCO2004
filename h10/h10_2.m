clear all; close all; clc;

% Parâmetros
N = 500;                                        % Número de amostras a gerar
vtK = [0,5,10];                                 % Fatores K Ricianos a simular
totPower=1;                                     % Total power of LOS path & scattered paths

% Loop nos valores de K
for ik = 1:length(vtK)
    K = vtK(ik);
    s=sqrt(K/(K+1)*totPower);                    % Parâmetro de não centralidade
    sigma=totPower/sqrt(2*(K+1));
    % Amostras do Canal Rice
    X = s + sigma*randn(N);                % LOS: VA Gaussina com média=s e sigma definido
    Y = 0 + sigma*randn(N);                % NLOS: VA Gaussina com média=0 e sigma definido
    Z = X + 1j*Y;
    
    %subplot?
    figure(ik)
    histogram(abs(Z),'Normalization', 'pdf')        % Histograma de Z
    
    % PDF teórica Rayleigh (para comparação)    
%     if K == 0
%         rayleigh_pdf = r/(sigma^2)*np.exp(-r^2/(2*sigma^2));
%         plot(r,rayleigh_pdf,'g*');
%         hold on
%     end
%     %TODO: PDF Rice teórica
%     fRice = 2.*r.*(K+1)/totPower.*exp(-r.^2.*(K+1)/totPower-K).*besseli(0,2.*r.*sqrt(K*(K+1)/totPower));
    
    % Gráficos
    %plot(r,fRice,'r')
    %hold off
    title(['K=' num2str(vtK(ik))])
    legend(['Rice K=' num2str(vtK(ik)) 'pelas amostras'])
end