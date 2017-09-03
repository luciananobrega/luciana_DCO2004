# -*- coding: utf-8 -*-
"""
Created on Sat Sep  2 12:02:15 2017

@author: luciana
"""

import numpy as np
import matplotlib.pyplot as plt
import time
## Geração do sinal cosenoidal
fsampling = 10                                               #Taxa de amostragem
tf = 200                                                     #Tempo entre amostras
t =  np.arange(0,tf+1/fsampling,1/fsampling)                 #Eixo do tempo
fm = 0.04                                                    #Frequência da senoide
Am = 2                                                       #Amplitude da senoide
m = Am*np.cos(2*np.pi*fm*t)                                  #Sinal senoidal
t1=time.clock()                                              #Contador de tempo

#Visualizando a amplitude do espectro com um tamanho arbitrário para a fft
lfft = 512                                                   #Tamanho da FFT  
#Construção do single-sided amplitude spectrum.
yfft = np.fft.fft(m,lfft)/lfft                               #Cálculo da FFT via função do Matlab
freq1 = np.arange(0,fsampling/2,fsampling/lfft)              #Definição do eixo das frequências unilateral
yfftuni = yfft[0:lfft//2]                                    #Coleta da FFT unilateral
plt.stem(freq1,abs(yfftuni))                                 #Plotagem do espectro unilateral M(f)
tempo_FFT=time.clock() - t1                                  #Conta tempo de execução até esse ponto do código
print('Tempo da FFT = ',tempo_FFT)                           #Mostra de tempo de execução
plt.title('Amplitude unilateral do Espectro de m(t)')        #Configuração do título do gráfico 
plt.xlabel('Frequencia (kHz)')                               #Configuração do eixo x do gráfico 
plt.ylabel('|M(f)|')                                         #Configuração do eixo y do gráfico  
plt.grid()                                                   #Adiona o grid  
plt.axis([0,0.1,0,1.2])                                      #Zoom do gráfico
plt.show()