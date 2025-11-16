# Load required packages
library(gapminder)
library(dplyr)
library(purrr)
library(glue)

# Create output directory
output_dir <- "gapminder_by_country_year"
if (!dir.exists(output_dir)) dir.create(output_dir)

# Split data by country and year
gapminder_split <- gapminder %>%
  group_split(country, year)

# Use purrr::walk to write each data frame to a CSV file
walk(gapminder_split, function(df) {
  country <- unique(df$country)
  year <- unique(df$year)
  
  # Create safe filename (replace spaces)
  safe_name <- gsub(" ", "_", country)
  file_name <- glue("{safe_name}_{year}.csv")
  file_path <- file.path(output_dir, file_name)
  
  # Write to CSV
  write.csv(df, file_path, row.names = FALSE)
})

cat("CSV files created in:", output_dir, "\n")
