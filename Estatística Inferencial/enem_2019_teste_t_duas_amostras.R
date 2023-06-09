##########################################################
###    TESTE t Student (duas amostras independentes)   ###
##########################################################

if(!require(dplyr)) install.packages("dplyr")
if(!require(RVAideMemoire)) install.packages ("RVAideMemoire")
if(!require(car)) install.packages("car") 


library(dplyr) 
library(car) # Teste de homogeneidade (Levene)
library(RVAideMemoire) # Teste Shapiro por grupo

# BUSCAR DIRET�RIO (PASTA COM OS ARQUIVOS)
setwd("C:/Users/Luciano/Desktop/Curso_estatistica_R")

#ABRIR ARQUIVO
enem2019_tratado <- read.csv('enem2019_tratado.csv', sep = ",")

# Objetivo:
# Analisar a diferen�a entre as notas de Homens e mulheres de um col�gio.

# Criando o dataframe de interesse
colegioy <- enem2019_tratado %>% filter(CO_ESCOLA == "35151506")
str(colegioy)

#NORMALIDADE
#N�vel de signific�ncia (alfa) : 0,05
#Ho = distribui��o normal : p > 0.05
#Ha = distribui��o != normal : p <= 0.05

byf.shapiro(NOTA_CN ~ TP_SEXO, colegioy)
byf.shapiro(NOTA_CH ~ TP_SEXO, colegioy)
byf.shapiro(NOTA_LC ~ TP_SEXO, colegioy)
byf.shapiro(NOTA_MT ~ TP_SEXO, colegioy)
byf.shapiro(NOTA_REDACAO ~ TP_SEXO, colegioy)

# A nota de Linguagens e c�digos (LC) n�o passou no teste da normalidade.


# HOMOGENEIDADE DAS VARI�NCIAS (HOMOCEDASTICIDADE)
# Variabilidade dos erros constante.
# Ho = vari�ncias homog�neas : p > 0.05
# Ha = vari�ncias n�o homog�neas : p <= 0.05

leveneTest(NOTA_CN ~ TP_SEXO, colegioy, center=mean)
leveneTest(NOTA_CH ~ TP_SEXO, colegioy, center=mean)
leveneTest(NOTA_MT ~ TP_SEXO, colegioy, center=mean)
leveneTest(NOTA_REDACAO ~ TP_SEXO, colegioy, center=mean)

# TESTE t PARA AMOSTRAS INDEPENDENTES
# Ho = N�O H� DIFEREN�A ENTRE AS NOTAS : p > 0.05
# Ha = H� DIFEREN�A ENTRE AS NOTAS : p <= 0.05
# Default � bicaudal
# Para teste unicaudal deve colocar: alternative = "greater" ou alternative = "less"

t.test(NOTA_CN ~ TP_SEXO, colegioy, var.equal=TRUE)#vari�ncias homog�neas (var.equal=TRUE).
t.test(NOTA_CH ~ TP_SEXO, colegioy, var.equal=TRUE)
t.test(NOTA_MT ~ TP_SEXO, colegioy, var.equal=TRUE)
t.test(NOTA_REDACAO ~ TP_SEXO, colegioy, var.equal=TRUE)


# Pelo teste t, num intervalo de confian�a de 95%, h� diferen�a entre as notas de Ci�ncias
# Naturais, Ci�ncias Humanas e Matem�tica entre homens e mulheres. J� na Reda��o n�o se
# pode afirmar que h� diferen�a entre as notas das mulheres e homens.


par(mfrow=c(1,4)) # Gr�ficos na mesma linha
boxplot(NOTA_CN ~ TP_SEXO, colegioy, ylab="Notas de Ci�ncias Naturais", xlab="G�nero")
boxplot(NOTA_CH ~ TP_SEXO, colegioy, ylab="Notas de Ci�ncias Humanas", xlab="G�nero")
boxplot(NOTA_MT ~ TP_SEXO, colegioy, ylab="Notas de Matem�tica", xlab="G�nero")
boxplot(NOTA_REDACAO ~ TP_SEXO, colegioy, ylab="Notas de Reda��o", xlab="G�nero")


####   SENSACIONAL   #####




