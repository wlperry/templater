#' @export
templater <- function(date_chr, project_name, readme = TRUE) {
  
  # 1. Validation
  if (is.na(as.Date(date_chr, format = "%Y-%m-%d"))) {
    stop("'date_chr' must be in yyyy-mm-dd format.")
  }
  
  # 2. Define Variables
  yr <- sub("-.*", "", date_chr)
  date_strip <- stringr::str_remove_all(date_chr, "-")
  folder_name <- paste0(date_chr, "_", project_name)
  
  # 3. Create Folder Structure
  subfolders <- c("data", "documents", "figures", "output", "scripts")
  for (sub in subfolders) {
    dir.create(file.path(folder_name, sub), recursive = TRUE, showWarnings = FALSE)
  }
  
  # 4. Process the .R Script
  template_path <- system.file("r-template.R", package = "templater", mustWork = TRUE)
  r_txt <- readLines(template_path)
  
  # FIX: Match the placeholders exactly as they appear in your template
  r_txt <- gsub("{{yr}}", paste0("\"", yr, "\""), r_txt, fixed = TRUE)
  r_txt <- gsub("{{date_chr}}", paste0("\"", date_chr, "\""), r_txt, fixed = TRUE)
  r_txt <- gsub("{{date_strip}}", paste0("\"", date_strip, "\""), r_txt, fixed = TRUE)
  r_txt <- gsub("{{title}}", project_name, r_txt, fixed = TRUE)
  
  # NEW: Specific filename as requested
  new_r_file <- file.path(folder_name, "scripts", "01_import_and_clean.R")
  writeLines(r_txt, con = new_r_file)
  
  # 5. Process the README
  if (readme) {
    readme_path <- system.file("readme-template.md", package = "templater", mustWork = TRUE)
    readme_txt <- readLines(readme_path)
    
    # FIX: Matching README placeholders
    readme_txt <- gsub("{{title}}", project_name, readme_txt, fixed = TRUE)
    readme_txt <- gsub("{{date_strip}}", date_strip, readme_txt, fixed = TRUE)
    readme_txt <- gsub("{{date_chr}}", date_chr, readme_txt, fixed = TRUE)
    readme_txt <- gsub("{{yr}}", yr, readme_txt, fixed = TRUE)
    
    writeLines(readme_txt, con = file.path(folder_name, "README.md"))
  }
  
  message("✅ Project '", folder_name, "' created with 01_import_and_clean.R")
}