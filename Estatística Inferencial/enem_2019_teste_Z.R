####################################
###   TESTE Z PARA UMA AMOSTRA   ###
####################################

# CONDI��ES: DISTRIBUI��O NORMAL E DESVIO PADR�O POPULACIONAL CONHECIDO. 

if(!require(dplyr)) install.packages("dplyr")
if(!require(nortest)) install.packages("nortest")
if(!require(BSDA)) install.packages("BSDA")
library(nortest)
library(dplyr)
library(BSDA) #teste Z

# BUSCAR DIRET�RIO (PASTA COM OS ARQUIVOS)
setwd("C:/Users/Luciano/Desktop/Curso_estatistica_R")

#ABRIR ARQUIVO
enem2019_tratado <- read.csv('enem2019_tratado.csv', sep = ",")

#Criando o dataframe de interesse
colegiox <- enem2019_tratado %>% filter(CO_ESCOLA=="35132287")

# Outra maneira que criar o data frame colegiox
# colegiox <- enem2019_tratado[which(enem2019_tratado$CO_ESCOLA=="35132287"),]

str(colegiox)
glimpse(colegiox)

#Verificando valores missing
sapply(colegiox, function(x) sum(is.na(x)))

# NORMALIDADE
# N�vel de signific�ncia (alfa) : 0,05
# Ho = distribui��o normal : p > 0.05
# Ha = distribui��o != normal : p <= 0.05

# Ci�ncias Naturais
# Shapiro-Wilk
shapiro.test(colegiox$NOTA_CN)
# Anderson-Darling
ad.test(colegiox$NOTA_CN)
#Lilliefors (Kolmogorov-Smirnov)
lillie.test(colegiox$NOTA_CN)
# Cramer-von Mises
cvm.test(colegiox$NOTA_CN)
# Histograma
hist(colegiox$NOTA_CN, probability=T, col="blue")
lines(density(colegiox$NOTA_CN) , col="red")
# QQplot
qqnorm(colegiox$NOTA_CN)
qqline(colegiox$NOTA_CN)


# M�dia das notas do col�gio X, comparada a m�dia do Estado de S�o Paulo.
# TESTE-Z
summary(enem2019_tratado$NOTA_CN) #m�dia do Estado de S�o Paulo
sd(enem2019_tratado$NOTA_CN) 
# Ho = m�dia � igual a de S�o Paulo : p > 0.05
# Ha = m�dia � diferente da de S�o Paulo : p <= 0.05


#TESTE Z BICAUDAL
z.test(colegiox$NOTA_CN, mu = 494.5, sigma.x = 78.62276, alternative = "t")
?z.test

# INTERPRETA��O:
# Intervalo de confian�a de 95%
# Teste estat�stico: z = 16.483
# p_valor < 2.2e-16
# Conclus�o: A m�dia do col�gio x � diferente da m�dia do Estado de S�o Paulo com 95% de confian�a.

# Observa��o: M�dia do col�gio x
summary(colegiox$NOTA_CN)
summary(enem2019_tratado$NOTA_CN)


###   SENSACIONAL   #####
