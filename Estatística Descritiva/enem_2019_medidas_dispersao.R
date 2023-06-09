###########################################
####   MEDIDAS DE DISPERS�O E POSI��O   ###
###########################################


#BAIXAR PACOTES, CASO ELES AINDA N�O ESTEJAM BAIXADOS
if(!require(dplyr)) install.packages("dplyr") 

#CARREGAR PACOTES
library(dplyr)

# BUSCAR DIRET�RIO (PASTA COM OS ARQUIVOS)
setwd("C:/Users/Luciano/Desktop/Curso_estatistica_R")

#ABRIR ARQUIVO
enem2019_tratado <- read.csv('enem2019_tratado.csv', sep = ",")


# MEDIDAS DE DISPERS�O

# VARI�NCIA
variancia <- var(enem2019_tratado$NOTA_MT)
print(variancia)

# DESVIO PADR�O
desvio <- sd(enem2019_tratado$NOTA_MT)
desvio

# MEDIDAS DE POSI��O
quantile(enem2019_tratado$NOTA_MT)
IQR(enem2019_tratado$NOTA_MT)
quantile(enem2019_tratado$NOTA_MT, probs = c(0.05, 0.95))
quantile(enem2019_tratado$NOTA_MT, seq(from = 0, to = 1, by = 0.20)) #percentil de 0 a 1 com passo de 0.2
diff(range(enem2019_tratado$NOTA_MT)) #diferen�a do m�nimo ao m�ximo (Amplitude)

#TODAS AS PRINCIPAIS MEDIDAS JUNTAS
summary(enem2019_tratado$NOTA_MT)
summary(enem2019_tratado[c('NOTA_MT', 'NOTA_CN', 'NOTA_LC', 'NOTA_CH', 'NOTA_REDACAO')]) #indexa��o de colunas



#COMPARANDO UMA AMOSTRA COM A POPULA��O
amostra <- sample(c(0,1), 499951, replace = TRUE, prob=c(0.8,0.2))
summary(as.factor(amostra))
prop.table(table(amostra))

amostra_teste <- enem2019_tratado[amostra==1,]
dim(amostra_teste)

#M�DIA
mean(enem2019_tratado$NOTA_MT)
mean(amostra_teste$NOTA_MT)

#MEDIANA
median(enem2019_tratado$NOTA_MT)
median(amostra_teste$NOTA_MT)

#MODA

#Criando uma fun��o
moda <- function(v) {
  valor_unico <- unique(v) # Busca o valor �nico para a coluna valor
  valor_unico[which.max(tabulate(match(v, valor_unico)))] #tabular (contabilizar quantas vezes o valor �nico aparece) e buscar o maior valor
}

#MODA
moda(enem2019_tratado$NOTA_MT)
moda(amostra_teste$NOTA_MT)

# Geral
summary(enem2019_tratado$NOTA_MT)
summary(amostra_teste$NOTA_MT)


######  SENSACIONAL ######





