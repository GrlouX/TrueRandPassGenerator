# Biblioteca com as funções que possibitam as ações do usuário no arquivo de frases

import random # Para gerar dados pseudoaleatórios

def frases_leitura(linhas):
    # Indexa as frases já lidas por meio de um símbolo * à esquerda do seu início
    cont_frases = 0
    ind_frases = set()
    ind_lidas = set()
    for ind, texto in enumerate(linhas):
        if texto[len(texto)-2]=="." or texto[len(texto)-2]=="!" or texto[len(texto)-2]=="?":
            cont_frases += 1
            ind_frases.add((cont_frases, ind)) # Par ordenado que associa cada frase a sua respectiva linha
            if texto[0]=="*":
                ind_lidas.add(cont_frases)
        else:
            if texto[0].lower()==texto[0] and linhas[ind-1]=="\n": # Identifica poemas
                cont_frases += 1
                ind_frases.add((cont_frases, ind))
                if texto[0]=="*":
                    ind_lidas.add(cont_frases)
    print("\nTotal de frases lidas: ",len(ind_lidas))

    # Seleciona frase para ler no dia
    ind_ler = random.choice(tuple({e for e in range(1,cont_frases)}-ind_lidas))
    for par in ind_frases:
        if par[0]==ind_ler:
            print("\n")
            # Controle de fluxo para permitir a impressão completa das frases e dos poemas
            pos = par[1]
            while linhas[pos] != "\n":
                print(linhas[pos])
                pos += 1
                # Reescritura do arquivo de frases com marcação da frase lida
                arquivo = open("arq_frases.txt", "w", encoding="utf8")
                for ind, texto in enumerate(linhas):
                    if ind==par[1]:
                        arquivo.write("*" + texto)
                    else:
                        arquivo.write(texto)
                arquivo.close()
                break
    print("\nFrase",len(ind_lidas)+1,"gerada com sucesso!")

def contar_componentes(linhas):
    cont_frases = 0
    cont_autores = 0
    for ind, texto in enumerate(linhas):
        # Teste dos sinais que marcam fim de frase para incrementar contador de frases 
        if texto[len(texto)-2]=="." or texto[len(texto)-2]=="!" or texto[len(texto)-2]=="?" or texto[0]=="*":
            cont_frases += 1 # O último caracter é sempre uma quebra de linha "\n"
        else:
            # Padrão dos poemas no arquivo: começam com letra minúscula, diferentemente dos nomes próprios dos autores 
            if texto[0].lower()==texto[0] and linhas[ind-1]=="\n":
                cont_frases += 1
            if texto[0].upper()==texto[0] and linhas[ind-1]=="\n":
                cont_autores += 1
    print("\nTotal de frases cadastradas: \n",cont_frases) 
    print("\nTotal de autores cadastrados: \n",cont_autores)

def pesquisar_frase(linhas):
    # Busca expressão indicada em cada frase cadastrada
    exp=input("\nDigite o termo a ser pesquisado nas frases: ")
    cont_fr=0
    cont_pm=0
    for ind, texto in enumerate(linhas):
        if texto[len(texto)-2]=="." or texto[len(texto)-2]=="!" or texto[len(texto)-2]=="?":
            if texto.count(exp)>0:
                cont_fr += 1
                print("\n- Ocorrência",cont_fr,"do termo pesquisado nas frases:")
                print("\n",texto,"( linha",ind,")")
            elif texto[0].lower()==texto[0]:
                if texto.count(exp)>0:
                    cont_pm += 1
                    print("\n- Ocorrência",cont_pm,"do termo pesquisado nos poemas:")
                    print("\n",texto,"( linha",ind,")")
            else:
                continue
    if cont_fr**2+cont_pm**2==0:
        print("\nTermo não encontrado no arquivo.\n")

def pesquisar_autor(linhas):
    # Busca nome indicado em cada autor cadastrado
    nome=input("\nDigite o nome a ser pesquisado entre os autores: ")
    if nome[0]==" ": # Padroniza a pesquisa pelo nome do autor
        nome_aux = nome.lstrip()
        nome = nome_aux
        nome_partes = nome.split(" ")
        nome_aux = ""
        for parte in nome_partes:
            nome_aux = nome_aux + parte[0].upper() + parte[1:] + " " 
        autor = autor_aux.rstrip() # Remove espaço final no nome do autor
    cont_aut=0
    for ind, texto in enumerate(linhas):
        if (texto[len(texto)-2]!="." and texto[len(texto)-2]!="!" and texto[len(texto)-2]!="?") and texto[0].upper()==texto[0]:
            if texto.count(nome)>0:
                cont_aut += 1
                print("\n- Ocorrência",cont_aut,"do nome pesquisado:")
                print("\n",texto,"( linha",ind,")")
    if cont_aut==0:
        print("\nNome não encontrado entre os autores.\n")

