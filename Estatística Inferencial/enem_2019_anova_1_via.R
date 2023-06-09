############################
###   ANOVA de uma via   ###
############################

if(!require(dplyr)) install.packages("dplyr")
if(!require(rstatix)) install.packages("rstatix")
if(!require(DescTools)) install.packages("DescTools") 
library(DescTools) # Teste Post-Hoc
library(dplyr)
library(rstatix)


# BUSCAR DIRET�RIO (PASTA COM OS ARQUIVOS)
setwd("C:/Users/Luciano/Desktop/Curso_estatistica_R")

#ABRIR ARQUIVO
enem2019_tratado <- read.csv('enem2019_tratado.csv', sep = ",")

# OBJETIVO
# ANALISAR SE H� DIFEREN�A DE NOTA COM RELA��O � RA�A

colegiox <- enem2019_tratado %>% filter (CO_ESCOLA=="35132287")
str(colegiox)

colegiox$NOTA_FINAL <- (colegiox$NOTA_CN + colegiox$NOTA_CH +
                          colegiox$NOTA_LC + colegiox$NOTA_MT +
                          colegiox$NOTA_REDACAO) / 5
str(colegiox)



#ALTERANDO N�MERO PELA RA�A
colegiox$TP_COR_RACA[colegiox$TP_COR_RACA==0] <- "N�o definido"
colegiox$TP_COR_RACA[colegiox$TP_COR_RACA==1] <- "Branca"
colegiox$TP_COR_RACA[colegiox$TP_COR_RACA==2] <- "Preta"
colegiox$TP_COR_RACA[colegiox$TP_COR_RACA==3] <- "Parda"
colegiox$TP_COR_RACA[colegiox$TP_COR_RACA==4] <- "Amarela"
colegiox$TP_COR_RACA[colegiox$TP_COR_RACA==5] <- "Ind�gena"

str(colegiox)

# Quantidades
branca = colegiox %>% filter(TP_COR_RACA=="Branca")
amarela = colegiox %>% filter(TP_COR_RACA=="Amarela")
preta = colegiox %>% filter(TP_COR_RACA=="Preta")
parda = colegiox %>% filter(TP_COR_RACA=="Parda")
indigena = colegiox %>% filter(TP_COR_RACA=="Ind�gena")
nd = colegiox %>% filter(TP_COR_RACA=="N�o definido")

##### VERIFICA��O DOS PRESSUPOSTOS #######
# Constru��o do modelo para obter os res�duos:
teste_anova <- aov(NOTA_FINAL ~ TP_COR_RACA, colegiox)

# Teste de normalidade para os res�duos:
shapiro.test(teste_anova$residuals)

# Verifica��o da presen�a de outliers entre os res�duos:
boxplot(teste_anova$residuals)


#######    TESTE ANOVA  ######
#Ho = m�dia dos grupos s�o iguais: p > 0.05
#Ha = H� diferen�a entre pelo menos um dos grupos: p <= 0.05
teste_anova <- aov(NOTA_FINAL ~ TP_COR_RACA, colegiox)
summary(teste_anova)


# An�lise post-hoc : Verifica quais grupos s�o diferentes, se houver
# H� mais de um tipo de teste, mais utilizados:

# Post-hoc Duncan (Mais flex�vel)
PostHocTest(teste_anova, method = "duncan", conf.level =0.95)
# Pos-hoc TukeyHSD (Mais regular)
PostHocTest(teste_anova, method = "hsd")
# Pos-hoc Bonferroni(Mais conservador)
PostHocTest(teste_anova, method = "bonf")

summary(colegiox$NOTA_FINAL)

#Conclus�o:
# N�o h� diferen�a entre as m�dias conforme a Cor/Ra�a, segundo teste anova 1 via.
# F(3) = 1.261 e p_valor = 0.291



