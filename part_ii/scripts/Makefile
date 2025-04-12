# ------------------------------------------------------------------------------
# Makefile para Análise Individual da Pesquisa ENGABELAX - Pindorama
#
# Autor: Rafael Oliveira
# Data de Criação: 12/04/2025
# Última Modificação: 12/04/2025
# Versão: 1.1.0
#
# Descrição:
#   Este Makefile automatiza a instalação de pacotes e execução do script
#   de análise individual em R sobre os dados corrigidos da pesquisa.
#
# Histórico de Versões:
#   v1.1.0 - 12/04/2025 - Adicionado target 'individual_analisys' com geração de PDF
#   v1.0.0 - 08/04/2025 - Versão base com targets: help, install_packages, all
# ------------------------------------------------------------------------------



################################################
## Definição de Variáveis
################################################
VPATH=make

REPORTS_DIR=../rpt
SCRIPTS_DIR=../scripts
LOGS_DIR=../logs
RPT_DIR=../rpt


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
	@mkdir -p $(RPT_DIR)
	@/bin/touch $(VPATH)/$@


# Instala pacotes R necessários
install_packages: setup
	Rscript $(SCRIPTS_DIR)/$@.R | tee $(LOGS_DIR)/$@.log;
	@/bin/touch $(VPATH)/$@ 


# Executa o script principal
individual_analisys: install_packages
	Rscript $(SCRIPTS_DIR)/$@.R | tee $(LOGS_DIR)/$@.log;
	@/bin/touch $(VPATH)/$@ 
	@mv Rplots.pdf $(RPT_DIR)/$@.pdf

# Faz tudo: instala e executa
all: install_packages pre_analisys

clean: 
	ls ../work | grep -v Makefile | xargs rm -rf