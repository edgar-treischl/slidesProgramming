# Load packages
library(dplyr)
library(readr)
library(purrr)
library(gapminder)

# Folder containing your CSVs
input_dir <- "gapminder_by_country_year"

# List all CSV files
files <- list.files(input_dir, pattern = "\\.csv$", full.names = TRUE)

# Create a dummy vector of the same length to pair with files
dummy <- seq_along(files)

# Read each CSV with map2 and store in a list
data_list <- map2(files, dummy, ~ read_csv(.x, show_col_types = FALSE))

# Combine all data frames into one
gapminder_combined <- bind_rows(data_list)

# Inspect combined data
glimpse(gapminder_combined)
