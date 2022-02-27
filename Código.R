#pacotes necessários
library(COVID19)
library(dplyr)
library(ggplot2)
library(zoo)
library(scales)

#coletando os dados de Brasil e G-10 do pacote COVID19
bz <- covid19(country = "Brazil", level = 1, gmr = TRUE)
bg <- covid19(country = "Belgium", level = 1, gmr = TRUE)
cn <- covid19(country = "Canada", level = 1, gmr = TRUE)
fr <- covid19(country = "France", level = 1, gmr = TRUE)
ge <- covid19(country = "Germany", level = 1, gmr = TRUE)
it <- covid19(country = "Italy", level = 1, gmr = TRUE)
jp <- covid19(country = "Japan", level = 1, gmr = TRUE)
ne <- covid19(country = "Netherlands", level = 1, gmr = TRUE)
sd <- covid19(country = "Sweden", level = 1, gmr = TRUE)
sw <- covid19(country = "Switzerland", level = 1, gmr = TRUE)
uk <- covid19(country = "United Kingdom", level = 1, gmr = TRUE)
us <- covid19(country = "United States", level = 1, gmr = TRUE)

#função que cria colunas de novos casos, novas mortes (simples e mm7d) e parcelas de população vacinada
new.function <- function(df) {
  df$date <- as.Date(df$date, format="%d/%m/%Y")
  df <- df %>% 
    mutate(novos_casos = confirmed - lag(confirmed, default = first(confirmed)), .after = confirmed)
  df <- df %>% 
    mutate(novas_mortes = deaths - lag(deaths, default = first(deaths)), .after = deaths)
  df <- df %>%
    mutate(novos_casos_mm7d = rollmean(novos_casos, k = 7, fill = NA), .after = novos_casos)
  df <- df %>%
    mutate(novas_mortes_mm7d = rollmean(novas_mortes, k = 7, fill = NA), .after = novas_mortes)
  df <- df %>%
    mutate(novos_casos_mm7d_10k = novos_casos_mm7d/(population/10000), .after = novos_casos_mm7d)
  df <- df %>%
    mutate(novas_mortes_mm7d_10k = novas_mortes_mm7d/(population/10000), .after = novas_mortes_mm7d)
  df <- df %>% 
    mutate(pop_pct_vacinada = people_fully_vaccinated/population, .after = people_fully_vaccinated)
  df <- df %>% 
    mutate(pop_pct_naovacinada = 1 - pop_pct_vacinada, .after = pop_pct_vacinada)
  df <- df %>%
    mutate(retail_pct_mm7d = rollmean(retail_and_recreation_percent_change_from_baseline, k = 7, fill = NA), .after = retail_and_recreation_percent_change_from_baseline)
  df
}

bz <- new.function(bz)
bg <- new.function(bg)
cn <- new.function(cn)
fr <- new.function(fr)
ge <- new.function(ge)
it <- new.function(it)
jp <- new.function(jp)
ne <- new.function(ne)
sd <- new.function(sd)
sw <- new.function(sw)
uk <- new.function(uk)
us <- new.function(us)

#juntar os dataframes
paises_barra <- rbind(bz, bg, cn, fr, ge, it, jp, ne, sd, sw, uk, us)
paises_linha <- rbind(bz, ge, it, uk, us)

#gráfico novos casos (mm7d) e novas mortes (mm7d) Brasil
min <- as.Date("2020-01-15")
max <- max(paises_linha$date, na.rm = T)
  
  #definindo data do início da vacinação
  #row_index <- which(!is.na(bz$people_vaccinated), arr.ind = TRUE)[1]
  #data_vacinacao <- bz$date[row_index]
  
  bz %>% 
    ggplot() +
    geom_line(aes(x = date, y = novos_casos_mm7d), color="red") + 
    #geom_vline(xintercept = data_vacinacao, linetype = "longdash", show.legend = T) +
    labs(title="Brasil - Novos casos de COVID-19", subtitle= "Em média móvel de 7 dias",x="Data", y = "Novos casos (MM7D)", caption = "Fonte: COVID-19 Data Hub") +
    theme(plot.title = element_text(face = "bold")) +
    scale_y_continuous(labels = label_number(big.mark = ".", decimal.mark = ",")) +
    scale_x_date(labels = "%m/%Y", date_labels = "%m/%Y", limits = c(min, max))
  
  bz %>% 
    ggplot() +
    geom_line(aes(x = date, y = novas_mortes_mm7d), color="red") +
    #geom_vline(xintercept = data_vacinacao, linetype = "longdash") +
    labs(title="Brasil - Novas mortes de COVID-19", subtitle= "Em média móvel de 7 dias",x="Data", y = "Novas mortes (MM7D)", caption = "Fonte: COVID-19 Data Hub") +
    theme(plot.title = element_text(face = "bold")) +
    scale_y_continuous(labels = label_number(big.mark = ".", decimal.mark = ",")) +
    scale_x_date(labels = "%m/%Y", date_labels = "%m/%Y", limits = c(min, max))
  
#gráfico de vacinados x não vacinados 
row_index <- which(bz$pop_pct_vacinada == max(bz$pop_pct_vacinada, na.rm = T), arr.ind = TRUE)[1]
  
df <- data.frame(
  group = c("Vacinados", "Não vacinados"),
  value = c(bz$pop_pct_vacinada[row_index],bz$pop_pct_naovacinada[row_index])
)
  
