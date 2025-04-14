# ===============================================================
# Script: double_variables.R
# Descrição: Análise individual de variáveis cruzadas para questões 9 a 14
# Autor: Rafael Oliveira
# Data: 14/04/2025
# ===============================================================

# Pacotes necessários
library(tidyverse)
library(janitor)
# library(ggpubr)
library(ggplot2)
library(ggmosaic)

# Carregar os dados limpos
# dados <- read.csv("../data/servico_publico_dados_corrigido.csv")


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


# Garantir consistência de categorias
dados <- dados %>%
  mutate(across(where(is.character), as.factor))

# 9) "O que é considerado mais importante no serviço público pelos eleitores geralmente tem a pior avaliação"
cat("\n\u25B6\uFE0F [DEBUG] - Questão 9 - Importância vs. Opinião\n")

# Cruzamento: Área x Opinião
tab_area_opiniao <- table(dados$Área, dados$Opinião)
print(tab_area_opiniao)

# Visualização
ggplot(dados, aes(x = Área, fill = Opinião)) +
  geom_bar(position = "fill") +
  scale_y_continuous(labels = scales::percent) +
  labs(title = "Opinião sobre o Serviço Público por Área considerada mais importante",
       y = "Percentual", x = "Área") +
  theme_minimal()


# 10) "Empresários -> Infraestrutura e Segurança, Assalariados -> Educação"
cat("\n\u25B6\uFE0F [DEBUG] - Questão 10 - Ocupação vs. Área considerada mais importante\n")

# Tabela cruzada
tab_ocup_area <- table(dados$Ocupação, dados$Área)
print(tab_ocup_area)

# Visualização
ggplot(dados, aes(x = Ocupação, fill = Área)) +
  geom_bar(position = "fill") +
  coord_flip() +
  scale_y_continuous(labels = scales::percent) +
  labs(title = "Área mais importante por ocupação", y = "Percentual", x = "Ocupação") +
  theme_minimal()


# 11) Relação entre Ocupação e Opinião
cat("\n\u25B6\uFE0F [DEBUG] - Questão 11 - Ocupação vs. Opinião sobre o serviço público\n")

tab_ocup_opiniao <- table(dados$Ocupação, dados$Opinião)
print(tab_ocup_opiniao)

# Teste Qui-quadrado
chisq_result_q11 <- chisq.test(tab_ocup_opiniao)
print(chisq_result_q11)

# 12) Área considerada mais importante por região
cat("\n\u25B6\uFE0F [DEBUG] - Questão 12 - Área considerada mais importante por Região\n")

tab_regiao_area <- table(dados$Região, dados$Área)
print(tab_regiao_area)

# Visualização
ggplot(dados, aes(x = Região, fill = Área)) +
  geom_bar(position = "fill") +
  scale_y_continuous(labels = scales::percent) +
  labs(title = "Distribuição da Área mais importante por Região",
       y = "Percentual", x = "Região") +
  theme_minimal()


# 13) Relação entre Renda e Opinião (agrupando renda)
cat("\n\u25B6\uFE0F [DEBUG] - Questão 13 - Renda vs. Opinião\n")

# Categorizar renda
dados$renda_cat <- cut(dados$Renda,
                       breaks = c(-Inf, 1.5, 3, 6, Inf),
                       labels = c("Até 1.5 SM", "1.6 a 3 SM", "3.1 a 6 SM", "Mais de 6 SM"))

tab_renda_opiniao <- table(dados$renda_cat, dados$Opinião)
print(tab_renda_opiniao)

# Teste Qui-quadrado
chisq_result_q13 <- chisq.test(tab_renda_opiniao)
print(chisq_result_q13)


# 14) Relação entre idade e opinião
cat("\n\u25B6\uFE0F [DEBUG] - Questão 14 - Idade vs. Opinião\n")

# Faixas etárias
dados$idade_cat <- cut(dados$Idade,
                       breaks = c(17, 25, 40, 60, Inf),
                       labels = c("Até 25", "26-40", "41-60", "60+"))

tab_idade_opiniao <- table(dados$idade_cat, dados$Opinião)
print(tab_idade_opiniao)

# Teste Qui-quadrado
chisq_result_q14 <- chisq.test(tab_idade_opiniao)
print(chisq_result_q14)

# Gráfico de apoio
ggplot(dados, aes(x = idade_cat, fill = Opinião)) +
  geom_bar(position = "fill") +
  scale_y_continuous(labels = scales::percent) +
  labs(title = "Opinião sobre o serviço público por faixa etária",
       y = "Percentual", x = "Faixa Etária") +
  theme_minimal()

