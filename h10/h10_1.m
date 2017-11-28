clear all; close all; clc;

% Parâmetros
N = 2000;                                  % Número de amostras
ts = 0.1;
x=[0:ts:5];                                % Eixo x
sigma = 1;                                  % Parâmetro Rayleigh
u = rand(N);                      % Amostras aleatórias uniformemente distribuídas de 0 a 1

% Canal Rayleigh real via método da inversão
rReal = sigma.*sqrt(-2*log(u));        % Rayleigh via método da inversão

% PDF Rayleigh teórico 
pdfTeo = x./(sigma^2).*exp(-(x./sigma).^2/2); 

% Canal Rayleigh complexo via VAs Gaussianas independentes
rComplexo = randn(N)+1j.*randn(N);

%% Gráficos
figure(1)
subplot(3,1,1)
hold on
% Histograma do Canal real vs PDF teórica
histogram(rReal,x, 'Normalization','pdf');

% PDF teórica
plot(x,pdfTeo,'r')
hold off
title('PDF da envoltória do canal Rayleigh real');
legend('Histograma das amostras - canal real','PDF teórica Rayleigh');

% Envoltória do Canal complexo
subplot(3,1,2)
hold on
% Histograma do Canal complexo vs PDF teórica
histogram(abs(rComplexo),x, 'Normalization','pdf');

% PDF teórica
plot(x,pdfTeo,'r')
hold off
title('PDF da envoltória do canal Rayleigh real');
legend('Histograma das amostras - canal complexo','PDF teórica Rayleigh');


% Histrograma da Fase do Canal complexo
subplot(3,1,3)
histogram(angle(rComplexo)*180/pi, 'Normalization', 'pdf')
title('PDF da fase do canal Rayleigh Complexo')

% % Histograma da envoltória do canal complexo vs PDF teórica
% histogram(abs(rComplexo),'Normalization','pdf');
% 
% % PDF teórica
% plot(x,pdfTeo,'r')
% title('PDF da envoltória do canal Rayleigh Complexo');
% legend('Histrograma das amostras - canal complexo','PDF teórica Rayleigh')
% 
% % Histrograma da Fase do Canal complexo
% subplot(3,1,3);
% hold all
% xhra=histogram(angle(rComplexo),'Normalizatio','pdf');
% title('PDF da fase do canal Rayleigh Complexo');