def cadastrar_frase():
    frase = input("\nDigite uma nova frase motivacional que deseje cadastrar: ")
    # Teste para averiguar o padrão de cadastro das frases no arquivo
    frase_aux = frase.replace(" ","")
    while frase_aux=="" or (frase[len(frase)-1]!="." and frase[len(frase)-1]!="!" and frase[len(frase)-1]!="?"):
        frase = input("\nDigite uma frase finalizada com '.', '...', '!' ou '?': ")
        frase_aux = frase.replace(" ","")
    if frase[0]==" ":
        frase_aux = frase.lstrip() # Remove espaços iniciais na frase
        frase = frase_aux
    frase_aux = frase[0].upper() + frase[1:] # Padroniza a frase com letra inicial maiúscula
    frase = frase_aux
    # Cadastra a nova frase no arquivo
    arquivo = open("arq_frases.txt", "a", encoding="utf8")
    arquivo.write("\n"*2 + frase)
    autor = input("\nDigite o nome do autor da frase ou aperte enter se não souber: ")
    autor_aux = autor+"."
    # Teste para averiguar características inválidas no nome do autor da frase
    while autor_aux!="." and autor_aux!=autor:
        for caracter in ",.;:!?*$%@+=()[]{}<>\/|_0123456789":
            autor_aux = autor_aux.replace(caracter,"")
        if autor_aux != autor:
            autor = input("\nDigite o nome do autor da frase sem caracteres numéricos ou especiais, nem sinais de pontuação: ")
            autor_aux=autor+"."
    # Cadastra o autor da frase se houver
    if autor.replace(" ","")=="":
        pass
    else:
        if autor[0]==" ":
            autor_aux = autor.lstrip() # Remove espaços iniciais no nome do autor
            autor = autor_aux
            autor_nomes = autor.split(" ")
            autor_aux = ""
        for nome in autor_nomes:
            autor_aux = autor_aux + nome[0].upper() + nome[1:] + " " # Padroniza os nomes do autor com letra inicial maiúscula
        autor = autor_aux.rstrip() # Remove espaço final no nome do autor
        arquivo.write("\n"*2 + autor)
    arquivo.close()

def cadastrar_poema():
    versos = input("\nDigite o número de versos do poema que deseja cadastrar: ")
    # Teste para obter um número válido de versos
    versos_aux = versos.replace(".","")
    while not versos_aux.isnumeric() or versos_aux!=versos or versos_aux=="0":
        versos = input("\nDigite um número inteiro positivo de versos: ")
        versos_aux = versos.replace(".","")
    versos = int(versos)
    estrofe = []
    cont_ver = 0 # Contador de versos do poema
    while(len(estrofe)<versos):
        cont_ver += 1
        novo = input("\nDigite o verso %s do poema: " %(cont_ver))
        novo_aux = novo.replace(" ","")
        # Teste para averiguar o padrão de cadastro dos poemas no arquivo
        while novo_aux=="" or novo[len(novo)-1]=="." or novo[len(novo)-1]=="!" or novo[len(novo)-1]=="?":
            novo = input("\nDigite o verso %s não finalizado com pontuação: " %(cont_ver))
            novo_aux = novo.replace(" ","")
        if novo[0]==" ":
            novo_aux = novo.lstrip() # Remove espaços iniciais no verso
            novo = novo_aux
        novo_aux = novo[0].lower() + novo[1:] # Padroniza o verso com letra inicial minúscula
        novo = novo_aux
        estrofe.append(novo)
    # Cadastra o novo poema no arquivo
    arquivo = open("arq_frases.txt", "a", encoding="utf8")
    arquivo.write("\n")
    for parte in estrofe:
        arquivo.write("\n" + parte)
    autor = input("\nDigite o nome do autor do poema ou aperte enter se não souber: ")
    autor_aux = autor+"."
    # Teste para averiguar características inválidas no nome do autor da frase
    while autor_aux!="." and autor_aux!=autor:
        for caracter in ",.;:!?*$%@+=()[]{}<>\/|_0123456789":
            autor_aux = autor_aux.replace(caracter,"")
        if autor_aux != autor:
            autor = input("\nDigite o nome do autor do poema sem caracteres numéricos ou especiais, nem sinais de pontuação: ")
            autor_aux=autor+"."
    # Cadastra o autor do poema se houver
    if autor.replace(" ","")=="":
        pass
    else:
        if autor[0]==" ":
            autor_aux = autor.lstrip() # Remove espaços iniciais no nome do autor
            autor = autor_aux
        autor_nomes = autor.split(" ")
        autor_aux = ""
        for nome in autor_nomes:
            autor_aux = autor_aux + nome[0].upper() + nome[1:] + " " # Padroniza os nomes do autor com letra inicial maiúscula
        autor = autor_aux.rstrip() # Remove espaço final no nome do autor
        arquivo.write("\n"*2 + autor)
    arquivo.close()