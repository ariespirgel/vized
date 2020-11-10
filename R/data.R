#' @importFrom tibble tibble
NULL

#' IPEDS Coordinates
#'
#' Latitude and longitude for IPEDS institutions in the Lower 48 states.
#'
#' @source IPEDS Data Center,
#'  <https://nces.ed.gov/ipeds/datacenter/DataFiles.aspx?goToReportId=7>
#' @format Data frame with columns
#' \describe{
#' \item{unit_id}{IPEDS unit ID number.}
#' \item{institution_name}{Name of school.}
#' \item{sector_description}{Sector of institution.}
#' \item{state_description}{State of institution.}
#' \item{latitude, longitude}{Latitude and longitude of institution.}
#' }
"ipeds_coordinates"

#' IPEDS Directory
#'
#' IPEDS directory information.
#'
#' @source IPEDS Data Center,
#'  <https://nces.ed.gov/ipeds/datacenter/DataFiles.aspx?goToReportId=7>
#' @format Data frame with columns
#' \describe{
#' \item{unit_id}{IPEDS unit ID number.}
#' \item{institution_name}{Name of school.}
#' \item{year}{Year of data.}
#' \item{sector_description}{Sector of institution}
#' \item{state_description}{State of institution.}
#' \item{latitude, longitude}{Latitude and longitude of institution.}
#' }
"ipeds_directory"

#' IPEDS Distance
#'
#' IPEDS distance education headcounts.
#'
#' @source IPEDS Data Center,
#'  <https://nces.ed.gov/ipeds/datacenter/DataFiles.aspx?goToReportId=7>
#' @format Data frame with columns
#' \describe{
#' \item{unit_id}{IPEDS unit ID number.}
#' \item{institution_name}{Name of school.}
#' \item{year}{Year of data.}
#' \item{sector_description}{Sector of institution.}
#' \item{level}{Student level.}
#' \item{distance_type}{No distance, some distance, or all distance.}
#' \item{headcount}{Number of students.}
#' }
"ipeds_distance"

#' IPEDS Funnel
#'
#' IPEDS first-time in college applied, admitted, enrolled data for 4-year
#' public and 4-year private not-for-profit schools.
#'
#' @source IPEDS Data Center,
#'  <https://nces.ed.gov/ipeds/datacenter/DataFiles.aspx?goToReportId=7>
#' @format Data frame with columns
#' \describe{
#' \item{unit_id}{IPEDS unit ID number.}

#' \item{institution_name}{Name of school.}
#' \item{sector_description}{Sector of institution.}
#' \item{state_description}{State of institution.}
#' \item{ivy_plus_exchange}{Indicates Ivy League and IvyPlus Exchange schools.}
#' \item{applicants_total}{Number of first-time in college applicants.}
#' \item{admissions_total}{Number of first-time in college applicants who were admitted.}
#' \item{enrolled_total}{Number of first-time in college applicants who enrolled.}
#' \item{admit_rate}{The proportion of applicants who were admitted.}
#' \item{yield_rate}{The proportion of admits who enrolled.}
#' }
"ipeds_funnel"

#' IPEDS Salary
#'
#' IPEDS number and salary outlays for full-time nonmedical noninstructional staff by occupation.
#'
#' @source IPEDS Data Center,
#'  <https://nces.ed.gov/ipeds/datacenter/DataFiles.aspx?goToReportId=7>
#' @format Data frame with columns
#' \describe{
#' \item{unit_id}{IPEDS unit ID number.}
#' \item{institution_name}{Name of school.}
#' \item{year}{Year of data.}
#' \item{sector_description}{Sector of institution.}
#' \item{state_description}{State of institution.}
#' \item{headcount}{Number of employees.}
#' \item{salary}{Total salary.}
#' }
"ipeds_salary"

#' IPEDS Sector
#'
#' IPEDS sector code and sector description lookup table.
#'
#' @source IPEDS Data Center,
#'  <https://nces.ed.gov/ipeds/datacenter/DataFiles.aspx?goToReportId=7>
#' @format Data frame with columns
#' \describe{
#' \item{sector_code, sector_description}{Sector code and sector description.}
#' }
"ipeds_sector"

#' IPEDS State
#'
#' US state abbreviation and state description lookup table.
#'
#' @source IPEDS Data Center,
#'  <https://nces.ed.gov/ipeds/datacenter/DataFiles.aspx?goToReportId=7>
#' @format Data frame with columns
#' \describe{
#' \item{state_abbreviation, state_description}{State code and state description.}
#' }
"ipeds_state"

#' IPEDS Test Scores
#'
#' IPEDS SAT scores for first-time in college students
#'
#' @source IPEDS Data Center,
#'  <https://nces.ed.gov/ipeds/datacenter/DataFiles.aspx?goToReportId=7>
#' @format Data frame with columns
#' \describe{
#' \item{unit_id}{IPEDS unit ID number.}
#' \item{institution_name}{Name of school.}
#' \item{percentile}{SAT score percentile.}
#' \item{sat_ebrw}{SAT Evidenced Based Reading score.}
#' \item{sat_math}{SAT Math score.}
#' }
"ipeds_sat"

