#####################################################
###    TESTE Z para duas amostras independentes   ###
#####################################################

if(!require(dplyr)) install.packages("dplyr")
if(!require(RVAideMemoire)) install.packages ("RVAideMemoire")
if(!require(BSDA)) install.packages("BSDA")

library(dplyr) 
library(RVAideMemoire) # Teste Shapiro por grupo
library(BSDA)

# BUSCAR DIRET�RIO (PASTA COM OS ARQUIVOS)
setwd("C:/Users/Luciano/Desktop/Curso_estatistica_R")

#ABRIR ARQUIVO
enem2019_tratado <- read.csv('enem2019_tratado.csv', sep = ",")

# Objetivo:
# Analisar a diferen�a entre as notas de Homens e mulheres de um col�gio.

#Criando o dataframe de interesse
colegiox <- enem2019_tratado %>% filter(CO_ESCOLA=="35132287")


#NORMALIDADE
#N�vel de signific�ncia (alfa) : 0,05
#Ho = distribui��o normal : p > 0.05
#Ha = distribui��o != normal : p <= 0.05

byf.shapiro(NOTA_CN ~ TP_SEXO, colegiox)
byf.shapiro(NOTA_CH ~ TP_SEXO, colegiox)
byf.shapiro(NOTA_LC ~ TP_SEXO, colegiox)
byf.shapiro(NOTA_MT ~ TP_SEXO, colegiox)
byf.shapiro(NOTA_REDACAO ~ TP_SEXO, colegiox)

# A nota de Reda��o n�o passou no teste da normalidade


colegiox_mulher <- colegiox %>% filter(TP_SEXO=="F")
colegiox_homem <- colegiox %>% filter(TP_SEXO=="M")




# TESTE Z PARA AMOSTRAS INDEPENDENTES
# Ho = N�O H� DIFEREN�A ENTRE AS NOTAS : p > 0.05
# Ha = H� DIFEREN�A ENTRE AS NOTAS : p <= 0.05


#Compara��o entre homens e mulheres das m�dias das notas do col�gio X.

#TESTE-Z - CI�NCIAS NATURAIS

sd(colegiox_mulher$NOTA_CN) #desvio padr�o mulher
sd(colegiox_homem$NOTA_CN) #desvio padr�o homem

#TESTE Z BICAUDAL
z.test(colegiox_mulher$NOTA_CN, sigma.x = 59.09334,
       colegiox_homem$NOTA_CN, sigma.y = 57.74716, alternative = "t")
?z.test




#TESTE-Z - CI�NCIAS HUMANAS
sd(colegiox_mulher$NOTA_CH) #desvio padr�o mulher
sd(colegiox_homem$NOTA_CH) #desvio padr�o homem
mean(colegiox_mulher$NOTA_CH) - mean(colegiox_homem$NOTA_CH)
#Ho = m�dia � igual a de S�o Paulo : p > 0.05
#Ha = m�dia � diferente da de S�o Paulo : p <= 0.05

z.test(colegiox_mulher$NOTA_CH, sigma.x = 47.21453, 
       colegiox_homem$NOTA_CH, sigma.y = 52.88721)



#TESTE-Z - LINGUAGES E C�DIGOS
sd(colegiox_mulher$NOTA_LC) #desvio padr�o mulher
sd(colegiox_homem$NOTA_LC) #desvio padr�o homem

z.test(colegiox_mulher$NOTA_LC, sigma.x = 32.86777, 
       colegiox_homem$NOTA_LC, sigma.y = 33.95025)



#TESTE-Z - MATEM�TICA
sd(colegiox_mulher$NOTA_MT) #desvio padr�o mulher
sd(colegiox_homem$NOTA_MT) #desvio padr�o homem

z.test(colegiox_mulher$NOTA_MT, sigma.x = 80.81464, 
       colegiox_homem$NOTA_MT, sigma.y = 83.56487)



# CONCLUS�O:
# PELO TESTE Z, N�O PODEMOS AFIRMAR, NUM INTERVALO DE CONFIAN�A DE 95%,
# QUE AS NOTAS DE CI�NCIAS HUMANAS S�O DIFERENTES ENTRE HOMENS E MULHERES. J� AS
# NOTAS DE MATEM�TICA, CI�NCIAS NATURAIS E LINGUAGENS E C�DIGOS, NUM INTERVALO DE 
# CONFIAN�A DE 95%, APONTAM QUE H� DIFEREN�A ENTRE AS NOTAS PARA HOMENS E MULHERES.


par(mfrow=c(1,4)) # Gr�ficos na mesma linha
boxplot(NOTA_CN ~ TP_SEXO, colegiox, ylab="Notas de Ci�ncias Naturais", xlab="G�nero")
boxplot(NOTA_CH ~ TP_SEXO, colegiox, ylab="Notas de Ci�ncias Humanas", xlab="G�nero")
boxplot(NOTA_MT ~ TP_SEXO, colegiox, ylab="Notas de Matem�tica", xlab="G�nero")
boxplot(NOTA_LC ~ TP_SEXO, colegiox, ylab="Notas de Linguages e c�digos", xlab="G�nero")




