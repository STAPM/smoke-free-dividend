
rawdatDir <- "input_data"
if(!dir.exists(here::here(rawdatDir))) {dir.create(here::here(rawdatDir))}

intdatDir <- "intermediate_data"
if(!dir.exists(here::here(intdatDir))) {dir.create(here::here(intdatDir))}

outputDir <- "output"
if(!dir.exists(here::here(outputDir))) {dir.create(here::here(outputDir))}

#outlaDir <- "output/comparisons"
#if(!dir.exists(here::here(outlaDir))) {dir.create(here::here(outlaDir))}

#outgorDir <- "output/descriptives"
#if(!dir.exists(here::here(outgorDir))) {dir.create(here::here(outgorDir))}

outmainDir <- "output/main results"
if(!dir.exists(here::here(outmainDir))) {dir.create(here::here(outmainDir))}

Dir <- c(rawdatDir,intdatDir,
         outputDir,outmainDir)

rm(rawdatDir,intdatDir,outputDir,outmainDir)
