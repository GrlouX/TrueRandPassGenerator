# Modelagem de séries temporais para a massa de rendimento efetivo dos trabalhadores

# Carregamento dos pacotes necessários

library(seasonal) #Análise de sazonalidade em séries temporais 
library(seasonalview) #Visualização de sazonalidade em séries temporais
library(forecast) #Previsões em séries temporais
library(urca) #Testes estatísticos em séries temporais
library(ggplot2) #Ferramentas de visualização gráfica

load("~/AED_MRT/dados_ibge.RData") # Carregar arquivo "dados_mrt.RData" da pasta "AED_MRT". 

# Definição das séries temporais conforme os períodos dos dados 

serieBR <- ts(dados_BR, start=c(2012,1), end=c(2021,2), frequency=4)
autoplot(serieBR, main = "Massa de rendimento efetivo no Brasil",
         xlab = "Período", ylab = "Rendimento")
serieN <- ts(dados_N, start=c(2012,1), end=c(2021,2), frequency=4)
autoplot(serieN, main = "Massa de rendimento efetivo no Norte",
         xlab = "Período", ylab = "Rendimento")
serieNE <- ts(dados_NE, start=c(2012,1), end=c(2021,2), frequency=4)
autoplot(serieNE, main = "Massa de rendimento efetivo no Nordeste",
         xlab = "Período", ylab = "Rendimento")
serieSE <- ts(dados_SE, start=c(2012,1), end=c(2021,2), frequency=4)
autoplot(serieSE, main = "Massa de rendimento efetivo no Sudeste",
         xlab = "Período", ylab = "Rendimento")
serieS <- ts(dados_S, start=c(2012,1), end=c(2021,2), frequency=4)
autoplot(serieS, main = "Massa de rendimento efetivo no Sul",
         xlab = "Período", ylab = "Rendimento")
serieCO <- ts(dados_CO, start=c(2012,1), end=c(2021,2), frequency=4)
autoplot(serieCO, main = "Massa de rendimento efetivo no Centro-Oeste",
         xlab = "Período", ylab = "Rendimento")

rm(dados_BR,dados_N,dados_NE,dados_SE,dados_S,dados_CO) # Remoção dos dados já convertidos em séries temporais

# Decomposição das séries temporais em: tendência, sazonalidade e ruídos

autoplot(decompose(serieBR), main = "Decomposição da massa de rendimento no Brasil")
autoplot(decompose(serieN), main = "Decomposição da massa de rendimento no Norte")
autoplot(decompose(serieNE), main = "Decomposição da massa de rendimento no Nordeste")
autoplot(decompose(serieSE), main = "Decomposição da massa de rendimento no Sudeste")
autoplot(decompose(serieS), main = "Decomposição da massa de rendimento no Sul")
autoplot(decompose(serieCO), main = "Decomposição da massa de rendimento no Centro-Oeste")
# Os gráficos ilustram comportamentos relativamente parecidos para todas as séries.

# A sazonalidade anual nítida já era esperada pela observação sobre os topos nos trimestres 1 e 4.
ggseasonplot(serieBR, season.labels=c("T1", "T2", "T3", "T4")) +
             ggtitle("Sazonalidade da massa de rendimento no Brasil") +
             xlab("Trimestre") + scale_color_discrete(name="Ano")
ggseasonplot(serieN, season.labels=c("T1", "T2", "T3", "T4")) +
             ggtitle("Sazonalidade da massa de rendimento no Norte") +
             xlab("Trimestre") + scale_color_discrete(name="Ano")
ggseasonplot(serieNE, season.labels=c("T1", "T2", "T3", "T4")) +
             ggtitle("Sazonalidade da massa de rendimento no Nordeste") +
             xlab("Trimestre") + scale_color_discrete(name="Ano")
ggseasonplot(serieSE, season.labels=c("T1", "T2", "T3", "T4")) +
             ggtitle("Sazonalidade da massa de rendimento no Sudeste") +
             xlab("Trimestre") + scale_color_discrete(name="Ano")
ggseasonplot(serieS, season.labels=c("T1", "T2", "T3", "T4")) +
             ggtitle("Sazonalidade da massa de rendimento no Sul") +
             xlab("Trimestre") + scale_color_discrete(name="Ano")
ggseasonplot(serieCO, season.labels=c("T1", "T2", "T3", "T4")) +
             ggtitle("Sazonalidade da massa de rendimento no Centro-Oeste") +
             xlab("Trimestre") + scale_color_discrete(name="Ano")
