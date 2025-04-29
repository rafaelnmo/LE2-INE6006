# Segunda Parte - Análise Individual das variáveis


## Como executar

O projeto utiliza um `Makefile` para automatizar a execução dos scripts em R. Basta rodar os comandos abaixo a partir da raiz do projeto:

### 1. Instalar pacotes necessários
```bash
make install_packages
```
obs.: pode ser necessário usar _sudo_

### 2. Rodar análise preliminar dos dados
```bash
make individual_analisys
```


### 3.  Principais Targets do Makefile

| Target             | Descrição                                                        |
|--------------------|------------------------------------------------------------------|
| `help`             | Mostra todos os comandos disponíveis                             |
| `setup`            | Cria os diretórios necessários para execução                     |
| `install_packages` | Instala os pacotes R usados no projeto                           |
| `individual_analisys`     | Executa o script da análise individual e gera o relatório em PDF |
| `all`              | Executa os passos de instalação e análise de forma completa      |
| `clean`            | Remove arquivos temporários e resets                             |


### 4. Estrutura de Diretórios

```bash
.
├── data/                 # Arquivo de dados corrigido
│   └── servico_publico_dados_corrigido.csv -> ../../part_i/rpt/servico_publico_dados_corrigido.csv
├── logs/                 # Logs de execução dos scripts
│   ├── install_packages.log
│   └── individual_analisys.log
├── rpt/                  # Resultados finais (PDF, tabelas etc.)
│   └── individual_analisys.pdf
├── scripts/              # Scripts R e o Makefile principal
│   ├── install_packages.R
│   ├── Makefile
│   └── individual_analisys.R
└── work/                 # Diretório para controle de execução dos scripts
    └── Makefile -> ../scripts/Makefile
```

### 5. Requisitos
- R (versão 4.0 ou superior)
- GNU Make
- Permissão de escrita nos diretórios do projeto

### 6. Observações
- Todos os logs de execução são salvos automaticamente na pasta logs/.
- Se o script de instalação de pacotes falhar por permissão, edite o script para usar um diretório de bibliotecas local.