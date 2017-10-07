from scipy.io import loadmat
import numpy as np
import matplotlib.pyplot as plt
from scipy.fftpack import fft,fftshift,ifft

# Importa o sinal
variaveis = loadmat('./Amostragem.mat')
T = float(variaveis['T'])
lfft = int(variaveis['lfft'])
N_samp = int(variaveis['N_samp'])
S_out = variaveis['S_out'].flatten()
s_out = variaveis['s_out'].flatten()
m_t = variaveis['m_t'].flatten()
t = variaveis['t'].flatten()
freq = variaveis['freq'].flatten()
Bs = fm1 = float(variaveis['fm1'])

L = [8, 32, 128]    # Niveis de quantização
sig_max=max(m_t)    # Encontra pico máximo
sig_min=min(m_t)    # Encontra pico mínimo

# Quantização de m_t
for il in range(0,len(L)):
    Li = L[il]
    Delta=(sig_max-sig_min)/Li                       # Intervalo de quantização (distância entre um nível e outro)
    q_level=np.arange(sig_min+Delta/2,sig_max,Delta) # Vetor com as amplitudes dos Q níveis (Ex: nível 4 -- q_level(4)= -0.05V)

    sigp=m_t-sig_min                                 # Deixa o sinal somente com amplitudes positivas (shift para cima)
    # Calcula a quantidade de nívels (não inteiro ainda) de cada amostra (elementos >= 0)
    sigp=sigp*(1/Delta)                                
    sigp=sigp + 1/2 +0.0001                          # Tira elementos do zero 

    qindex=np.round(sigp)                            # Encontra inteiro mais proximo para cada elemento
    qindex[qindex>Li] = Li                           # Trunca o excedente de qindex 
    qindex = qindex.astype(int)                      # Casting para inteiro (garantindo que é do tipo inteiro)
    q_out=q_level[abs(qindex-1)]                     # Distribui nos níveis cada elemento 
    

    # Reconstrução de q_out realizando a filtragem no domínio do tempo
    # Gera laço para somatório
    Tsinc = 0.002                                                # Passo de tempo da sinc
    Tfsinc = 50                                                  # Tempo Final da sinc
    tsinc = np.arange(0,Tfsinc,Tsinc)                            # Eixo de tempo da sinc
    nSamples = len(q_out)                                        # Mede-se o comprimento do sinal
    xSamples = np.arange(0,nSamples)                             # Vetor ordenado de amostras
    q_recvSinc=0
    
    for ik in xSamples:      
        Nx_sinc = q_out[ik]*np.sinc(2*np.pi*Bs*(tsinc-ik*T))     # Cria sinc para a amostra ik
        q_recvSinc = q_recvSinc+Nx_sinc                          # Faz somatórios das sincs
    
    q_recvSinc = q_recvSinc[0:lfft]                                # Corrige comprimento do vetor
    q_recvSinc = q_recvSinc*(np.max(m_t)/np.max(q_recvSinc))       # Ajusta o ganho
    Q_recvSinc = fftshift(fft(q_recvSinc,lfft)/lfft)
    
    # Calculo de SQNR (dB)
    SQNR1 = np.mean(20*np.log10(np.abs(m_t[1:124])/(np.abs(m_t[1:124]-q_recvSinc[1:124]))))
    SQNR2 = np.mean(20*np.log10(np.abs(m_t[126:])/(np.abs(m_t[126:]-q_recvSinc[126:]))))
    SQNR = np.mean([SQNR1, SQNR2])
    
    # Plot sinal recuperado
    plt.figure(1,[20,12])
    plt.subplot(331)
    plt.plot(freq,abs(Q_recvSinc))
    plt.title("Regeneração no domínio da frequência {} niveis".format(Li))
    plt.xlabel("Frequência [Hz]")
    plt.xlim([-150,150])
    plt.ylim([0,0.6])
    # Plota sinal regenerado
    plt.subplot(332)
    plt.plot(t,q_recvSinc[:lfft],t,m_t)
    plt.text(.55, .5, r'SQNR = {}'.format(SQNR))
    plt.title("Regeneração no domínio do tempo {} niveis".format(Li))
    #plt.title(['Regeneração no domínio do tempo' num2str(Li) 'niveis. SQRN = ' num2str(SQNR) ' dB'])
    plt.legend(["Recuperado", "Original"])
    plt.show()
    
plt.show()