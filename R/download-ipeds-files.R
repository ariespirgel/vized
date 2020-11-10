ipeds_download <- function(filename) {

  if (!file.exists(paste0("data-raw/", tolower(filename), ".csv"))) {
    download.file(
      paste0("https://nces.ed.gov/ipeds/datacenter/data/", filename, ".zip"),
      paste0("data-raw/", filename, ".zip")
    )

    unzip(paste0("data-raw/", filename, ".zip"), exdir = "data-raw") # unzips

    unlink(paste0("data-raw/", filename, ".zip")) # removes zip file

  # if there is a revised and unrevised file, this keeps only the revised
  if (file.exists(paste0("data-raw/", tolower(filename), ".csv")) &
      file.exists(paste0("data-raw/", tolower(filename), "_rv.csv"))) {

    unlink(paste0("data-raw/", tolower(filename), ".csv"))
  }

  } else {
    print("File already exists!")
  }
}
