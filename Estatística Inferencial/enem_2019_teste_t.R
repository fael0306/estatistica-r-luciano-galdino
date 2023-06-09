######################################
###    TESTE t PARA UMA AMOSTRA    ###
######################################

#CONDI��ES: DISTRIBUI��O NORMAL E N�MERO DE AMOSTRAS MENOR QUE 30. 

if(!require(dplyr)) install.packages("dplyr")
if(!require(nortest)) install.packages("nortest")
if(!require(rstatix)) install.packages("rstatix") 
library(nortest)
library(dplyr)
library(rstatix)

# BUSCAR DIRET�RIO (PASTA COM OS ARQUIVOS)
setwd("C:/Users/Luciano/Desktop/Curso_estatistica_R")

#ABRIR ARQUIVO
enem2019_tratado <- read.csv('enem2019_tratado.csv', sep = ",")

#Criando o dataframe de interesse
colegioy=enem2019_tratado[which(enem2019_tratado$CO_ESCOLA=="35151506"),]
colegioy <- enem2019_tratado %>% filter(CO_ESCOLA == "35151506")
glimpse(colegioy)

#NORMALIDADE
#N�vel de signific�ncia (alfa) : 0,05
#Ho = distribui��o normal : p > 0.05
#Ha = distribui��o != normal : p <= 0.05

#Ci�ncias Naturais
#Shapiro-Wilk
shapiro.test(colegioy$NOTA_CH)
# Anderson-Darling
ad.test(colegioy$NOTA_CH)
#Lilliefors (Kolmogorov-Smirnov)
lillie.test(colegioy$NOTA_CH)
#Cramer-von Mises
cvm.test(colegioy$NOTA_CH)
#Histograma
hist(colegioy$NOTA_CH, probability=T, col="blue")
lines(density(colegioy$NOTA_CH) , col="red")
#QQplot
qqnorm(colegioy$NOTA_CH)
qqline(colegioy$NOTA_CH)

#TESTE-T
#M�dia das notas do col�gio y, comparada a m�dia do Estado de S�o Paulo.
#Ho = m�dia � igual a de S�o Paulo : p > 0.05
#Ha = m�dia � diferente da de S�o Paulo : p <= 0.05
summary(enem2019_tratado$NOTA_CH)

t.test(colegioy$NOTA_CH, mu = 529)

# INTERPRETA��O:
# Intervalo de confian�a de 95%
# Teste estat�stico: t(29)= 7.2426
# p_valor = 5.643e-08
# Conclus�o: A m�dia do col�gio y � diferente da m�dia do Estado de S�o Paulo com 95% de n�vel de confian�a.

# Observa��o: M�dia do col�gio x
summary(colegioy$NOTA_CH)


#Gr�fico Boxplot
par(mfrow=c(1,2))
boxplot(colegioy$NOTA_CH, ylab = "Nota de Ci�ncias Humanas")
boxplot(enem2019_tratado$NOTA_CH, ylab = "Nota de Ci�ncias Humanas")




