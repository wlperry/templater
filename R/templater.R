#' Create a standardized project directory
#' @export
templater <- function(date_chr, project_name, readme = TRUE) {
  # 1. Validation
  if (is.na(as.Date(date_chr, format = "%Y-%m-%d"))) {
    stop("'date_chr' must be in yyyy-mm-dd format.")
  }

  # 2. Define Variables
  yr <- sub("-.*", "", date_chr)
  date_strip <- stringr::str_remove_all(date_chr, "-")

  # CHANGE: Folder is now just the project name
  folder_name <- project_name

  # 3. Create Folder Structure
  subfolders <- c("data", "documents", "figures", "output", "scripts")
  for (sub in subfolders) {
    dir.create(
      file.path(folder_name, sub),
      recursive = TRUE,
      showWarnings = FALSE
    )
  }

  # 4. Helper for replacements (to keep code clean)
  apply_templating <- function(text) {
    text <- gsub("{{yr}}", paste0("\"", yr, "\""), text, fixed = TRUE)
    text <- gsub(
      "{{date_chr}}",
      paste0("\"", date_chr, "\""),
      text,
      fixed = TRUE
    )
    text <- gsub(
      "{{date_strip}}",
      paste0("\"", date_strip, "\""),
      text,
      fixed = TRUE
    )
    text <- gsub("{{title}}", project_name, text, fixed = TRUE)
    return(text)
  }

  # 5. Create 01_import_and_clean.R
  path1 <- system.file("r-template.R", package = "templater", mustWork = TRUE)
  writeLines(
    apply_templating(readLines(path1)),
    file.path(folder_name, "scripts", "01_import_and_clean.R")
  )

  # 6. Create 02_graphing.R
  path2 <- system.file(
    "graphing-template.R",
    package = "templater",
    mustWork = TRUE
  )
  writeLines(
    apply_templating(readLines(path2)),
    file.path(folder_name, "scripts", "02_graphing.R")
  )

  # 7. Create README
  if (readme) {
    path_rm <- system.file(
      "readme-template.md",
      package = "templater",
      mustWork = TRUE
    )
    writeLines(
      apply_templating(readLines(path_rm)),
      file.path(folder_name, "README.md")
    )
  }

  message("✅ Project '", folder_name, "' created successfully!")
}
