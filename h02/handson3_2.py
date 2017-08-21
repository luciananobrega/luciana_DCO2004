# -*- coding: utf-8 -*-
"""
Created on Mon Aug 21 10:31:17 2017

@author: luciana
"""

# -*- coding: utf-8 -*-
"""
Created on Mon Aug 21 10:28:37 2017

@author: luciana
"""

# -*- coding: utf-8 -*-
"""
Spyder Editor
"""
soundFile = './material/sound_01.wav'               # Especifica do local e nome do arquivo de áudio

import numpy as np
import scipy.io.wavfile as wv 
import os
import matplotlib.pyplot as plt


dFa,vtSom = wv.read(soundFile)                                   # Abre arquivo de áudio de um arquivo
# vtSom: amplitude das amostras de som
# dFa: frequência de amostragem do som (amostragem no tempo)
vtSom = 4.0 * vtSom
vtSomint16 = vtSom.astype('int16')                               #converte de float64 para int16 para reduzir ruído
dta = 1/dFa                                                      # Tempo entre amostras
dTFinal = (len(vtSom)-1)*dta                                     # Tempo da última amostra do sinal de áudio
vtTSom = np.arange(0,dTFinal+dta,dta)                            # Eixo temporal do arquivo de áudio
plt.figure(1,[10,7])
plt.plot(vtTSom,vtSom)                                           # Plota gráfico do áudio

font = {'family' : 'DejaVu Sans','weight' : 'bold','size': 12}   #Configura a fonte do título
plt.rc('font', **font)
plt.title('Sinal de Áudio')                                      # Configura título do gráfico
plt.ylabel('Amplitude')                                          # Configura eixo X do gráfico
plt.xlabel('Tempo (s)')                                          # Configura eixo Y do gráfico
plt.ylim([-120000,100000])
plt.show()


wv.write('tom_corrente.wav',dFa,vtSomint16) #grava o tom para reprodução

# Reproduz arquivo de áudio
os.system('cvlc --play-and-exit ./material/sound_01.wav')           
# Mostra informações gerais sobre o arquivo
print('Amostragem:')
print(' Taxa de amostragem = ',dFa,' Hz')
print(' Tempo entre amostras = ',dta,' Segundos')
print(' ')
print('Quantização e Codificação:')
print(' ')
print('Informações gerais do arquivo de áudio:')
print(' Número de canais = ',vtSom.shape)  
print(' Número de amostras = ',len(vtSom),' amostras')
print(' Duração = ',len(vtSom)*dta,' segundos')