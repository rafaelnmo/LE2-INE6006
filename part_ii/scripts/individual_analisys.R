# ===============================================================
# Script: individual_analisys.R
# Descrição: Análise Exploratória para questões 3 a 8
# Autor: Rafael Oliveira
# Data: 14/04/2025
# ===============================================================

# --- Etapa II: Análise Exploratória ---

# Carregar bibliotecas necessárias
library(dplyr)
library(ggplot2)
library(readr)
library(tidyr)
library(forcats)

ARQUIVO_CORRIGIDO <- "../data/servico_publico_dados_corrigido.csv"

if (file.exists(ARQUIVO_CORRIGIDO)) {
  message("📂 [DEBUG] - Lendo o arquivo de dados: ", ARQUIVO_CORRIGIDO)
  
  # Leitura dos dados corrigidos
  dados <- read.csv(ARQUIVO_CORRIGIDO, stringsAsFactors = FALSE)

  message("\n✅ [DEBUG] - Arquivo lido com sucesso!")
  message("------------------------------------------\n")
} else {
  message("❌ ERRO: Arquivo não encontrado em '", ARQUIVO_CORRIGIDO, "'")
  stop("[DEBUG] - Interrompendo execução: arquivo de dados não existe.")
}


# 3) Análise da variável Região
cat("\n\u25B6\uFE0F [DEBUG] - Análise da variável: Região\n")
regiao_freq <- dados %>% count(Região, sort = TRUE)
print(regiao_freq)

# Gráfico de barras
ggplot(regiao_freq, aes(x = fct_reorder(Região, n), y = n)) +
  geom_bar(stat = "identity", fill = "steelblue") +
  labs(title = "Distribuição de Eleitores por Região", x = "Região", y = "Frequência") +
  theme_minimal() +
  coord_flip()

# 4) Análise da variável Área
cat("\n\u25B6\uFE0F [DEBUG] - Análise da variável: Área\n")
area_freq <- dados %>% count(Área, sort = TRUE)
print(area_freq)

ggplot(area_freq, aes(x = fct_reorder(Área, n), y = n)) +
  geom_bar(stat = "identity", fill = "darkgreen") +
  labs(title = "Preferência por Área Temática", x = "Área", y = "Frequência") +
  theme_minimal() +
  coord_flip()

# 5) Análise da variável Ocupação
cat("\n\u25B6\uFE0F [DEBUG] - Análise da variável: Ocupação\n")
ocup_freq <- dados %>% count(Ocupação, sort = TRUE)
print(ocup_freq)

desempregados <- ocup_freq %>% filter(Ocupação == "Desempregado") %>% pull(n)
perc_desemprego <- round(desempregados / nrow(dados) * 100, 2)
cat("\nPercentual de desempregados:", perc_desemprego, "%\n")

# 6) Análise da variável Opinião
cat("\n\u25B6\uFE0F [DEBUG] - Análise da variável: Opinião\n")
opiniao_freq <- dados %>% count(Opinião, sort = TRUE)
print(opiniao_freq)

ggplot(opiniao_freq, aes(x = fct_reorder(Opinião, n), y = n)) +
  geom_bar(stat = "identity", fill = "orange") +
  labs(title = "Distribuição das Opiniões sobre o Serviço Público", x = "Opinião", y = "Frequência") +
  theme_minimal() +
  coord_flip()

# 7) Análise da variável Renda
cat("\n\u25B6\uFE0F [DEBUG] - Análise da variável: Renda\n")
salario_minimo <- 1  # assumindo que o valor é em salários mínimos

dados$Renda <- as.numeric(dados$Renda)
summary_renda <- summary(dados$Renda)
print(summary_renda)

quantil_75 <- quantile(dados$Renda, 0.75)
perc_abaixo_3sm <- round(sum(dados$Renda < 3) / nrow(dados) * 100, 2)
cat("\nPercentual com renda abaixo de 3 salários mínimos:", perc_abaixo_3sm, "%\n")

ggplot(dados, aes(x = Renda)) +
  geom_histogram(binwidth = 0.5, fill = "purple", color = "white") +
  labs(title = "Distribuição da Renda dos Eleitores", x = "Renda (salários mínimos)", y = "Frequência") +
  theme_minimal()

# 8) Análise da variável Idade
cat("\n\u25B6\uFE0F [DEBUG] - Análise da variável: Idade\n")
summary_idade <- summary(dados$Idade)
print(summary_idade)

jovens <- sum(dados$Idade <= 25)
perc_jovens <- round(jovens / nrow(dados) * 100, 2)
cat("\nPercentual de eleitores com até 25 anos:", perc_jovens, "%\n")

ggplot(dados, aes(x = Idade)) +
  geom_histogram(binwidth = 2, fill = "dodgerblue4", color = "white") +
  labs(title = "Distribuição da Idade dos Eleitores", x = "Idade", y = "Frequência") +
  theme_minimal()
