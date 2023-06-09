####################################
###   REGRESS�O LINEAR SIMPLES   ###
####################################


if(!require(dplyr)) install.packages("dplyr")
if(!require(corrplot)) install.packages("corrplot")
if(!require(car)) install.packages("car")
if(!require(ggplot2)) install.packages("ggplot2") #gr�fico com ajuste de reta
if(!require(ggpubr)) install.packages("ggpubr") #equa��o da reta no gr�fico
library(dplyr)                                
library(corrplot) # gr�fico de correla��o 
library(car) # Homocedasticidade (Levene)
library(ggplot2)
library(ggpubr)


# BUSCAR DIRET�RIO (PASTA COM OS ARQUIVOS)
setwd("C:/Users/Luciano/Desktop/Curso_estatistica_R")

#ABRIR ARQUIVO
enem2019_tratado <- read.csv('enem2019_tratado.csv', sep = ",")

#Criando o dataframe de interesse
colegiox <- enem2019_tratado %>% filter (CO_ESCOLA=="35132287")


colegiox$NOTA_FINAL <- (colegiox$NOTA_CN + colegiox$NOTA_CH +
                          colegiox$NOTA_LC + colegiox$NOTA_MT +
                          colegiox$NOTA_REDACAO) / 5


# AN�LISE DA CORRELA��O LINEAR

# DADOS NUM�RICOS NORMALIZADOS: CORRELA��O DE PEARSON

# 1o) AN�LISE GR�FICA DA CORRELA��O

plot(colegiox$NOTA_MT, colegiox$NOTA_FINAL)
plot(colegiox$NOTA_LC, colegiox$NOTA_FINAL)
plot(colegiox$NOTA_CH, colegiox$NOTA_FINAL)
plot(colegiox$NOTA_CN, colegiox$NOTA_FINAL)
plot(colegiox$NOTA_REDACAO, colegiox$NOTA_FINAL)

# 2o) NORMALIDADE
#Ho = distribui��o normal : p > 0.05
#Ha = distribui��o != normal : p <= 0.05
shapiro.test(colegiox$NOTA_MT)
shapiro.test(colegiox$NOTA_LC)
shapiro.test(colegiox$NOTA_CH)
shapiro.test(colegiox$NOTA_CN)
shapiro.test(colegiox$NOTA_REDACAO) 
shapiro.test(colegiox$NOTA_FINAL)
# Nota de reda��o n�o passou no teste da normalidade

# 3o) AN�LISE DE OUTLIERS
boxplot(colegiox$NOTA_MT)
boxplot(colegiox$NOTA_LC)
boxplot(colegiox$NOTA_CN)
boxplot(colegiox$NOTA_CH)
boxplot(colegiox$NOTA_FINAL)

# Gr�fico para verifica��o dos res�duos (valor previsto - valor esperado)

# MODELO DE REGRES�O LINEAR:
modelo_regressao_MT <- lm(NOTA_MT ~ NOTA_FINAL, colegiox)
## An�lise gr�fica:
plot(modelo_regressao_MT, , which=c(1, 2)) # vai plotar os gr�ficos 1 e 2 da fun��o.

modelo_regressao_LC <- lm(NOTA_LC ~ NOTA_FINAL, colegiox)
## An�lise gr�fica:
plot(modelo_regressao_LC, which=c(1, 2))
# Outlier interferindo

modelo_regressao_CN <- lm(NOTA_CN ~ NOTA_FINAL, colegiox)
# An�lise gr�fica:
plot(modelo_regressao_CN, which=c(1, 2))

modelo_regressao_CH <- lm(NOTA_CH ~ NOTA_FINAL, colegiox)
# An�lise gr�fica:
plot(modelo_regressao_CH, which=c(1, 2))



# Correla��o Linear de Pearson:
# Ho = n�o h� corrrela��o linear: p > 0,05
# Ha = existe correla��o linear: p <= 0,05
cor.test(colegiox$NOTA_MT, colegiox$NOTA_FINAL, method = "pearson")
cor.test(colegiox$NOTA_LC, colegiox$NOTA_FINAL, method = "pearson")
cor.test(colegiox$NOTA_CN, colegiox$NOTA_FINAL, method = "pearson")
cor.test(colegiox$NOTA_CH, colegiox$NOTA_FINAL, method = "pearson")