df %>% 
  ggplot(aes(x="", y=value, fill=group)) +
  geom_bar(width=1, stat="identity", color = "white") +
  coord_polar("y", start=0) +
  labs(title="Brasil - Vacinados x Não vacinados", subtitle= "Em porcentagem da população", caption = "Fonte: COVID-19 Data Hub") +
  scale_fill_brewer("Legenda") +
  geom_text(aes(y = value/3 + c(0, cumsum(value)[-length(value)]), label = percent(value/100), fontface = 2), size=5) +
  theme_void()

#gráficos de novos casos e novas mortes mm7d por 10k habitantes (Brasil x G10)
paises_linha %>% 
  ggplot(aes(x = date)) +
  geom_line(aes(y = novos_casos_mm7d_10k, color = administrative_area_level_1, group = administrative_area_level_1)) + 
  scale_size_manual(values = c(Brazil = 3)) +
  scale_color_manual(values = c("red", "blue", "green", "orange", "black")) +
  labs(title="Novos casos de COVID-19 - Brasil x Países selecionados", subtitle= "Em média móvel de 7 dias, por 10 mil habitantes",x="Data", 
       y = "Novos casos por 10k hab. (MM7D)", caption = "Fonte: COVID-19 Data Hub", col="Legenda") +
  theme(plot.title = element_text(face = "bold")) +
  scale_y_continuous(labels = label_number(big.mark = ".", decimal.mark = ",")) +
  scale_x_date(labels = "%m/%Y", date_labels = "%m/%Y", limits = c(min, max))

paises_linha %>% 
  ggplot(aes(x = date)) +
  geom_line(aes(y = novas_mortes_mm7d_10k, color = administrative_area_level_1, group = administrative_area_level_1)) + 
  scale_size_manual(values = c(Brazil = 3)) +
  scale_color_manual(values = c("red", "blue", "green", "orange", "black")) +
  labs(title="Novas mortes de COVID-19 - Brasil x Países selecionados", subtitle= "Em média móvel de 7 dias, por 10 mil habitantes",x="Data", 
       y = "Novas mortes por 10k hab. (MM7D)", caption = "Fonte: COVID-19 Data Hub", col="Legenda") +
  theme(plot.title = element_text(face = "bold")) +
  scale_y_continuous(labels = label_number(big.mark = ".", decimal.mark = ",")) +
  scale_x_date(labels = "%m/%Y", date_labels = "%m/%Y", limits = c(min, max))

#gráficos de mobilidade google mm7d (Brasil x G10)
paises_linha %>% 
  ggplot(aes(x = date)) +
  geom_line(aes(y = retail_pct_mm7d, color = administrative_area_level_1, group = administrative_area_level_1)) + 
  geom_hline(yintercept = 0, linetype = "longdash") +
  scale_color_manual(values = c("red", "blue", "green", "orange", "black")) +
  labs(title="Google Mobility Report - Brasil x Países selecionados", subtitle= "Retail and recreation - Porcentagem de variação em relação à data de referência, \nem média móvel de 7 dias",x="Data", 
       y = "Porcentagem de variação (MM7D)", caption = "Fonte: Google", col="Legenda") +
  theme(plot.title = element_text(face = "bold")) +
  scale_y_continuous(labels = label_number(big.mark = ".", decimal.mark = ",")) +
  scale_x_date(labels = "%m/%Y", date_labels = "%m/%Y", limits = c(min, max))

#gráficos de porcentagem de vacinados
barra.function <- function(df) {
  df <- df %>%
    filter(pop_pct_vacinada == max(pop_pct_vacinada, na.rm = T)) %>%
    select(pop_pct_vacinada, administrative_area_level_1)
  df
}

bg_barra <- barra.function(bg)
bz_barra <- barra.function(bz)
cn_barra <- barra.function(cn)
fr_barra <- barra.function(fr)
ge_barra <- barra.function(ge)
it_barra <- barra.function(it)
jp_barra <- barra.function(jp)
ne_barra <- barra.function(ne)
sd_barra <- barra.function(sd)
sw_barra <- barra.function(sw)
uk_barra <- barra.function(uk)
us_barra <- barra.function(us)

us_barra <- us_barra[-c(2),]

df_barra <- rbind(bg_barra, bz_barra, cn_barra, fr_barra, ge_barra, it_barra, jp_barra, ne_barra,
                  sd_barra, sw_barra, uk_barra, us_barra)

df_barra <- arrange(df_barra, df_barra$pop_pct_vacinada)

df_barra %>%
  ggplot(aes(x=reorder(administrative_area_level_1, pop_pct_vacinada), y=pop_pct_vacinada)) +
  geom_bar(stat = "identity", fill=factor(ifelse(df_barra$administrative_area_level_1 == "Brazil", "red","steelblue"))) +
  geom_text(aes(label= percent(pop_pct_vacinada, accuracy = 0.1)), vjust=0.5, hjust=1.0, size=4, color="white") +
  labs(title="Porcentagem da população vacinada contra COVID-19", subtitle= "Esquema vacinal completo, uma ou duas doses",x="Países", 
       y = "Porcentagem da população vacinada", caption = "Fonte: COVID-19 Data Hub") +
  theme(plot.title = element_text(face = "bold")) +
  coord_flip() + 
  scale_y_continuous(labels = scales::percent_format(accuracy = 1L))










