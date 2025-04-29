# Lista de pacotes necessários
packages <- c("mvtnorm","janitor", "ggplot2", "ggmosaic")

# Instala somente os que ainda não estão instalados
installed <- packages %in% rownames(installed.packages())
if (any(!installed)) {
  install.packages(packages[!installed])
}

# Carrega todos os pacotes
lapply(packages, library, character.only = TRUE)
