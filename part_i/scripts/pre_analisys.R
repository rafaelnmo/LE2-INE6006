# Carregar bibliotecas necessárias
library(dplyr)
library(ggplot2)
library(readr)
library(tidyr)

ARQUIVO_DADOS <- "../data/servico_publico_dados.csv"


if (file.exists(ARQUIVO_DADOS)) {
  message("📂 Lendo o arquivo de dados: ", ARQUIVO_DADOS)
  
  # Leitura com separador correto
  dados <- read.csv(ARQUIVO_DADOS,
                    sep = ",",
                    quote = "\"",
                    stringsAsFactors = FALSE,
                    fileEncoding = "UTF-8")

  message("\n✅ Arquivo lido com sucesso!")
  message("------------------------------------------\n")
} else {
  message("❌ ERRO: Arquivo não encontrado em '", ARQUIVO_DADOS, "'")
  stop("[DEBUG] - Interrompendo execução: arquivo de dados não existe.")
}

# Verificar estrutura dos dados
str(dados)
message("------------------------------------------\n")

# Função para contar ausentes reais ou disfarçados (vazios, espaço, "NA")
contar_ausentes <- function(coluna) {
  sum(is.na(coluna) | trimws(coluna) == "" | trimws(tolower(coluna)) == "na")
}

# Aplica a função a cada coluna
dados_na <- sapply(dados, contar_ausentes)

# Total de linhas
total_linhas <- nrow(dados)

# Percentual de dados ausentes
percentual_na <- round((dados_na / total_linhas) * 100, 2)

# Monta a tabela
tabela_na <- data.frame(
  Variável = names(dados),
  `Valores Ausentes` = dados_na,
  `Percentual` = percentual_na,
  row.names = NULL
)

cat("📊 [DEBUG] - Tabela de Dados Ausentes (Incluindo Vazios e 'NA'):\n\n")
print(tabela_na)

message("------------------------------------------\n")


# Gráfico de barras dos dados ausentes
ggplot(tabela_na, aes(x = Variável, y = `Percentual`)) +
  geom_bar(stat = "identity", fill = "steelblue") +
  labs(title = "Percentual de Dados Ausentes por Variável", y = "Percentual (%)", x = "Variável") +
  theme_minimal()

# --- 2) Verificar erros de registro (valores inesperados) ---

# Listas de categorias válidas para cada variável categórica
regioes_validas <- c("Aquitânia", "Catamarca", "Dalmácia", "Nortúmbria", "Querétaro")
areas_validas <- c("Infraestrutura", "Educação", "Segurança pública", "Saúde pública")
ocupacoes_validas <- c("Desempregado", "Aposentado", "Funcionário público", "Assalariado/Autônomo", "Profissional liberal", "Empresário")
opinioes_validas <- c("Péssimo", "Insatisfatório", "Indiferente", "Satisfatório", "Excelente")

# Função para identificar valores inválidos
valores_invalidos <- function(coluna, valores_validos) {
  unique(dados[[coluna]])[!unique(dados[[coluna]]) %in% valores_validos]
}

# Detectar erros por coluna
erros_registro <- list(
  Região = valores_invalidos("Região", regioes_validas),
  Área = valores_invalidos("Área", areas_validas),
  Ocupação = valores_invalidos("Ocupação", ocupacoes_validas),
  Opinião = valores_invalidos("Opinião", opinioes_validas)
)

print("[DEBUG] - Erros de Registro Detectados:")
print(erros_registro)

# Verificação de Renda e Idade
# Substituir vírgula por ponto em renda e converter para numérico
dados$Renda <- as.numeric(gsub(",", ".", dados$Renda))
# Idade já deve estar como numérico; verificar se há valores inválidos
renda_invalid <- sum(is.na(dados$Renda))
idade_invalid <- sum(dados$Idade < 18 | dados$Idade > 120, na.rm = TRUE)

cat("\nErros numéricos detectados:\n")
cat("Valores inválidos em Renda:", renda_invalid, "\n")
cat("Valores inválidos em Idade (<18 ou >120):", idade_invalid, "\n")
