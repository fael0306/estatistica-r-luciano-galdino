###########################################
###   CORRELA��O DE SPEARMAN E KENDAL   ###
###########################################

# Testes de correla��o n�o param�tricos

library(dplyr)                                
library(corrplot) # gr�fico de correla��o 
library(ggplot2)
library(ggpubr)


# BUSCAR DIRET�RIO (PASTA COM OS ARQUIVOS)
setwd("C:/Users/Luciano/Desktop/Curso_estatistica_R")

# ABRIR ARQUIVO
enem2019_tratado <- read.csv('enem2019_tratado.csv', sep = ",")

# OBJETIVO:
# ANALISAR A CORRELA��O LINEAR ENTRE AS NOTAS INDIVIDUAIS COM RELA��O
# � NOTA FINAL DO COL�GIO X.

# Criando o dataframe de interesse
colegiox=enem2019_tratado %>% filter(CO_ESCOLA=="35132287")

colegiox$NOTA_FINAL <- (colegiox$NOTA_CN + colegiox$NOTA_CH +
                          colegiox$NOTA_LC + colegiox$NOTA_MT +
                          colegiox$NOTA_REDACAO) / 5


# AN�LISE DA CORRELA��O LINEAR

# TESTE DE NORMALIDADE

# 1o) AN�LISE GR�FICA DA CORRELA��O

plot(colegiox$NOTA_MT, colegiox$NOTA_FINAL)
plot(colegiox$NOTA_LC, colegiox$NOTA_FINAL)
plot(colegiox$NOTA_CH, colegiox$NOTA_FINAL)
plot(colegiox$NOTA_CN, colegiox$NOTA_FINAL)
plot(colegiox$NOTA_REDACAO, colegiox$NOTA_FINAL)

# 2o) NORMALIDADE
# Ho = distribui��o normal : p > 0.05
# Ha = distribui��o != normal : p <= 0.05
shapiro.test(colegiox$NOTA_MT)
shapiro.test(colegiox$NOTA_LC)
shapiro.test(colegiox$NOTA_CH)
shapiro.test(colegiox$NOTA_CN)
shapiro.test(colegiox$NOTA_REDACAO) 
shapiro.test(colegiox$NOTA_FINAL)
# Nota de reda��o n�o passou no teste da normalidade


# CORRELA��O DE SPEARMAN:
cor.test(colegiox$NOTA_REDACAO, colegiox$NOTA_FINAL, method = "spearman")


# CORRELA��O DE KENDALL:
cor.test(colegiox$NOTA_REDACAO, colegiox$NOTA_FINAL, method = "kendall")

# Matrizes de correla��o

matriz_corr <- cor(colegiox[25:26], method = "kendall")
View(matriz_corr)

corrplot(matriz_corr, method="color", 
         type="full", order="original", 
         addCoef.col = "black", # adiciona o coeficiente � matriz
         tl.col="black", tl.srt=45, # cor e rota��o do nome das vari�veis
)

# CONCLUS�O:
# A Correla��o de Spearman indicou uma correla��o moderada e a correla��o 
# de Kendall indicou uma correla��o fraca entre a Nota da Reda��o e a Nota Final.



# REGRESS�O LINEAR

# MODELO DE REGRES�O LINEAR:
modelo_regressao_REDACAO <- lm(NOTA_REDACAO ~ NOTA_FINAL, colegiox)


# AN�LISE DO MODELO DE REGRESS�O
summary(modelo_regressao_REDACAO)
# Ho = COEFICIENTE = 0 : p > 0.05
# Ha = COEFICIENTE != 0 : p <= 0.05 (Modelo de regress�o v�lido)


ggplot(data = colegiox, mapping = aes(x = NOTA_REDACAO, y = NOTA_FINAL)) +
  geom_point() +
  geom_smooth(method = "lm", col = "red") +
  stat_regline_equation(aes(label = paste(..eq.label.., ..adj.rr.label.., sep = "*plain(\",\")~~")),
                        label.x = 0, label.y = 0) +
  theme_classic()


###  SENSACIONAL   ####
