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

# Find existing scrape files
existing_files <- list.files(
  pattern = "^dgrayman_scrape[0-9]+\\.txt$"
)

# Determine next scrape number
if (length(existing_files) == 0) {
  n <- 1
} else {
  numbers <- as.numeric(gsub("\\D", "", existing_files))
  n <- max(numbers) + 1
}

# Create intuitive dynamic file name
file_name <- paste0("dgrayman_scrape", n, ".txt")

# Save content
writeLines(text_content, file_name)

cat("Scraped content saved as", file_name, "\n")