# Note que a massa de renda geralmente cai do início para o meio de cada ano, depois sobe de volta. 

# A tendência em todos os casos teve um comportamento oscilante similar também.
par(mfrow=c(2,3))
plot(decompose(serieBR)$trend, xlab="Período", ylab="",
     main="Tendência da massa de rendimento no Brasil")
plot(decompose(serieN)$trend, xlab="Período", ylab="",
     main="Tendência da massa de rendimento no Norte")
plot(decompose(serieNE)$trend, xlab="Período", ylab="",
     main="Tendência da massa de rendimento no Nordeste")
plot(decompose(serieSE)$trend, xlab="Período", ylab="",
     main="Tendência da massa de rendimento no Sudeste")
plot(decompose(serieS)$trend, xlab="Período", ylab="",
     main="Tendência da massa de rendimento no Sul")
plot(decompose(serieCO)$trend, xlab="Período", ylab="",
     main="Tendência da massa de rendimento no Centro-Oeste")
# Houve alta da massa de rendimento até uma queda significativa em 2016, depois nova alta até a queda acentuada de 2020.
# Nos casos do Norte e do Nordeste, verificaram-se oscilações mais marcantes em 2016.

# Por fim, a decomposição das séries revela ainda um componente de ruído muito elevado em 2020 e 2021.

# Testes de estacionariedade das séries (tendência a não mudar as medidas estatísticas)

# Teste KPSS - hipótese nula de estacionariedade (análise pelo valor crítico)
# Teste Phillips-Perron (PP) - hipótese alternativa de estacionariedade (análise pelo valor-p)

summary(ur.kpss(serieBR)) # Não rejeita a hipótese de estacionariedade com 5% de significância
summary(ur.pp(serieBR)) # Não rejeita a hipótese de estacionariedade com 5% de significância
ndiffs(serieBR) # Sugere uma diferenciação para estacionariedade
tsdisplay(serieBR) # Correlações cruzadas com atraso 4 fora dos limites de tolerância

summary(ur.kpss(serieN)) # Rejeita a hipótese de estacionariedade com 5% de significância
summary(ur.pp(serieN)) # Não rejeita a hipótese de estacionariedade com 5% de significância
ndiffs(serieN) # Sugere uma diferenciação para estacionariedade
tsdisplay(serieN) # Correlações cruzadas com atraso 4 fora dos limites de tolerância

summary(ur.kpss(serieNE)) # Não rejeita a hipótese de estacionariedade com 5% de significância
summary(ur.pp(serieNE)) # Não rejeita a hipótese de estacionariedade com 5% de significância
ndiffs(serieNE) # Não sugere diferenciação para estacionariedade
tsdisplay(serieNE) # Não são claras as correlações cruzadas fora dos limites de tolerância

summary(ur.kpss(serieSE)) # Rejeita a hipótese de estacionariedade com 5% de significância
summary(ur.pp(serieSE)) # Não rejeita a hipótese de estacionariedade com 5% de significância
ndiffs(serieSE) # Sugere uma diferenciação para estacionariedade
tsdisplay(serieSE) # Correlações cruzadas com atraso 4 fora dos limites de tolerância

summary(ur.kpss(serieS)) # Rejeita a hipótese de estacionariedade com 5% de significância
summary(ur.pp(serieS)) # Não rejeita a hipótese de estacionariedade com 5% de significância
ndiffs(serieS) # Sugere uma diferenciação para estacionariedade
tsdisplay(serieS) # Correlações cruzadas com atraso 4 fora dos limites de tolerância

summary(ur.kpss(serieCO)) # Rejeita a hipótese de estacionariedade com 5% de significância
summary(ur.pp(serieCO)) # Não rejeita a hipótese de estacionariedade com 5% de significância
ndiffs(serieCO) # Sugere uma diferenciação para estacionariedade
tsdisplay(serieCO) # Correlações cruzadas com atraso 4 fora dos limites de tolerância

# Divisão dos dados em treino e teste

# Vamos considerar os dados de treino até final de 2018 (~75% dos dados)
treinoBR <- window(serieBR, start = c(2012,1), end = c(2018,4))
treinoN <- window(serieN, start = c(2012,1), end = c(2018,4))
treinoNE <- window(serieNE, start = c(2012,1), end = c(2018,4))
treinoSE <- window(serieSE, start = c(2012,1), end = c(2018,4))
treinoS <- window(serieS, start = c(2012,1), end = c(2018,4))
treinoCO <- window(serieCO, start = c(2012,1), end = c(2018,4))

