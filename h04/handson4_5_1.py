#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Sep 18 14:03:04 2017

@author: luciana
"""

import numpy as np
import scipy.io.wavfile as wv

#Geração de eco a partir de uma amostra de som
alfa = 0.5
fs, x = wv.read('./material/sound_01.wav')
timelag = 0.5                                                 
delta = round(fs*timelag)     
eco = np.zeros(len(x)+delta) 
eco[delta:] = alfa*x 
x_eco = np.zeros(len(eco))
x_eco += eco
x_eco[:len(x)] += x
t = np.linspace(0,len(x_eco)/fs,len(x_eco))

#Geração do sinal com zeros adicionados para visualização
x = np.concatenate((x,np.zeros(delta)),axis=0) #padding

#Valor normalizado autocorrelação:
autocorrelacao = np.correlate(x_eco,x_eco,'full')/len(x_eco) 
autocorrelacao = autocorrelacao[len(autocorrelacao)//2:]/1e9 
#Dividir por 10^9 foi opcional

#Detecção dos picos:
lags = np.linspace(0,len(autocorrelacao)-1,len(autocorrelacao))
import peakutils
indexes = peakutils.indexes(autocorrelacao,thres=0.4,min_dist=20000)
#local do eco : menor pico, mais distante (maior índice)
newdelta = max(indexes)
#a peakutils não é perfeitamente igual a 'findpeaks' do matlab
denominador = np.zeros(newdelta+1) 
denominador[0] = 1
denominador[-1] = alfa 
#índice -1 representa o último elemento
#denominador é o [1 zeros(1,newdelta-1) alfa]

#Filtragem:
from scipy import signal
x_new = signal.lfilter([1],denominador,x_eco)

#Plotagem dos resultados:
from matplotlib import pyplot as plt

plt.figure(1,[6,20])

plt.subplot(611)

plt.plot(t,x/max(x))
plt.plot(t,eco/max(x))
plt.title("Sinal original e eco")
plt.xlabel("Tempo[s]")
plt.legend(["Original","Eco"])

plt.subplot(612)

plt.plot(t,(x+eco)/max(x))
plt.title("Soma dos sinais")
plt.xlabel("Tempo[s]")

plt.subplot(613)

plt.plot(t,autocorrelacao)
plt.title("Autocorrelação com eco")

plt.subplot(614)
plt.plot(t,x)
plt.title("Sinal original")
plt.xlabel("Tempo[s]")

plt.subplot(615) 

plt.title("Picos encontrados")
plt.plot(lags,autocorrelacao)
plt.plot(indexes,autocorrelacao[indexes],'r*')

plt.subplot(616)

plt.title("Resultado da filtragem")
plt.plot(t,x_new)
plt.xlabel("Tempo[s]")

plt.tight_layout()
plt.show()