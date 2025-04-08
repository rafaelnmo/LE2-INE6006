# ------------------------------------------------------------------------------
# Makefile para Análise de Dados da Pesquisa ENGABELAX - Pindorama
#
# Autor: Rafael Oliveira
# Data de Criação: 08/04/2025
# Última Modificação: 08/04/2025
# Versão: 1.0.0
#
# Descrição:
#   Este Makefile automatiza o processo de instalação de pacotes e execução
#   do script de análise em R para a base de dados da pesquisa de opinião.
#
# Histórico de Versões:
#   v0.0.1 - 08/04/2025 - Criação inicial do Makefile com targets:
#              help, install, run, all
# ------------------------------------------------------------------------------


################################################
## Definição de Variáveis
################################################
VPATH=make

REPORTS_DIR=../rpt
SCRIPTS_DIR=../scripts
LOGS_DIR=../logs
DBS_DIR=../dbs


# Mostra os comandos disponíveis
help:
	@echo "=========================================================="
	@echo "                  Targets Disponiveis                     "
	@echo "=========================================================="
	@echo "         help     : Exibe esta mensagem de ajuda          "
	@echo "      install     : Instala os pacotes R necessários       "
	@echo "         run      : Executa o script principal (R)         "
	@echo "         all      : Executa install e run                  "
	@echo "----------------------------------------------------------"
	@echo "         clean    : Remove arquivos temporários (se houver)"
	@echo "=========================================================="
	@echo "                  Opções do Makefile                  "
	@echo "=========================================================="
	@echo "     ARGS         : Argumentos para o Rscript (default: vazio)"
	@echo "     SCRIPT       : Script principal (default: meu_script.R)  "
	@echo "     PACOTES      : Lista de pacotes R usados                 "
	@echo "=========================================================="

.PHONY: help

setup:
	@/bin/mkdir -p $(VPATH)
	@mkdir -p $(REPORTS_DIR)
	@mkdir -p $(LOGS_DIR)
	@mkdir -p $(DBS_DIR)
	@/bin/touch $(VPATH)/$@


# Instala pacotes R necessários
install_packages: setup
	Rscript $(SCRIPTS_DIR)/$@.R > $(LOGS_DIR)/$@.log;
	@/bin/touch $(VPATH)/$@ 


# Executa o script principal
pre_analisys: install_packages
	Rscript $(SCRIPTS_DIR)/$@.R 
	@/bin/touch $(VPATH)/$@ 
	@mv Rplots.pdf $(DBS_DIR)/pre_analisys.pdf

# Faz tudo: instala e executa
all: install_packages pre_analisys

clean: 
	ls ../work | grep -v Makefile | xargs rm -rf