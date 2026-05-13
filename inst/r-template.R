# Analysis: {{title}}
# Date: {{date_chr}}

# Load packages -----------------------------------------------------------
library(scales)
library(ggsave)
library(patchwork)
library(janitor)
library(tidyverse)


# Load data ---------------------------------------------------------------
# This will now correctly show: tt_load("2026-05-13")
tuesdata <- tt_load({{ date_chr }})

# Set up paths for later use ----------------------------------------------
yr <- {
  {
    yr
  }
}
date_strip <- {
  {
    date_strip
  }
}

# Data wrangling ----------------------------------------------------------
