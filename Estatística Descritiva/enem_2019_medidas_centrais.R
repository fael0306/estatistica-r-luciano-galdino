########################################
###   MEDIDAS DE TEND�NCIA CENTRAL   ###
########################################


#BAIXAR PACOTES, CASO ELES AINDA N�O ESTEJAM BAIXADOS
if(!require(dplyr)) install.packages("dplyr") 

#CARREGAR PACOTES
library(dplyr)

# BUSCAR DIRET�RIO (PASTA COM OS ARQUIVOS)
setwd("C:/Users/Luciano/Desktop/Curso_estatistica_R")

#ABRIR ARQUIVO
enem2019_tratado <- read.csv('enem2019_tratado.csv', sep = ",")

#M�DIA

mean(enem2019_tratado$NOTA_MT)

#MEDIANA

median(enem2019_tratado$NOTA_MT)

#MODA

#Criando uma fun��o
moda <- function(v) {
  valor_unico <- unique(v) # Busca o valor �nico para a coluna valor
  valor_unico[which.max(tabulate(match(v, valor_unico)))] #tabular (contabilizar quantas vezes o valor �nico aparece) e buscar o maior valor
}
#Obtendo a moda
resultado <- moda(enem2019_tratado$NOTA_MT)
print(resultado)

resultado <- moda(enem2019_tratado$NOTA_REDACAO)
print(resultado)


#HISTOGRAMA
#An�lise matem�tica
hist(enem2019_tratado$NOTA_MT, probability=T, col="blue")
lines(density(enem2019_tratado$NOTA_MT) , col="red")


#An�lise Reda��o
hist(enem2019_tratado$NOTA_REDACAO, probability=T, col="blue")
lines(density(enem2019_tratado$NOTA_REDACAO) , col="red")

mean(enem2019_tratado$NOTA_REDACAO)
median(enem2019_tratado$NOTA_REDACAO)
resultado <- moda(enem2019_tratado$NOTA_REDACAO)
print(resultado)








