### The aim of this code is to calculate the upshift factor to match
### Toolkit expenditure info to HMRC duties

data <- readRDS("input_data/toolkit_clean.rds")
data <- data[Smoker == 1 & !is.na(weekspend),]

################################################################################
####### -------------- Final version of the upshift calc --- 27/06/2022-- ######

## use a new adjustment to UK tax revenues. from the 82% (proportion of smokers
## who are English from the APS) to proportion of tobacco duty which is paid from
## England from HMRC. Saved as the default option in version 1.4.1 of smkfreediv.
## Source on the new 76.6% figure:
##
## https://assets.publishing.service.gov.uk/government/uploads/system/uploads/attachment_data/file/853118/Disaggregated_tax_and_NICs_receipts_-_methodological_note.pdf

### price (weighted average price) from the European Commission for January 2019
### - expressed as price per 1000 sticks)
### https://ec.europa.eu/taxation_customs/tedb/taxDetails.html?id=4155/1546297200
###
### calculate the price per pack

price_wap <- 404.15*(20/1000)

upshift <- smkfreediv::CalcUpshift(data = data,
                                   LCFS = FALSE,
                                   vat = 0.2,
                                   price_fm = price_wap,
                                   duty_fm = 228.29,
                                   avt_fm = 0.165,
                                   price_ryo = smkfreediv::price_ryo_ons,
                                   duty_ryo = 234.65,
                                   deflate_from = c(12, 2018),
                                   deflate_to = c(12, 2018),
                                   adjust = TRUE,
                                   prop_duty_ENG = 0.766)


write.csv(upshift,
          "intermediate_data/upshift_calcs.csv",
          row.names = FALSE)