# Vamos considerar os dados de teste a partir de 2019 em 2 grupos (~25% dos dados)
teste1BR <- window(serieBR, start = c(2019,1), end = c(2020,1))
teste1N <- window(serieN, start = c(2019,1), end = c(2020,1))
teste1NE <- window(serieNE, start = c(2019,1), end = c(2020,1))
teste1SE <- window(serieSE, start = c(2019,1), end = c(2020,1))
teste1S <- window(serieS, start = c(2019,1), end = c(2020,1))
teste1CO <- window(serieCO, start = c(2019,1), end = c(2020,1)) # Pré-pandemia
teste2BR <- window(serieBR, start = c(2020,2), end = c(2021,2))
teste2N <- window(serieN, start = c(2020,2), end = c(2021,2))
teste2NE <- window(serieNE, start = c(2020,2), end = c(2021,2))
teste2SE <- window(serieSE, start = c(2020,2), end = c(2021,2))
teste2S <- window(serieS, start = c(2020,2), end = c(2021,2))
teste2CO <- window(serieCO, start = c(2020,2), end = c(2021,2)) # Período da pandemia

# Modelagem com ARIMA

# r_t: massa de rendimento efetivo total no tempo t
# a_i: parâmetros da parte autoregressiva
# e_t: erro aleatório no tempo t
# m_j: parâmetros da parte da média móvel
# L: operador de defasagem / atraso / lag -> Lr_t = r_(t-1) 

# Caso da massa de rendimento no Brasil: (1-a_1*L)(1-L^4)r_t = e_t
arimaBR <- auto.arima(treinoBR, trace = T, stepwise = F, approximation = F)
checkresiduals(arimaBR)
shapiro.test(arimaBR$residuals) 
# Modelo não deveria ser usado para previsões, pois resíduos não são ruído branco.

prev_arimaBR <- forecast(arimaBR, h=10)
plot(serieBR, main="Modelo ARIMA para massa de rendimento no Brasil", 
     xlab="Período", ylab="Rendimento")
lines(prev_arimaBR$mean, col="red") 

# Caso da massa de rendimento no Norte: (1-a_1*L-a_2*L^2)(1-L^4)r_t = (1-m_1*L^4)e_t
arimaN <- auto.arima(treinoN, trace = T, stepwise = F, approximation = F)
checkresiduals(arimaN)
shapiro.test(arimaN$residuals) 
# Modelo poderia ser utilizado para previsões, pois resíduos são próximos de ruído branco.

prev_arimaN <- forecast(arimaN, h=10)
plot(serieN, main="Modelo ARIMA para massa de rendimento no Norte", 
     xlab="Período", ylab="Rendimento")
lines(prev_arimaN$mean, col="purple") 

# Caso da massa de rendimento no Nordeste: (1-a_1*B)(1-B^4)r_t = (1-m_1*B^4)e_t
arimaNE <- auto.arima(treinoNE, trace = T, stepwise = F, approximation = F)
checkresiduals(arimaNE)
shapiro.test(arimaNE$residuals) 
# Modelo poderia ser utilizado para previsões, pois resíduos são próximos de ruído branco.

prev_arimaNE <- forecast(arimaNE, h=10)
plot(serieNE, main="Modelo ARIMA para massa de rendimento no Nordeste", 
     xlab="Período", ylab="Rendimento")
lines(prev_arimaNE$mean, col="blue") 

# Caso da massa de rendimento no Sudeste: (1-a_1*B)(1-B^4)r_t = e_t
arimaSE <- auto.arima(treinoSE, trace = T, stepwise = F, approximation = F)
checkresiduals(arimaSE)
shapiro.test(arimaSE$residuals) 
# Modelo não deveria ser usado para previsões, pois resíduos não são ruído branco.

prev_arimaSE <- forecast(arimaSE, h=10)
plot(serieSE, main="Modelo ARIMA para massa de rendimento no Sudeste", 
     xlab="Período", ylab="Rendimento")
lines(prev_arimaSE$mean, col="gold") 

# Caso da massa de rendimento no Sul: (1-a_1*B)(1-B^4)r_t = e_t
arimaS <- auto.arima(treinoS, trace = T, stepwise = F, approximation = F)
checkresiduals(arimaS)
shapiro.test(arimaS$residuals) 
# Modelo poderia ser utilizado para previsões, pois resíduos são próximos de ruído branco.

prev_arimaS <- forecast(arimaS, h=10)
plot(serieS, main="Modelo ARIMA para massa de rendimento no Sul", 
     xlab="Período", ylab="Rendimento")
