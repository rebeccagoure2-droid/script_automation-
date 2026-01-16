# Load required packages
if (!require("rvest")) install.packages("rvest")
library(rvest)

# URL to scrape
url <- "https://en.wikipedia.org/wiki/D.Gray-man"

# Read webpage
page <- read_html(url)

# Extract main content text
text_content <- page %>%
  html_nodes("div#mw-content-text .mw-parser-output") %>%
  html_text(trim = TRUE)

# Create data folder if it doesn't exist
if (!dir.exists("data")) {
  dir.create("data")
}

# Find existing scrape files in data folder
existing_files <- list.files(
  path = "data",
  pattern = "^dgrayman_scrape[0-9]+\\.txt$"
)

# Determine next scrape number
if (length(existing_files) == 0) {
  n <- 1
} else {
  numbers <- as.numeric(gsub("\\D", "", existing_files))
  n <- max(numbers) + 1
}

# Create file name inside data folder
file_name <- paste0("data/dgrayman_scrape", n, ".txt")

# Save content
writeLines(text_content, file_name)

cat("Scraped content saved as", file_name, "\n")


