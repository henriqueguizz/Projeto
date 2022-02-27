FROM rocker/r-ver:4.0.3

#instalar os pacotes necessários
RUN R -e "install.packages('COVID19')"
RUN R -e "install.packages('dplyr')"
RUN R -e "install.packages('ggplot2')"
RUN R -e "install.packages('zoo')"
RUN R -e "install.packages('scales')"

#copiar os arquivos necessários 
COPY /Código.R /Código.R
COPY /input /input
COPY /output /output

#roda o script
CMD Rscript /Código.R
