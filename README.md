# Biostatistics, Machine Learning and Shiny in R

## Description

This repository contains the development of PEC3 for the Software for Data Analysis course, part of the UOC-UB Master's Degree in Bioinformatics and Biostatistics.

The project is implemented mainly in R Markdown and includes practical exercises on machine learning, statistical analysis, interactive Shiny applications, and genomic data analysis with Bioconductor. The main output of the repository is a reproducible PDF report generated from the source Rmd document, together with a standalone Shiny app.

## Project Contents

The report is organized into three main blocks:

1. Classification models and validation.
2. Shiny applications and ethics.
3. Bioconductor and genomic data analysis.

These sections include exercises on:

- building and validating a classification model for the Breast Cancer Wisconsin dataset;
- comparing soil moisture across vegetation covers using ANOVA and post-hoc analysis;
- developing an interactive Shiny application for exploratory analysis of the iris dataset;
- discussing ethical considerations in the design and deployment of Shiny applications;
- simulating RNA-seq count data and performing differential expression analysis with DESeq2.

## Repository Structure

- `app/shiny_app.R`: standalone Shiny application for interactive exploration of the iris dataset.
- `assets/images/`: images and graphical resources used in the report.
- `reports/PEC3_biostatistics_ml_r.Rmd`: source document for the analysis.
- `reports/PEC3_biostatistics_ml_r.pdf`: generated PDF report.
- `reports/preamble.tex`: LaTeX configuration used to compile the report.
- `README.md`: general project description.

## Requirements

To reproduce the report and run the application, you need at least:

- R
- RStudio or another environment compatible with R Markdown and Shiny
- the `rmarkdown` package
- the `knitr` package
- the `tidyverse` package
- the `caret`, `randomForest`, and `mlbench` packages
- the `shiny`, `DT`, `ggplot2`, and `shinythemes` packages
- the `BiocManager` package and the `DESeq2` Bioconductor package
- a LaTeX distribution to generate the PDF output

## Reproducibility

1. Open `reports/PEC3_biostatistics_ml_r.Rmd` in RStudio.
2. Install the required CRAN and Bioconductor packages if they are not already available.
3. Knit or render the document to generate the report.

Optionally, it can be compiled from the console with:

```r
rmarkdown::render("reports/PEC3_biostatistics_ml_r.Rmd")
```

To launch the Shiny application locally:

```r
shiny::runApp("app/shiny_app.R")
```

## Author

Marta Barea Sepúlveda, PhD<br>
Interuniversity Master's Degree in Bioinformatics and Biostatistics<br>
Universitat Oberta de Catalunya - Universitat de Barcelona