lines(prev_arimaS$mean, col="orange") 

# Caso da massa de rendimento no Centro-Oeste: (1-a_1*B)(1-B^4)r_t = e_t
arimaCO <- auto.arima(treinoCO, trace = T, stepwise = F, approximation = F)
checkresiduals(arimaCO)
shapiro.test(arimaCO$residuals) 
# Modelo poderia ser utilizado para previsões, pois resíduos são próximos de ruído branco.

prev_arimaCO <- forecast(arimaCO, h=10)
plot(serieCO, main="Modelo ARIMA para massa de rendimento no Centro-Oeste", 
     xlab="Período", ylab="Rendimento")
lines(prev_arimaCO$mean, col="pink") 

# As linhas de predição coloridas sugerem nível razoável de acurácia no pré-pandemia, exceto no Norte e no Centro-Oeste, em virtude de uma mudança no comportamento na série detectada nos últimos períodos.
# O período de pandemia foi extremamente imprevisível aos modelos em geral (como esperado), exceto no Norte e no Sul, onde foi identificada uma tendência anterior de estabilização da massa de rendimento.

# Avaliação da acurácia dos modelos (as medidas utilizadas em geral são tanto melhores quanto menores os valores em módulo)

accuracy(prev_arimaBR, teste1BR)
accuracy(prev_arimaBR, teste2BR) 
# A acurácia é muito pior durante a pandemia em relação ao período anterior.

accuracy(prev_arimaN, teste1N)
accuracy(prev_arimaN, teste2N) 
# Caso excepcional com acurácia razoável similar antes e depois da pandemia.

accuracy(prev_arimaNE, teste1NE)
accuracy(prev_arimaNE, teste2NE)
# A acurácia é muito pior durante a pandemia em relação ao período anterior.

accuracy(prev_arimaSE, teste1SE)
accuracy(prev_arimaSE, teste2SE)
# A acurácia é muito pior durante a pandemia em relação ao período anterior.

accuracy(prev_arimaS, teste1S)
accuracy(prev_arimaS, teste2S)
# A acurácia é ligeiramente pior durante a pandemia em relação ao período anterior.

accuracy(prev_arimaCO, teste1CO)
accuracy(prev_arimaCO, teste2CO)
# A acurácia é muito pior durante a pandemia em relação ao período anterior.

# Verifica-se em geral baixo poder preditivo dos modelos para previsões mais adiante.
# Vejamos os casos específicos do Norte e do Sul (para o resto de 2021), cujas previsões foram validadas e são relativamente acuradas.

prev_arimaN <- forecast(arimaN, h=12)
plot(prev_arimaN, main="Previsões da massa de rendimento no Norte",
     xlab="Período", ylab="Rendimento")
lines(serieN, col="purple")

# Próximas predições para o Norte:
window(prev_arimaN$lower, start=c(2021,3))
window(prev_arimaN$mean, start=c(2021,3)) 
window(prev_arimaN$upper, start=c(2021,3))

# Note que o modelo foi capaz de prever (mesmo com elevada incerteza) as observações a partir de 2020 dentro da faixa de confiança mais estreita (nível 80%).

prev_arimaS <- forecast(arimaS, h=12)
plot(prev_arimaS, main="Previsões da massa de rendimento no Sul",
     xlab="Período", ylab="Rendimento")
lines(serieS, col="orange")

# Próximas predições para o Sul:
window(prev_arimaS$lower, start=c(2021,3))
window(prev_arimaS$mean, start=c(2021,3)) 
window(prev_arimaS$upper, start=c(2021,3))

# Note que o modelo conseguiu prever (mesmo com elevada incerteza) as observações a partir de 2020, inclusive a queda mais brusca dentro da faixa de confiança mais larga (nível 95%).  

# Para os dois últimos trimestres de 2021, esperemos para averiguar as próximas predições.

# Parafraseando o estatístico George Box (1919-2013): "Essencialmente, todos os modelos estão errados, mas alguns são úteis." 

save.image("~/modelagem_MRT/resultados_mrt.RData")

# Conclusões 

# A dificuldade conjecturada para as predições confirmou-se mesmo nos melhores modelos.
# A pandemia criou um cenário bastante complexo de mapear sem pesquisas de campo. 
# Outros modelos clássicos de regressão e suavização exponencial foram testados, sem sucesso (não convergência).
# As previsões não tão acuradas mesmo no período pré-pandemia revelaram a necessidade de mais dados históricos.  
# Cenários atípicos como este demandam uma recalibragem dos modelos, notadamente através de um censo demográfico!
