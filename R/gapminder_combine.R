# Load packages
library(dplyr)
library(purrr)
library(readr)
library(dplyr)
library(gapminder)

# Folder containing your CSVs
input_dir <- "gapminder_by_country_year"

# List all CSV files
files <- list.files(input_dir, pattern = "\\.csv$", full.names = TRUE)

# Read all files and combine
gapminder_combined <- files |> 
  set_names() |>                       # keeps file names as list names (optional)
  map_dfr(read_csv, show_col_types = FALSE)  # read each file and bind rows together

# Inspect combined data
glimpse(gapminder_combined)



#identical(gapminder_combined, gapminder)
all.equal(gapminder_combined, gapminder)


# Checks #####
gapminder_fixed <- gapminder_combined |> 
  mutate(
    country   = as.factor(country),
    continent = as.factor(continent)
  ) |> 
  arrange(country, year)

gapminder_ref <- gapminder |> 
  arrange(country, year)


all.equal(
  as.data.frame(gapminder_fixed),
  as.data.frame(gapminder_ref),
  check.attributes = TRUE,
  check.names = TRUE,
  check.row.order = TRUE
)






