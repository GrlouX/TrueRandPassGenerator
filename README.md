# RealRandPassGenerator

O objetivo deste projeto é criar senhas realmente aleatórias, cuja geração não seja reprodutível por sementes (seeds). Com isso, espera-se inviabilizar qualquer tentativa de 
replicar o processo de geração de senhas, o que em tese poderia ocorrer nos geradores pseudoaleatórios, uma vez que estes apresentam certas propriedades determinísticas e periódicas.    

A aleatoriedade esperada é possível, desde que tais senhas sejam obtidas dos chamados **números realmente aleatórios (true random numbers)**. O site [random.org](https://www.random.org/), criado por pesquisadores do **Trinity College Dublin**, Irlanda, provê esses números. Eles são gerados por processamento computacional de ondas de rádio, oriundas de uma fonte de entropia curiosa: ruídos atmosféricos capturados. Por isso, são números teoricamente imprevisíveis, conforme pode ser verificado nas [Estatísticas em tempo real](https://www.random.org/statistics/?__cf_chl_jschl_tk__=pmd_a439af8521ddab4b895e2862f5170b044a1d9b47-1634727933-0-gqNtZGzNAg2jcnBszQvO). A desvantangem é que esses números não são gerados de forma tão eficiente quanto os pseudoaleatórios.

Para o propósito de segurança desejado na geração de senhas, é uma alternativa interessante, cuja desvantagem não pesa tanto quanto em simulações computacionais, por exemplo. 
O código desenvolvido realiza requisições via AJAX no referido site, as quais devem observar as [regras para clientes automatizados](https://www.random.org/clients/).
A interface visual é interativa e autoexplicativa para escolha dos parâmetros da senha, a qual por padrão sempre poderá conter números, além dos tipos de caracteres selecionados
pelo usuário.

![Randompass](https://user-images.githubusercontent.com/90117229/137609272-c547ab4f-920c-44fe-9f6c-38be32517682.gif)

