###################################################
# TESTE DE MANN-WHITNEY (SOMA DE POSTOS WILCOXON) #
###################################################

if(!require(dplyr)) install.packages("dplyr")
if(!require(RVAideMemoire)) install.packages ("RVAideMemoire")
if(!require(rstatix)) install.packages("rstatix") 


library(rstatix)  
library(dplyr) 
library(RVAideMemoire) # Teste Shapiro por grupo

# BUSCAR DIRET�RIO (PASTA COM OS ARQUIVOS)
setwd("C:/Users/Luciano/Desktop/Curso_estatistica_R")

#ABRIR ARQUIVO
enem2019_tratado <- read.csv('enem2019_tratado.csv', sep = ",")

#Criando o dataframe de interesse
enem_bauru = enem2019_tratado[which(enem2019_tratado$NO_MUNICIPIO_RESIDENCIA=="Bauru"),]

# NORMALIDADE
# Ho = distribui��o normal : p > 0.05
# Ha = distribui��o n�o � normal : p <= 0.05

byf.shapiro(NOTA_CN ~ TP_SEXO, enem_bauru)
byf.shapiro(NOTA_CH ~ TP_SEXO, enem_bauru)
byf.shapiro(NOTA_LC ~ TP_SEXO, enem_bauru)
byf.shapiro(NOTA_MT ~ TP_SEXO, enem_bauru)
byf.shapiro(NOTA_REDACAO ~ TP_SEXO, enem_bauru)


# TESTE DE MANN-WHITNEY (SOMA DE POSTOS WILCOXON)
# Ho = mediana entre homens e mulheres s�o iguais : p > 0.05
# Ha = mediana entre homens e mulheres s�o diferentes : p <= 0.05
wilcox.test(NOTA_CN ~ TP_SEXO, data = enem_bauru)
wilcox.test(NOTA_CH ~ TP_SEXO, data = enem_bauru)
wilcox.test(NOTA_LC ~ TP_SEXO, data = enem_bauru)
wilcox.test(NOTA_MT ~ TP_SEXO, data = enem_bauru)
wilcox.test(NOTA_REDACAO ~ TP_SEXO, data = enem_bauru)


# AN�LISE DESCRITIVA
enem_bauru %>% group_by(TP_SEXO) %>% 
  get_summary_stats(NOTA_CN, NOTA_CH, NOTA_LC, NOTA_MT, NOTA_REDACAO, type = "median_iqr")


par(mfrow=c(1,5))
boxplot(NOTA_REDACAO ~ TP_SEXO, enem_bauru, ylab="Notas Reda��o", xlab="G�nero")
boxplot(NOTA_LC ~ TP_SEXO, enem_bauru, ylab="Notas Linguagens e C�digos", xlab="G�nero")
boxplot(NOTA_CN ~ TP_SEXO, enem_bauru, ylab="Notas Ci�ncias Naturais", xlab="G�nero")
boxplot(NOTA_CH ~ TP_SEXO, enem_bauru, ylab="Notas Ci�ncias Humanas", xlab="G�nero")
boxplot(NOTA_MT ~ TP_SEXO, enem_bauru, ylab="Notas Matem�tica", xlab="G�nero")

# CONCLUS�O:
# PELO TESTE DE MANN-WHITNEY, SOMENTE AS MEDIANAS/DISTRIBUI��ES DAS NOTAS DE LINGUAGENS E C�DIGOS
# ENTRE HOMENS E MULHERES S�O ESTATISTICAMENTE IGUAIS, COM W=2079299 e p=0.3169.

