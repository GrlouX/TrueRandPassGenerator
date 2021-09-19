# Biblioteca com as funções que possibitam a exibição de detalhes e ações subsidiárias ao usuário

# Exibe o menu principal ao usuário
def menu_principal():
	print("\n\t\t%%%%%%%% MENU PRINCIPAL %%%%%%%%")
	opc=input("\nDigite a opção desejada: [1]Ler, [2]Pesquisar, [3]Cadastrar, [4]Sair.\n")
	return opc

#  Informa erro caso a opção escolhida no menu principal não exista
def erro_menu_princ(opc):
	possib=set({"1","2","3","4"})
	if(opc not in possib):
		print("\nOpção inválida!")

# Exibe o menu com as opções de leitura ao usuário
def menu_leitura():
	print("\n\t\t####### MENU DE LEITURA #######")
	opc=input("\nDigite a opção desejada: [1]Frases para ler ou [2]Contar frases e autores.\n")
	return opc

# Exibe o menu com as opções de pesquisa ao usuário
def menu_pesquisa():
	print("\n\t\t####### MENU DE PESQUISA #######")
	opc=input("\nDigite a opção desejada: [1]Pesquisar frase ou [2]Pesquisar autor.\n")
	return opc

# Exibe o menu com as opções de cadastro ao usuário
def menu_cadastro():
	print("\n\t\t####### MENU DE CADASTRO #######")
	opc=input("\nDigite a opção desejada: [1]Cadastrar frase e autor ou [2]Cadastrar poema e autor.\n")
	return opc

# Informa erro caso a opção escolhida em um menu secundário não exista
def erro_menu_sec(opc):
	possib=set({"1","2"})
	if(opc not in possib):
		print("\nOpção inválida!")