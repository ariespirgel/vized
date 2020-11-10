library(tidyverse)

download_years <- as.character(2018)

for (i in download_years) {
  ipeds_download(paste0("SAL", i, "_NIS"))
}

salary_files <- fs::dir_ls("data-raw", regex = "sal2.*\\.csv$")

ipeds_salary <- salary_files %>%
  map_dfr(read_csv, .id = "year") %>%
  mutate(year = str_extract(year, "[[:digit:]]+")) %>%
  select(-starts_with("X"))

ipeds_salary <- ipeds_salary %>%
  pivot_longer(SANIN01:SANIT14, names_to = "type", values_to = "value") %>%
  mutate(type2 = if_else(str_sub(type, -3, -3) == "N", "headcount", "salary"),
         occupation = case_when(
           str_sub(type, -2) == "01" ~ "Total",
           str_sub(type, -2) == "02" ~ "Research",
           str_sub(type, -2) == "03" ~ "Public service",
           str_sub(type, -2) == "04" ~ "Librarians, Curators, Archivists, and Academic Affairs and Other Education Services",
           str_sub(type, -2) == "05" ~ "Management",
           str_sub(type, -2) == "06" ~ "Business and Financial Operations",
           str_sub(type, -2) == "07" ~ "Computer, Engineering, and Science",
           str_sub(type, -2) == "08" ~ "Community, Social  Service, Legal, Arts, Design, Entertainment, Sports and Media",
           str_sub(type, -2) == "09" ~ "Healthcare Practioners and Technical",
           str_sub(type, -2) == "10" ~ "Service",
           str_sub(type, -2) == "11" ~ "Sales and related",
           str_sub(type, -2) == "12" ~ "Office and Administrative Support",
           str_sub(type, -2) == "13" ~ "Natural Resources, Construction, and Maintenance",
           str_sub(type, -2) == "14" ~ "Production, Transportation, and Material Moving"
         )) %>%
  filter(occupation != "Total") %>%
  select(-type, -year) %>%
  spread(type2, value) %>%
  rename(unit_id = UNITID)


load("~/Desktop/vized/R/sysdata.rda")

ipeds_salary <- inner_join(
  ipeds_directory %>%
    filter(year == "2018") %>%
    select(unit_id:state_description, -year),
  ipeds_salary
) %>%
  filter(headcount != 0)



usethis::use_data(ipeds_salary, overwrite = TRUE)



