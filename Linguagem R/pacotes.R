#######################################################
###    INSTALA��O E CARREGAMENTO DE PACOTES NO R    ###
#######################################################

# O R possui pacotes b�sicos j� baixados e carregados.
# Tem pacotes j� baixados, mas que devem ser carregados (pacotes recomendados).
# Possui pacotes para serem baixados e carregados (pacotes contribu�dos).

# http://cran.rstudio.com/

# BAIXAR PACOTES, CASO ELES AINDA N�O ESTEJAM BAIXADOS
install.packages("argo") 

# CARREGAR PACOTES
library(argo)

?argo

# BAIXAR PACOTES, CASO ELES AINDA N�O ESTEJAM BAIXADOS
if(!require(argo)) install.packages("argo") 

# CARREGAR PACOTES
library(argo)

# REMOVER PACOTES
remove.packages("argo")




