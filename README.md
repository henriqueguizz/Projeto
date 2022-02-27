# Projeto de Ciência de Dados: Análise descritiva da pandemia de COVID-19 no Brasil versus países selecionados

## 1.	Objetivo 
O presente trabalho tem como objetivo principal a análise descritiva de dados e indicadores relativos ao desenvolvimento da pandemia de COVID-19 no Brasil e em países selecionados. Com isso, esperamos obter certas conclusões sobre como o vírus se propagou pelo território nacional ao longo do tempo, quais as suas consequências sobre a saúde da população e como o processo de vacinação pode ter ajudado no controle da doença, utilizando como parâmetro de comparação os países que compõem o G10.

## 2.	Metodologia
No desenvolvimento do projeto empregamos como metodologia principal a análise descritiva de dados secundários, por meio da elaboração de sete gráficos. 
A fonte principal das bases utilizadas foi o projeto COVID-19 Data Hub por meio do pacote COVID-19 no R, elaborado pelo estudante de PhD da Universidade de Neuchâtel, Emanuele Guidotti. Além disso, também utilizamos o indicador de mobilidade do Google para comércio de varejo, fornecido pelo mesmo pacote. As variáveis selecionadas para a construção das visualizações foram: número de casos confirmados (“confirmed”), número de mortes confirmadas (“deaths”), número de pessoas totalmente vacinadas (“people_fully_vaccinated”), população total (“population”) e o indicador de mobilidade do Google (“retail_and_recreation_percent_change_from_baseline”). Com isso definido, pudemos criar novas variáveis, como a média móvel de sete dias de novos casos (“novos_casos_mm7d”), média móvel de sete dias de novas mortes (“novas_mortes_mm7d”), porcentagem da população totalmente vacinada (“pop_pct_vacinada”), entre outras. 

## 3.	Principais visualizações
Primeiramente, criamos dois gráficos: média móvel de sete dias de novos casos (“Gráfico 1”) e de novas mortes (“Gráfico 2”) para o Brasil. Assim, podemos entender como a incidência do vírus se comportou ao longo do tempo – quando ocorreram as principais ondas de casos e mortes, por exemplo.

![alt text](https://github.com/henriqueguizz/Projeto/blob/main/Gráfico%201.png?raw=true)
![alt text](https://github.com/henriqueguizz/Projeto/blob/main/Gráfico%202.png?raw=true)

O Gráfico 2 nos mostra que o pior período da pandemia no Brasil se deu no mês de abril de 2021, momento onde o país relatou o maior número diário de mortos, acima de três mil pessoas. No entanto, podemos ver que o número de novos casos diários reportados no mesmo período foi muito inferior ao valor do início de 2022, onde atingimos cerca de 190 mil novos casos contabilizados diariamente. Isso mostra um efeito positivo da vacinação, ao mesmo tempo em que o surgimento de novas cepas mais transmissíveis e menos letais também influenciou no menor número de mortos. 
Como mencionado anteriormente, a partir do início de 2021, outro dado de extrema relevância passou a ser divulgado: o número de pessoas totalmente vacinadas em território nacional, seja com duas doses ou dose única, a depender do esquema vacinal. Assim, elaboramos um gráfico comparando a porcentagem de brasileiros vacinados versus não-vacinados (“Gráfico 3”), onde vemos que a parcela da população imunizada é extremamente superior:

![alt text](https://github.com/henriqueguizz/Projeto/blob/main/Gráfico%203.png?raw=true)

Embora números absolutos sejam importantes para compreendermos a dinâmica da pandemia no Brasil, devemos comparar os números obtidos com outros países, para podermos entender se os indicadores alcançados fazem sentido apenas pela natureza do vírus ou se outros aspectos podem ter influenciado esse comportamento. Logo, padronizamos as variáveis de médias móveis de sete dias por dez mil habitantes e construímos mais dois gráficos, onde comparamos o Brasil com Alemanha, Itália, Reino Unido e Estados Unidos: média móvel de sete dias de novos casos por dez mil habitantes (“Gráfico 4”) e de novas mortes por dez mil habitantes (“Gráfico 5”): 

![alt text](https://github.com/henriqueguizz/Projeto/blob/main/Gráfico%204.png?raw=true)
![alt text](https://github.com/henriqueguizz/Projeto/blob/main/Gráfico%205.png?raw=true)

É facilmente notado que, embora o número de novos mortos por COVID-19 no Brasil tenha alcançado patamares extremos durante a segunda onda, vemos que o maior valor se deu no Reino Unido – aproximadamente 0,2 mortos a cada dez mil habitantes. Com relação aos números de novos casos, podemos perceber que o Brasil se encontrou ao longo do tempo em patamares bem abaixo dos países selecionados, embora esse seja um dado mais difícil de fazermos comparações, na medida em que diferentes países possuem distintas políticas de testagem da população. 
Outro lado interessante de ser estudado sobre a COVID-19 é como a doença pode ter afetado a economia ao redor do mundo. Nesse trabalho tentamos realizar apenas uma análise superficial, empregando o dado de mobilidade do Google, que descreve como o deslocamento da população de determinada região foi alterado devido à COVID-19, comparativamente a uma data de referência – no caso, o valor mediano entre 3 de janeiro e 6 de fevereiro de 2020. Utilizamos, então, os valores para os mesmos países dos gráficos 4 e 5 na categoria retail and recreation, em média móvel de sete dias (“Gráfico 6”):

![alt text](https://github.com/henriqueguizz/Projeto/blob/main/Gráfico%206.png?raw=true)

O gráfico nos mostra que a média da variação com relação ao valor base do deslocamento para lojas de varejo e recreação apresentou quedas significativas em todos os países analisados no ínicio de 2020, com o valor mais extremo tendo sido obtido na Itália – uma variação negativa de aproximadamente 90%. Também é interessante notarmos que, nos dias atuais, o Brasil se mostra como o país mais próximo dos valores anteriores à pandemia, inclusive os ultrapassando em certos momentos. No entanto, para os demais, a recuperação econômica ainda manifesta estar comprometida por consequência do vírus. 
Por último, é de extrema importância no âmbito de políticas públicas compararmos a dinâmica da vacinação contra COVID-19 no Brasil em relação a outros países, para podermos detectar falhas e possíveis melhorias no processo que possam beneficiar a população. Assim, o último gráfico deste trabalho mostra como o país se encontra em termos de parcela da população vacinada com relação aos países do G10 (“Gráfico 7”), nos apresentando certa defasagem com respeito a nações como Canadá e Itália, onde a parcela de imunizados já supera os 80%:

![alt text](https://github.com/henriqueguizz/Projeto/blob/main/Gráfico%207.png?raw=true)
