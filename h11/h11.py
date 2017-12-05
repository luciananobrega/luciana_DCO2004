import numpy as np
import matplotlib.pyplot as plt
from scipy.special import erfc

# Parâmetros
n_bits = int(1000)          # Número de bits
T = int(500)                # Tempo de símbolo OFDM
Ts = 2                      # Tempo de símbolo em portadora única
K = int(T/Ts)               # Número de subportadoras independentes
N = int(2*K)                # DFT de N pontos
sigmas=[0, 0.1, 1]          # Vetor de variâncias do ruído
vtEbN0_dB = np.arange(0,15) 

# Gerar bits aleatórios
dataIn=np.random.rand(n_bits)   # Sequência de números entre 0 e 1 uniformemente distribuídos
dataIn=np.sign(dataIn-.5)       # Sequência de -1 e 1
# Conversor serial paralelo
dataInMatrix = dataIn.reshape((int(n_bits/4),4))

# Gerar constelaçao 16-QAM
seq16 = 2*dataInMatrix[:,0]+dataInMatrix[:,1]+1j*(2*dataInMatrix[:,2]+dataInMatrix[:,3])

# Garantir propriedadade da simetria
X = np.concatenate([seq16, np.conj(seq16[::-1])])

# Construindo xn
xn = np.zeros((N), dtype=complex)
xn = (N/np.sqrt(N))*np.fft.ifft(X)

# Loop de variâncias
error = np.zeros(len(vtEbN0_dB))

for ik in range(len(vtEbN0_dB)):
    
    # Adição de ruído
    # sinal recebido = xn + ruído 
    noise = 1/np.sqrt(2)*(np.random.randn(int(N))+1j*np.random.randn(int(N)))
    noise = noise*10**(-vtEbN0_dB[ik]/10)
    rn = xn+noise
    # DFT de rn
    Y = np.zeros((K), dtype=complex)
    Y = (1/np.sqrt(N))*np.fft.fft(rn)
    
    # Demodulação 
    Z = np.zeros(len(Y), dtype=complex)
    for k in range(len(Y)): # Para percorrer todo o vetor Yk 
        if np.real(Y[k]) > 0: # Para parte real de Yk positiva
            if np.real(Y[k]) > 2:
                Z[k] = 3
            else:
                Z[k] = 1
        else: # Para parte real de Yk negativa ou igual a zero
            if np.real(Y[k]) < -2:
                 Z[k] = -3
            else:
                 Z[k] = -1

        if np.imag(Y[k]) > 0: # Para parte imaginaria de Yk positiva
            if np.imag(Y[k]) > 2:
                Z[k] = Z[k] + 1j*3
            else:
                Z[k] = Z[k] + 1j

        else: # Para parte imaginaria de Yk negativa ou igual a zero
            if np.imag(Y[k]) < -2:
                 Z[k] = Z[k] - 1j*3
            else:
                 Z[k] = Z[k] - 1j

    # Contagem de erro
    error= len(np.where(Z-X!=0)[0])
    print("Para EbN0 = " + str(vtEbN0_dB[ik])  + " dB, ha " +str(error) +" simbolos errados" )