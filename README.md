# templater

A custom R package to automate the creation of standardized project directories. 
Inspired by Nicola Rennie's TidyTuesday workflow.

## Package Structure
The package is built with the following structure:
```text
templater/
├── DESCRIPTION           # Package metadata and dependencies
├── NAMESPACE             # Exported functions (auto-generated)
├── R/
│   └── use_project_template.R  # The core function: templater()
├── inst/                 # Raw templates used by the function
│   ├── r-template.R
│   ├── graphing-template.R
│   └── readme-template.md
└── templater.Rproj

# run this to update documentation 
devtools::document()
# run this to install the package locally
devtools::install()

# from local 
library(templater)
templater("my_project_name")
This creates:
- A root folder named my_project_name.
- 5 subfolders: data, documents, figures, output, scripts.
- 01_import_and_clean.R and 02_graphing.R inside scripts/.

A formatted README.md.

# GitHub Sync Instructions
To push changes to GitHub or fix "non-fast-forward" errors:
git add .
git commit -m "Description of changes"
# Use --force for the first-time sync if GitHub has a different history
git push -u origin main --force

Installation from GitHub
Others (or you on another machine) can install this via:
remotes::install_github("your-username/templater")
library(templater)

