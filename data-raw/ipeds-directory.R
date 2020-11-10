library(tidyverse)
library(readxl)

download_years <- as.character(2018)

for (i in download_years) {
  ipeds_download(paste0("HD", i))
}

directory_files_list <- fs::dir_ls("data-raw", regexp = "hd20.*\\.csv$")

ipeds_directory <- directory_files_list %>%
  map_dfr(read_csv, .id = "year") %>%
  mutate(year = str_extract(year, "[[:digit:]]+"))

ipeds_directory <- ipeds_directory %>%
  select(unit_id = UNITID, institution_name = INSTNM,
         year,
         sector_code =  SECTOR, state_code = FIPS,
         state_abbrev = STABBR, longitude = LONGITUD,
         latitude = LATITUDE)


# add descriptions --------------------------------------------------------

load("data/ipeds_sector.rda")
load("data/ipeds_state.rda")

ipeds_directory <- ipeds_directory %>%
  inner_join(ipeds_sector) %>%
  inner_join(ipeds_state %>% rename(state_abbrev = state_abbreviation))

ipeds_directory <- ipeds_directory %>%
  select(unit_id, institution_name, year, sector_description,
         state_description, longitude, latitude)

usethis::use_data(ipeds_directory, overwrite = TRUE, internal = TRUE)




# ipeds coordinates -------------------------------------------------------

non_lower_48 <- c("American Samoa", "Alaska", "Hawaii",
                  "Puerto Rico", "Virgin Islands", "Federated States of Micronesia",
                  "Guam", "Marshall Islands", "Northern Marianas",
                  "Palau")

ipeds_coordinates <- ipeds_directory %>%
  filter(year == "2018") %>%
  select(unit_id, institution_name, sector_description, state_description,
         latitude, longitude) %>%
  filter(!state_description %in% non_lower_48)

usethis::use_data(ipeds_coordinates, overwrite = TRUE)