# Matrizes de correla��o
#Alterando posi��o da coluna NOTA_FINAL
colegiox <- colegiox %>% relocate(NOTA_FINAL, .after = NOTA_MT)

matriz_corr <- cor(colegiox[14:18], method = "pearson")
View(matriz_corr)

corrplot(matriz_corr, method = "color")

corrplot(matriz_corr, method="color", 
         type="full", order="original", 
         addCoef.col = "black", # adiciona o coeficiente � matriz
         tl.col="black", tl.srt=45, # cor e rota��o do nome das vari�veis
)






# REGRESS�O LINEAR


# MODELO DE REGRES�O LINEAR:
modelo_regressao_MT <- lm(NOTA_MT ~ NOTA_FINAL, colegiox)

modelo_regressao_LC <- lm(NOTA_LC ~ NOTA_FINAL, colegiox)

modelo_regressao_CN <- lm(NOTA_CN ~ NOTA_FINAL, colegiox)

modelo_regressao_CH <- lm(NOTA_CH ~ NOTA_FINAL, colegiox)

# NORMALIDADE DOS RES�DUOS
#Ho = distribui��o normal : p > 0.05
#Ha = distribui��o != normal : p <= 0.05
shapiro.test(modelo_regressao_MT$residuals)
shapiro.test(modelo_regressao_LC$residuals)
shapiro.test(modelo_regressao_CN$residuals)
shapiro.test(modelo_regressao_CH$residuals)

# Matem�tica e Ci�ncias Naturais: reprovadas no teste da normalidade dos res�duos.

# AN�LISE DO MODELO DE REGRESS�O
summary(modelo_regressao_MT)
# Ho = COEFICIENTE = 0 : p > 0.05
# Ha = COEFICIENTE != 0 : p <= 0.05 (Modelo de regress�o v�lido)


ggplot(data = colegiox, mapping = aes(x = NOTA_MT, y = NOTA_FINAL)) +
  geom_point() +
  geom_smooth(method = "lm", col = "red") +
  stat_regline_equation(aes(label = paste(..eq.label.., ..adj.rr.label.., sep = "*plain(\",\")~~")),
                        label.x = 0, label.y = 0) +
  theme_classic()




summary(modelo_regressao_LC)
# Ho = COEFICIENTE = 0 : p > 0.05
# Ha = COEFICIENTE != 0 : p <= 0.05 (Modelo de regress�o v�lido)


ggplot(data = colegiox, mapping = aes(x = NOTA_LC, y = NOTA_FINAL)) +
  geom_point() +
  geom_smooth(method = "lm", col = "red") +
  stat_regline_equation(aes(label = paste(..eq.label.., ..adj.rr.label.., sep = "*plain(\",\")~~")),
                        label.x = 0, label.y = 0) +
  theme_classic()



summary(modelo_regressao_CN)
# Ho = COEFICIENTE = 0 : p > 0.05
# Ha = COEFICIENTE != 0 : p <= 0.05 (Modelo de regress�o v�lido)


ggplot(data = colegiox, mapping = aes(x = NOTA_CN, y = NOTA_FINAL)) +
  geom_point() +
  geom_smooth(method = "lm", col = "red") +
  stat_regline_equation(aes(label = paste(..eq.label.., ..adj.rr.label.., sep = "*plain(\",\")~~")),
                        label.x = 0, label.y = 0) +
  theme_classic()



summary(modelo_regressao_CH)
# Ho = COEFICIENTE = 0 : p > 0.05
# Ha = COEFICIENTE != 0 : p <= 0.05 (Modelo de regress�o v�lido)


ggplot(data = colegiox, mapping = aes(x = NOTA_CH, y = NOTA_FINAL)) +
  geom_point() +
  geom_smooth(method = "lm", col = "red") +
  stat_regline_equation(aes(label = paste(..eq.label.., ..adj.rr.label.., sep = "*plain(\",\")~~")),
                        label.x = 0, label.y = 0) +
  theme_classic()

