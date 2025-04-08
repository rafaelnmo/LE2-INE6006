# Carregar bibliotecas necessárias
library(dplyr)
library(ggplot2)
library(readr)
library(tidyr)

# Ler a planilha (substitua 'dados.csv' pelo nome real do seu arquivo)
dados <- read_csv2("../data/servico_publico_dados.csv", na = c("", " ", "NA"))

# Verificar estrutura dos dados
str(dados)

# --- 1) Verificar dados ausentes por variável ---
dados_na <- dados %>% summarise_all(~sum(is.na(.)))

# Total de linhas
total_linhas <- nrow(dados)

# Percentual de dados perdidos
percentual_na <- dados_na / total_linhas * 100

# Criar uma tabela com valores absolutos e percentuais
tabela_na <- data.frame(
  Variável = colnames(dados),
  `Valores Ausentes` = as.numeric(dados_na),
  `Percentual (%)` = round(as.numeric(percentual_na), 2)
)

print("Tabela de Dados Ausentes:")
print(tabela_na)

# Gráfico de barras dos dados ausentes
ggplot(tabela_na, aes(x = Variável, y = `Percentual (%)`)) +
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

print("Erros de Registro Detectados:")
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
