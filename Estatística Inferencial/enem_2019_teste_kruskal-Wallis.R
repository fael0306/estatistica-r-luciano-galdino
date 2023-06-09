###################################
###   TESTE DE KRUSKAL_WALLIS   ###
###################################

# Teste n�o param�trico para mais de duas amostras (similar ao Anova)

library(dplyr)
library(rstatix)
library(DescTools)
library(nortest)

# BUSCAR DIRET�RIO (PASTA COM OS ARQUIVOS)
setwd("C:/Users/Luciano/Desktop/Curso_estatistica_R")

#ABRIR ARQUIVO
enem2019_tratado <- read.csv('enem2019_tratado.csv', sep = ",")

# OBJETIVO
# ANALISAR SE H� DIFEREN�A DE NOTA COM RELA��O � RA�A

enem2019_tratado$NOTA_FINAL <- (enem2019_tratado$NOTA_CN + enem2019_tratado$NOTA_CH +
                          enem2019_tratado$NOTA_LC + enem2019_tratado$NOTA_MT +
                          enem2019_tratado$NOTA_REDACAO) / 5
str(enem2019_tratado)

#ALTERANDO N�MERO PELA RA�A
enem2019_tratado$TP_COR_RACA[enem2019_tratado$TP_COR_RACA==0] <- "N�o definido"
enem2019_tratado$TP_COR_RACA[enem2019_tratado$TP_COR_RACA==1] <- "Branca"
enem2019_tratado$TP_COR_RACA[enem2019_tratado$TP_COR_RACA==2] <- "Preta"
enem2019_tratado$TP_COR_RACA[enem2019_tratado$TP_COR_RACA==3] <- "Parda"
enem2019_tratado$TP_COR_RACA[enem2019_tratado$TP_COR_RACA==4] <- "Amarela"
enem2019_tratado$TP_COR_RACA[enem2019_tratado$TP_COR_RACA==5] <- "Ind�gena"

str(enem2019_tratado)

# Quantidades
branca = enem2019_tratado %>% filter(TP_COR_RACA=="Branca")
amarela = enem2019_tratado %>% filter(TP_COR_RACA=="Amarela")
preta = enem2019_tratado %>% filter(TP_COR_RACA=="Preta")
parda = enem2019_tratado %>% filter(TP_COR_RACA=="Parda")
indigena = enem2019_tratado %>% filter(TP_COR_RACA=="Ind�gena")
nd = enem2019_tratado %>% filter(TP_COR_RACA=="N�o definido")

##### VERIFICA��O DOS PRESSUPOSTOS #######
# NORMALIDADE
# Ho = distribui��o normal : p > 0.05
# Ha = distribui��o != normal : p <= 0.05
# Constru��o do modelo para obter os res�duos:
teste_anova <- aov(NOTA_FINAL ~ TP_COR_RACA, enem2019_tratado)
# Teste de normalidade para os res�duos:

#Lilliefors (Kolmogorov-Smirnov)
lillie.test(teste_anova$residuals)

# REPROVADO NO TESTE DE NORMALIDADE, TER� QUE SER REALIZADO UM TESTE N�O PARAM�TRICO.
# COMO S�O MAIS DE DUAS VARI�VEIS INDEPENDENTES, ENT�O O TESTE SER� O KRUSKAL-WALLIS


# TESTE DE KRUSKAL-WALLIS
# Ho = mediana dos grupos s�o iguais: p > 0.05
# Ha = H� diferen�a das medianas pelo menos em um dos grupos: p <= 0.05
kruskal.test(NOTA_FINAL ~ TP_COR_RACA, data = enem2019_tratado)


# TESTE DE POS-HOC PARA VERIFICAR QUAIS S�O AS DIFEREN�AS
# TESTE DUNN � O RECOMENDADO
dunn_test(NOTA_FINAL ~ TP_COR_RACA, data = enem2019_tratado, p.adjust.method = "bonferroni")

# An�lise descritiva
enem2019_tratado %>% group_by(TP_COR_RACA) %>% get_summary_stats(NOTA_FINAL, type = "median_iqr")


# CONCLUS�O:
# PELO TESTE DE KRUSKAL-WALLIS, AS NOTAS FINAIS NO ENEM, ESTATISTICAMENTE, 
# N�O S�O IGUAIS POR RA�A. 


