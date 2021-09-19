# Análise exploratória dos dados sobre a massa de rendimento real do trabalho

# Carregamento dos pacotes necessários

library(dplyr) #Manipulação de dados
library(tidyr) #Transformação de dados
library(stringr) #Manipulação de cadeias de caracteres
library(ggplot2) #Ferramentas gráficas
library(sidrar) #Conexão com a plataforma de dados SIDRA do IBGE
library(e1071) #Medidas descritivas adicionais

# Filtros da tabela de dados

#1) Variável: Massa de rendimento real efetivo dos trabalhadores (milhões R$).
#2) Todos os períodos disponíveis: 1º trimestre de 2012 ao 2º trimestre de 2021.    
#3) Unidades territoriais: Brasil e cada uma das 5 macrorregiões do país.

# Obtenção via API e pré-processamento dos dados

dados <- get_sidra(api = '/t/5606/n1/all/n2/all/v/6295/p/all')
glimpse(dados) # Descrição das variáveis presentes no conjunto de dados

dados <- dados %>% mutate(
                          Local = `Brasil e Grande Região`,
                          Rendimento = Valor,
                          Periodo = `Trimestre (Código)`
                          )
dados <- dados %>% dplyr::select(12:14)
dados <- dados %>% mutate_at(vars(Ano=Periodo), str_sub, 1, 4) %>%
                   mutate_at(vars(Trimestre=Periodo), str_sub, -1)
head(dados) # Primeiras linhas dos dados com as variáveis de interesse

# Estatísticas descritivas dos dados

str(dados) # Dados estruturados em 228 observações (38 trimestres em cada local)
colSums(is.na(dados)) # Não há dados faltantes no período analisado

#Dados segmentados por local
dados_BR <- dados[1:38,2]
summary(dados_BR) #Brasil
dados_N <- dados[39:76,2]
summary(dados_N) #Norte
dados_NE <- dados[77:114,2]
summary(dados_NE) #Nordeste
dados_SE <- dados[115:152,2]
summary(dados_SE) #Sudeste
dados_S <- dados[153:190,2]
summary(dados_S) #Sul
dados_CO <- dados[191:228,2]
summary(dados_CO) #Centro-Oeste

# Visualizações iniciais dos dados

#Histogramas por local
par(mfrow=c(2,3))
hist(dados_BR, main="Histograma dos rendimentos no Brasil", xlab="Rendimentos",
     ylab="Densidadade de frequência", prob=T)
hist(dados_N, main="Histograma dos rendimentos no Norte", xlab="Rendimentos",
     ylab="Densidadade de frequência", prob=T)
hist(dados_NE, main="Histograma dos rendimentos no Nordeste", xlab="Rendimentos",
     ylab="Densidadade de frequência", prob=T)
hist(dados_SE, main="Histograma dos rendimentos no Sudeste", xlab="Rendimentos",
     ylab="Densidadade de frequência", prob=T)
hist(dados_S, main="Histograma dos rendimentos no Sul", xlab="Rendimentos",
     ylab="Densidadade de frequência", prob=T)
hist(dados_CO, main="Histograma dos rendimentos no Centro-Oeste", xlab="Rendimentos",
     ylab="Densidadade de frequência", prob=T)

#Uma análise rápida dos histogramas sugere distribuições assimétricas de renda.
#Peso caudal à direita para o Brasil e todas as regiões, exceto o Nordeste.
#Visão corroborada pela medida do coeficiente de assimetria nas distribuições.

skewness(dados_BR)
skewness(dados_N)
skewness(dados_NE) # Valor<0 sugere peso significativo dos baixos rendimentos no período em análise
skewness(dados_SE)
skewness(dados_S)
skewness(dados_CO)

#Boxplots por local
dados %>% dplyr::select(Local,Rendimento) %>% filter(Local!="Brasil") %>% group_by(Local) %>%
  ggplot(aes(as.factor(Local),Rendimento)) + ggtitle("Boxplots das massas de rendimento") +
  geom_boxplot(coef=3) + geom_jitter(width = 0.1, alpha = 0.2) + xlab("Macrorregião brasileira") +
  scale_y_continuous(name="Massa de rendimento (em milhões de R$)", breaks = c(10000, 30000, 50000, 70000, 90000, 110000, 130000, 150000)) +
  theme(plot.title = element_text(hjust = 0.5), axis.text.x = element_text(angle=90, hjust=1))

