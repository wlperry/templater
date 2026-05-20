# Graphing for: {{title}}
# Date: {{date_chr}}

library(scales)
library(ggsave)
library(patchwork)
library(janitor)
library(tidyverse)

# Theme setup -------------------------------------------------------------
source("themes/r_themes_for_3_sizes.R")

# Load cleaned data -------------------------------------------------------
# data <- read_rds("output/cleaned_data.rds")

# Theme setup -------------------------------------------------------------

# Plotting ----------------------------------------------------------------
# ggplot(data, aes(x = , y = )) +
#   geom_col() +
#   labs(title = "{{title}}")
