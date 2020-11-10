library(tidyverse)
library(readxl)


download_years <- as.character(2018)

for (i in download_years) {
  ipeds_download(paste0("HD", i, "_Dict"))
}

dictionary_files_list <- fs::dir_ls("data-raw", regexp = "hd20.*\\.xlsx$")

ipeds_dictionary <- dictionary_files_list %>%
  map_dfr(read_excel, sheet = "Frequencies", .id = "year") %>%
  mutate(year = str_extract(year, "[[:digit:]]+"))


# sector ------------------------------------------------------------------

ipeds_sector <- ipeds_dictionary %>%
  filter(varname == "SECTOR") %>%
  mutate(codevalue = as.integer(codevalue)) %>%
  select(sector_code = codevalue,
         sector_description = valuelabel)

usethis::use_data(ipeds_sector, overwrite = TRUE)
# state -------------------------------------------------------------------

ipeds_state <- ipeds_dictionary %>%
  filter(varname == "STABBR") %>%
  select(state_abbreviation = codevalue,
         state_description = valuelabel) %>%
  distinct()

usethis::use_data(ipeds_state, overwrite = TRUE)
