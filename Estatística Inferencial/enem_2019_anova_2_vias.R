###############################
####   ANOVA de duas vias   ###
###############################

if(!require(dplyr)) install.packages("dplyr")
if(!require(car)) install.packages("car") # Teste levene
if(!require(rstatix)) install.packages("rstatix")
if(!require(DescTools)) install.packages("DescTools") # Pos-hoc 
if(!require(ggplot2)) install.packages("ggplot2")
if(!require(emmeans)) install.packages("emmeans") #m�dias marginais

library(emmeans)
library(dplyr)
library(car)
library(rstatix)
library(DescTools)
library(nortest)
library(ggplot2)

# BUSCAR DIRET�RIO (PASTA COM OS ARQUIVOS)
setwd("C:/Users/Luciano/Desktop/Curso_estatistica_R")

#ABRIR ARQUIVO
enem2019_tratado <- read.csv('enem2019_tratado.csv', sep = ",")

# OBJETIVO
# ANALISAR DIFEREN�A ENTRE AS M�DIAS POR G�NERO E RA�A

colegiox <- enem2019_tratado[which(enem2019_tratado$CO_ESCOLA=="35132287"),]

colegiox$NOTA_FINAL <- (colegiox$NOTA_CN + colegiox$NOTA_CH +
                          colegiox$NOTA_LC + colegiox$NOTA_MT +
                          colegiox$NOTA_REDACAO) / 5


#ALTERANDO N�MERO PELA RA�A
colegiox$TP_COR_RACA[colegiox$TP_COR_RACA==0] <- "N�o definido"
colegiox$TP_COR_RACA[colegiox$TP_COR_RACA==1] <- "Branca"
colegiox$TP_COR_RACA[colegiox$TP_COR_RACA==2] <- "Preta"
colegiox$TP_COR_RACA[colegiox$TP_COR_RACA==3] <- "Parda"
colegiox$TP_COR_RACA[colegiox$TP_COR_RACA==4] <- "Amarela"
colegiox$TP_COR_RACA[colegiox$TP_COR_RACA==5] <- "Ind�gena"

boxplot(colegiox$NOTA_FINAL ~ colegiox$TP_SEXO:colegiox$TP_COR_RACA)

## Constru��o do modelo para obter os res�duos:
teste_anova <- aov(NOTA_FINAL ~ TP_SEXO*TP_COR_RACA, colegiox)

## Teste de normalidade para os res�duos:
shapiro.test(teste_anova$residuals)

## Verifica��o da presen�a de outliers entre os res�duos:
boxplot(teste_anova$residuals)

## Verifica��o da homogeneidade de vari�ncias - teste de Levene
colegiox$Residuos <- teste_anova$residuals
leveneTest(Residuos ~ TP_SEXO*TP_COR_RACA, colegiox, center = mean)

# TESTE ANOVA DUAS VIAS
# Ho = m�dia dos grupos s�o iguais: p > 0.05
# Ha = H� diferen�a entre pelo menos um dos grupos: p <= 0.05
teste_anova <- aov(NOTA_FINAL ~ TP_SEXO*TP_COR_RACA, colegiox)
Anova(teste_anova, type = 'III') #tipo III soma dos quadrados n�o considera a ordem das vari�veis

# An�lise gr�fica da rela��o entre as vari�veis.
ggplot(colegiox, aes(x = TP_COR_RACA, y = NOTA_FINAL, group = TP_SEXO, color = TP_SEXO)) +
  geom_line(stat = "summary", fun.data = "mean_se", size = 0.6) +
  geom_point(stat = "summary", fun.y = "mean") +
  geom_errorbar(stat = "summary", fun.data = "mean_se", width = 0.2)

# An�lise entre as vari�veis (m�dias marginais)
colegiox %>% group_by(TP_COR_RACA) %>% 
  emmeans_test(NOTA_FINAL ~ TP_SEXO, p.adjust.method = "bonferroni")

# Post-hoc para An�lise detalhada entre as vari�veis
# TukeyHSD
PostHocTest(teste_anova, method = "hsd")

# CONCLUS�O:
# Teste de anova duas vias n�o apontou diferen�a das m�dias das notas, com intervalo
# de confian�a de 95%, com rela��o ao g�nero e a ra�a.
# TP_SEXO: F(1)=0.3250 e p = 0.56965    
# TP_COR_RACA: F(3)=0.2205 e p=0.882    
# TP_SEXO:TP_COR_RACA: F(3)=2.4290 e p=0.06858


#### sensacional  ####
  


