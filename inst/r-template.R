# Analysis: {{title}}
# Date: {{date_chr}}

# Load packages -----------------------------------------------------------
library(scales)
library(ggsave)
library(patchwork)
library(janitor)
library(tidyverse)

# load themes -------------------------------------------------------------
source("themes/r_themes_for_3_sizes.R")

# Load data ---------------------------------------------------------------
df <- read_csv("data/   ") %>%
  clean_names()

# Clean data -------------------------------------------------------------

# Plot data --------------------------------------------------------------
