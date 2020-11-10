library(tidyverse)

download_years <- as.character(c(2016:2018))

for (i in download_years) {
  ipeds_download(paste0("EF", i, "A_DIST"))
}

distance_files <- fs::dir_ls("data-raw", regex = "ef2.*\\.csv$")

ipeds_distance <- distance_files %>%
  map_dfr(read_csv, .id = "year") %>%
  mutate(year = str_extract(year, "[[:digit:]]+"))

ipeds_distance <- ipeds_distance %>%
  mutate(level = case_when(
    EFDELEV == 2 ~ "undergraduate",
    EFDELEV == 12 ~ "graduate"
  ),
  year = as.integer(year)) %>%
  select(unit_id = UNITID, year, level,
         all_distance = EFDEEXC,
         some_distance = EFDESOM,
         no_distance = EFDENON) %>%
  drop_na(level) %>%
  pivot_longer(all_distance:no_distance, names_to = "distance_type", values_to = "headcount") %>%
  drop_na(headcount)

load("~/Desktop/vized/R/sysdata.rda")

ipeds_distance <- inner_join(
  ipeds_directory %>%
    select(unit_id:sector_description, -year),
  ipeds_distance
) %>%
  select(unit_id, institution_name, year, everything())


usethis::use_data(ipeds_distance, overwrite = TRUE)
