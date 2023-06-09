##############################
###   TESTE Qui-Quadrado   ###
##############################

if(!require(dplyr)) install.packages("dplyr")

library(dplyr) 


# BUSCAR DIRET�RIO (PASTA COM OS ARQUIVOS)
setwd("C:/Users/Luciano/Desktop/Curso_estatistica_R")

#ABRIR ARQUIVO
enem2019_tratado <- read.csv('enem2019_tratado.csv', sep = ",")

# OBJETIVO
# ANALISAR SE H� RELA��O DO G�NERO COM A ESCOLHA DO IDIOMA 

proporcao <- as.data.frame(table(enem2019_tratado$TP_SEXO))
labels.prop<-c(round(((proporcao[,2])/sum(proporcao[,2]))*100,2))
labels.porcentagem <-paste(labels.prop, "%", sep=" ")
pie(x=c(proporcao[1,2],proporcao[2,2]), labels=labels.porcentagem, col=c("red", "blue"), main="Rela��o entre homens e mulheres")
legend("topright", pch=15, col=c("red","blue"), legend=c("Mulheres", "Homens"))


# Cria��o de uma tabela de conting�ncia
tab <- table(enem2019_tratado$TP_SEXO, enem2019_tratado$TP_LINGUA)
tab

#Alterando as vari�veis 0 e 1 por Ingl�s e Espanhol
enem2019_tratado$TP_LINGUA[enem2019_tratado$TP_LINGUA==0] <- "Ingl�s"
enem2019_tratado$TP_LINGUA[enem2019_tratado$TP_LINGUA==1] <- "Espanhol"

# Cria��o de uma tabela de conting�ncia
tab <- table(enem2019_tratado$TP_SEXO, enem2019_tratado$TP_LINGUA)
tab

# TESTE QUI-QUADRADO
# Ho = N�O h� associa��o entre o g�nero e a escolha do idioma : p > 0.05
# Ha = h� associa��o entre o g�nero e a escolha do idioma : p <= 0.05
teste_qui <- chisq.test(tab)
teste_qui


# An�lise das frequ�ncias esperadas
teste_qui$expected


# CONCLUS�O:
# H� uma depend�ncia entre a escolha do idioma com o g�nero.
# Pelo teste qui-quadrado:
# p_valor < 2,2 e-16
# X-squared(1) = 5210




