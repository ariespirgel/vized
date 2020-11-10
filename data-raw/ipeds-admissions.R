library(tidyverse)

download_years <- as.character(2018)

for (i in download_years) {
  ipeds_download(paste0("ADM", i))
}

admit_files <- fs::dir_ls("data-raw", regex = "adm2.*\\.csv$")

ipeds_admissions <- admit_files %>%
  map_dfr(read_csv, .id = "year") %>%
  mutate(year = str_extract(year, "[[:digit:]]+"))

ipeds_admissions <- ipeds_admissions %>%
  select(unit_id = UNITID,
        year,
        applicants_total   = APPLCN,
        admissions_total   = ADMSSN,
        enrolled_total     = ENRLT,
        sat_submitted_n    = SATNUM,
        # act_submitted_n    = ACTNUM,
        sat_ebrw_25th      = SATVR25,
        sat_ebrw_75th      = SATVR75,
        sat_math_25th      = SATMT25,
        sat_math_75th      = SATMT75
        # act_composite_25th = ACTCM25,
        # act_composite_75th = ACTCM75,
        # act_english_25th   = ACTEN25,
        # act_english_75th   = ACTEN75,
        # act_math_25th      = ACTMT25,
        # act_math_75th      = ACTMT75
        )

load("~/Desktop/vized/R/sysdata.rda")

ipeds_admissions <- inner_join(ipeds_admissions, ipeds_directory) %>%
  select(unit_id, institution_name,
         year, sector_description, state_description,
         latitude, longitude, everything())

ipeds_sat <- ipeds_admissions %>%
  filter(year == "2018") %>%
  select(unit_id, institution_name,
         sat_ebrw_25th:sat_math_75th) %>%
  pivot_longer(cols = contains("sat"), names_to = "test", values_to = "score") %>%
  mutate(percentile = paste0(parse_number(test), "th"),
         test       = str_sub(test, start = 1, end = 8)) %>%
  select(unit_id:test, percentile, score) %>%
  spread(test, score)

usethis::use_data(ipeds_sat, overwrite = TRUE)

ivy_plus_unit_ids <- c(110635, 217156, 144050, 190150, 190415,
                       166027, 166683, 215062, 186131, 243744, 130794)



ipeds_funnel <- ipeds_admissions %>%
  filter(year == "2018") %>%
  mutate(ivy_plus_exchange = if_else(unit_id %in% ivy_plus_unit_ids, "IvyPlus Exchange", "Other")) %>%
  select(unit_id, institution_name, sector_description, state_description, ivy_plus_exchange,
         applicants_total, admitted_total = admissions_total, enrolled_total) %>%
  mutate(admit_rate = round(admitted_total / applicants_total, digits = 4),
           yield_rate = round(enrolled_total / admitted_total, digits = 4)) %>%
  filter(sector_description %in% c("Public, 4-year or above",
                                   "Private not-for-profit, 4-year or above"))

usethis::use_data(ipeds_funnel, overwrite = TRUE)