# Como os dados não estão corrigidos por população, não comparamos as magnitudes.
# Os boxplots das regiões permitem comparar melhor a assimetria e a dispersão.
# As regiões Sudeste e Nordeste apresentaram maior desigualdade no período.
# As regiões Norte e Centro-Oeste têm rendas mais simétricas e menos dispersas.

#Evolução anual da massa de rendimentos por trimestre no Brasil e nas regiões

dados %>% dplyr::select(Ano,Trimestre,Rendimento,Local) %>% filter(Local=="Brasil") %>% group_by(Ano) %>%
  ggplot(aes(as.factor(Ano),Rendimento)) + ggtitle("Massa de rendimento por trimestre ao longo dos anos no Brasil") +
  geom_point() + geom_label(aes(label = Trimestre), hjust = 1.5, angle=90) +
  xlab("Ano") + ylab("Massa de rendimento (em milhões de R$)") +
  theme(plot.title = element_text(hjust = 0.5), axis.text.x = element_text(hjust=0.5))

dados %>% dplyr::select(Ano,Trimestre,Rendimento,Local) %>% filter(Local=="Norte") %>% group_by(Ano) %>%
  ggplot(aes(as.factor(Ano),Rendimento)) + ggtitle("Massa de rendimento por trimestre ao longo dos anos no Norte") +
  geom_point() + geom_label(aes(label = Trimestre), hjust = 1.5, angle=90) +
  xlab("Ano") + ylab("Massa de rendimento (em milhões de R$)") +
  theme(plot.title = element_text(hjust = 0.5), axis.text.x = element_text(hjust=0.5))

dados %>% dplyr::select(Ano,Trimestre,Rendimento,Local) %>% filter(Local=="Nordeste") %>% group_by(Ano) %>%
  ggplot(aes(as.factor(Ano),Rendimento)) + ggtitle("Massa de rendimento por trimestre ao longo dos anos no Nordeste") +
  geom_point() + geom_label(aes(label = Trimestre), hjust = 1.5, angle=90) +
  xlab("Ano") + ylab("Massa de rendimento (em milhões de R$)") +
  theme(plot.title = element_text(hjust = 0.5), axis.text.x = element_text(hjust=0.5))

dados %>% dplyr::select(Ano,Trimestre,Rendimento,Local) %>% filter(Local=="Sudeste") %>% group_by(Ano) %>%
  ggplot(aes(as.factor(Ano),Rendimento)) + ggtitle("Massa de rendimento por trimestre ao longo dos anos no Sudeste") +
  geom_point() + geom_label(aes(label = Trimestre), hjust = 1.5, angle=90) +
  xlab("Ano") + ylab("Massa de rendimento (em milhões de R$)") +
  theme(plot.title = element_text(hjust = 0.5), axis.text.x = element_text(hjust=0.5))

dados %>% dplyr::select(Ano,Trimestre,Rendimento,Local) %>% filter(Local=="Sul") %>% group_by(Ano) %>%
  ggplot(aes(as.factor(Ano),Rendimento)) + ggtitle("Massa de rendimento por trimestre ao longo dos anos no Sul") +
  geom_point() + geom_label(aes(label = Trimestre), hjust = 1.5, angle=90) +
  xlab("Ano") + ylab("Massa de rendimento (em milhões de R$)") +
  theme(plot.title = element_text(hjust = 0.5), axis.text.x = element_text(hjust=0.5))

dados %>% dplyr::select(Ano,Trimestre,Rendimento,Local) %>% filter(Local=="Centro-Oeste") %>% group_by(Ano) %>%
  ggplot(aes(as.factor(Ano),Rendimento)) + ggtitle("Massa de rendimento por trimestre ao longo dos anos no Centro-Oeste") +
  geom_point() + geom_label(aes(label = Trimestre), hjust = 1.5, angle=90) +
  xlab("Ano") + ylab("Massa de rendimento (em milhões de R$)") +
  theme(plot.title = element_text(hjust = 0.5), axis.text.x = element_text(hjust=0.5))

# O que se nota em todas as localidades são em geral maiores massas de rendimento nos trimestres 1 e 4 (épocas de maior empregabilidade).
# Fica evidente também a mudança de tendência abrupta da massa de rendimento a partir do trimestre 2 de 2020 (início da pandemia). 
# Com esses insights em mente, passemos à análise das séries temporais dos dados salvos.

save.image("~/AED_MRT/dados_rendtrab.RData")
