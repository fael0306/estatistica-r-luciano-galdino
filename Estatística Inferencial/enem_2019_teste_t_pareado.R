#############################
###    TESTE t PAREADO    ###
#############################

if(!require(dplyr)) install.packages("dplyr") 
library(dplyr) 



# BUSCAR DIRET�RIO (PASTA COM OS ARQUIVOS)
setwd("C:/Users/Luciano/Desktop/Curso_estatistica_R")

#ABRIR ARQUIVO
enem2019_tratado <- read.csv('enem2019_tratado.csv', sep = ",")

# OBJETIVO
# ANALISAR AS DIFEREN�AS ENTRE M�DIAS DAS NOTAS DOS COMPONENTES DA REDA��O.

#Criando o dataframe de interesse
colegioy <- enem2019_tratado %>% filter(CO_ESCOLA=="35151506")


# NORMALIDADE

# A diferen�a entre as vari�veis � que deve ser normal.
# N�vel de signific�ncia (alfa) : 0,05
# Ho = distribui��o normal : p > 0.05
# Ha = distribui��o != normal : p <= 0.05


colegioy$DiferencaNotas <- colegioy$NOTA_COMP1 - colegioy$NOTA_COMP2
shapiro.test(colegioy$DiferencaNotas)
colegioy$DiferencaNotas <- colegioy$NOTA_COMP1 - colegioy$NOTA_COMP3
shapiro.test(colegioy$DiferencaNotas)
colegioy$DiferencaNotas <- colegioy$NOTA_COMP1 - colegioy$NOTA_COMP4
shapiro.test(colegioy$DiferencaNotas)
colegioy$DiferencaNotas <- colegioy$NOTA_COMP1 - colegioy$NOTA_COMP5
shapiro.test(colegioy$DiferencaNotas)
colegioy$DiferencaNotas <- colegioy$NOTA_COMP2 - colegioy$NOTA_COMP3
shapiro.test(colegioy$DiferencaNotas)
colegioy$DiferencaNotas <- colegioy$NOTA_COMP2 - colegioy$NOTA_COMP4
shapiro.test(colegioy$DiferencaNotas)
colegioy$DiferencaNotas <- colegioy$NOTA_COMP2 - colegioy$NOTA_COMP5
shapiro.test(colegioy$DiferencaNotas)
colegioy$DiferencaNotas <- colegioy$NOTA_COMP3 - colegioy$NOTA_COMP4
shapiro.test(colegioy$DiferencaNotas)
colegioy$DiferencaNotas <- colegioy$NOTA_COMP3 - colegioy$NOTA_COMP5
shapiro.test(colegioy$DiferencaNotas)
colegioy$DiferencaNotas <- colegioy$NOTA_COMP4 - colegioy$NOTA_COMP5
shapiro.test(colegioy$DiferencaNotas)
# As combina��es aprovadas pelo teste de normalidade foram:
# NOTA_COMP2 com NOTA_COMP4;
# NOTA_COMP2 com NOTA_COMP5;
# NOTA_COMP3 com NOTA_COMP5;



# TESTE T PAREADO
# Ho = N�O H� DIFEREN�A ENTRE AS M�DIAS (DIFEREN�A M�DIA = 0) : p > 0.05
# Ha = H� DIFEREN�A ENTRE AS M�DIAS (DIFEREN�A M�DIA != 0) : p <= 0.05


t.test(colegioy$NOTA_COMP2, colegioy$NOTA_COMP4, paired = TRUE) #paired � pareado
# CONCLUS�O:
# N�O H� DIFEREN�A ENTRE AS M�DIAS, SENDO INTERVALO DE CONFIAN�A DE 95%,
# t (29) = - 0.72351
# p_valor = 0,4752
# M�dia das diferen�as = - 3,33



t.test(colegioy$NOTA_COMP2, colegioy$NOTA_COMP5, paired = TRUE)
# CONCLUS�O:
# N�O H� DIFEREN�A ENTRE AS M�DIAS, SENDO INTERVALO DE CONFIAN�A DE 95%,
# t (29) = - 0.22003
# p_valor = 0,8274
# M�dia das diferen�as = -1,33




t.test(colegioy$NOTA_COMP3, colegioy$NOTA_COMP5, paired = TRUE)
# CONCLUS�O:
# N�O H� DIFEREN�A ENTRE AS M�DIAS, SENDO INTERVALO DE CONFIAN�A DE 95%,
# t (29) = - 0.47186
# p_valor = 0,6406
# M�dia das diferen�as = -2,67



# AN�LISE PELO BOXPLOT
par(mfrow=c(1,2)) 
boxplot(colegioy$NOTA_COMP2, ylab="NOTAS", xlab="COMPONENTE 2")
boxplot(colegioy$NOTA_COMP4, ylab="NOTAS", xlab="COMPONENTE 4")

par(mfrow=c(1,2)) 
boxplot(colegioy$NOTA_COMP2, ylab="NOTAS", xlab="COMPONENTE 2")
boxplot(colegioy$NOTA_COMP5, ylab="NOTAS", xlab="COMPONENTE 5")

par(mfrow=c(1,2)) 
boxplot(colegioy$NOTA_COMP3, ylab="NOTAS", xlab="COMPONENTE 3")
boxplot(colegioy$NOTA_COMP5, ylab="NOTAS", xlab="COMPONENTE 5")

# MEDIDAS DE CENTRALIDADE E POSI��O
summary(colegioy[c('NOTA_COMP1','NOTA_COMP2', 'NOTA_COMP3', 'NOTA_COMP4', 'NOTA_COMP5')])


