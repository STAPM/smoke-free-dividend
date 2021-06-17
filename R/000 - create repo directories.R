
### this code creates the necessary repositories to run the code in the repo

intdatDir <- "data_intermediate"
if(!dir.exists(here::here(intdatDir))) {dir.create(here::here(intdatDir))}

rawdatDir <- "data_raw"
if(!dir.exists(here::here(rawdatDir))) {dir.create(here::here(rawdatDir))}

rm(list = ls())
