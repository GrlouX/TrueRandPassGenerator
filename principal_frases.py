# Código principal para gerenciar as ações sobre o arquivo de frases

# Importação das funções utilizadas das bibliotecas de funcionalidades e de adicionais
from funcionalidades_frases import frases_leitura as frleit, contar_componentes as contfraut , \
    pesquisar_frase as pesqfr, pesquisar_autor as pesqaut, cadastrar_frase as cadfr, \
    cadastrar_poema as cadpm
from adicionais_frases import menu_principal as mnprinc, menu_leitura as mnleit, menu_pesquisa as mnpesq, \
    menu_principal as mnprinc, menu_cadastro as mncad, erro_menu_princ as errmnprinc, erro_menu_sec as errmnsec

# Ler as linhas do arquivo de frases com a codificação de caracteres UTF-8
linhas = open("arq_frases.txt", encoding="utf8").readlines()

print("\n\t\t-_*_- FRASE DO DIA COM O PY -_*_-")
print("\nOlá! Seja bem-vinda(o) ao PY!") # Lêia-se PY="PAI"!
#listas=[]
#cont=0
opc=[None,None,None,None]
opc[0]=mnprinc()
while(opc[0] != "4"):
        errmnprinc(opc[0])
        if(opc[0]=="1"):
                opc[1]=mnleit()
                errmnsec(opc[1])
                if(opc[1]=="1"):
                        frleit(linhas)
                elif(opc[1]=="2"):
                        contfraut(linhas)
                else:
                        exit
        if(opc[0]=="2"):
                opc[2]=mnpesq()
                errmnsec(opc[2])
                if(opc[2]=="1"):
                        pesqfr(linhas)
                elif(opc[2]=="2"):
                        pesqaut(linhas)
                else:
                        exit
        if(opc[0]=="3"):
                opc[3]=mncad()
                errmnsec(opc[3])
                if(opc[3]=="1"):
                        cadfr()
                elif(opc[3]=="2"):
                        cadpm()
                else:
                        exit
        opc[0]=mnprinc()
print("."*50)
print("\nObrigado por consultar o PY! Falou!")
print("."*50)