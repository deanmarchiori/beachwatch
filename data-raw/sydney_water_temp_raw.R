## code to prepare `sydney_water_temp_raw` dataset goes here
library(readr)
library(here)
library(dplyr)
library(lubridate)

sydney_water_temp_raw <- read_csv(here("data-raw", "Waterquality1727670437021.csv"))

sydney_water_temp <- sydney_water_temp_raw |>
  transmute(temp = `Water temperature (°C)`,
            beach = `Swim site`,
            date = Date,
            time = Time) |>
  mutate(date = dmy(date),
         month = month(date),
         hour = hour(time),
         month_lab = month(date, label = TRUE),
         beach = as.factor(beach)) |>
  filter(temp < 40)

usethis::use_data(sydney_water_temp, overwrite = TRUE)
