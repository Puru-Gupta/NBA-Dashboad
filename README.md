# Shiny App: Free Throw Analysis

This is a Shiny web application analyzing basketball free throw data.

---

## 🏗 Project Structure

- `app.R` — Main app file that loads UI, server, modules, and data.
- `ui.R` — Defines the UI (user interface).
- `server.R` — Defines the server logic.
- `modules/` — Contains modularized components for reusability.
- `data/` — Stores the `free_throws.parquet` dataset.

---

## 📦 Required Packages

Make sure you have the following R packages installed:

```r
install.packages(c(
  "shiny", "shinydashboard", "shinydashboardPlus", "tidyverse", "data.table",
  "shinyWidgets", "shinycssloaders", "arrow", "RColorBrewer", "htmltools",
  "tidyr", "stringr", "shinyjs", "shinyBS", "highr", "highcharter", "reactable",
  "profvis", "shinytest2"
))
