#' Create a standardized project directory
#' @param project_name The name of the project (and the root folder)
#' @param path Directory where the project is created. Defaults to the Desktop.
#' @param readme Logical; should a README be generated?
#' @export
templater <- function(project_name, path = "~/Desktop", readme = TRUE) {
  # 1. Automatically grab today's date
  date_chr <- as.character(Sys.Date())

  # 2. Define Variables based on today's date
  yr <- format(Sys.Date(), "%Y")
  date_strip <- stringr::str_remove_all(date_chr, "-")

  # 3. Path Handling (Cross-Platform mapping to Desktop)
  target_dir <- path.expand(path)
  folder_path <- file.path(target_dir, project_name)

  # 4. SAFETY CHECK: Prevent overwriting existing projects
  if (dir.exists(folder_path)) {
    stop(
      "🛑 A project named '",
      project_name,
      "' already exists at:\n   ",
      folder_path,
      "\nPlease choose a new name or delete the existing folder.",
      call. = FALSE
    )
  }

  # 5. Create Folder Structure using the new folder_path
  # MODIFIED: Added "themes" to the subfolders vector
  subfolders <- c("data", "documents", "figures", "output", "scripts", "themes")
  for (sub in subfolders) {
    sub_dir_path <- file.path(folder_path, sub)

    # Create the directory
    dir.create(
      sub_dir_path,
      recursive = TRUE,
      showWarnings = FALSE
    )

    # Create the .gitkeep file so Git tracks the folder
    file.create(file.path(sub_dir_path, ".gitkeep"), showWarnings = FALSE)
  }

  # 6. Helper for replacements (to keep code clean)
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

  # 7. Create 01_import_and_clean.R
  path1 <- system.file("r-template.R", package = "templater", mustWork = TRUE)
  writeLines(
    apply_templating(readLines(path1)),
    file.path(folder_path, "scripts", "01_import_and_clean.R")
  )

  # 8. Create 02_graphing.R
  path2 <- system.file(
    "graphing-template.R",
    package = "templater",
    mustWork = TRUE
  )
  writeLines(
    apply_templating(readLines(path2)),
    file.path(folder_path, "scripts", "02_graphing.R")
  )

  # 9. Create README
  if (readme) {
    path_rm <- system.file(
      "readme-template.md",
      package = "templater",
      mustWork = TRUE
    )
    writeLines(
      apply_templating(readLines(path_rm)),
      file.path(folder_path, "README.md")
    )
  }

  # 10. NEW: Copy r_themes_for_3_sizes.R into the themes subfolder
  path_themes <- system.file(
    "themes",
    "r_themes_for_3_sizes.R",
    package = "templater",
    mustWork = TRUE
  )

  file.copy(
    from = path_themes,
    to = file.path(folder_path, "themes", "r_themes_for_3_sizes.R"),
    overwrite = TRUE
  )

  message(
    "✅ Project '",
    project_name,
    "' created successfully at:\n   ",
    folder_path
  )
}
