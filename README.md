# IR Specialist – Taxonomic Text Similarity Analysis

This project was completed for **CIND110: Data Organization for Data Analysts** at Toronto Metropolitan University. The objective was to perform text mining and similarity analysis across botanical family descriptions to identify closely related families using TF-IDF and cosine similarity.

---

## 🧠 Project Overview

As an IR (Information Retrieval) Specialist, I analyzed XML-structured botanical data to discover which plant families were most similar to the **Apocynaceae** family. The analysis combined structured data extraction with text preprocessing and document similarity techniques.

---

## 🛠 Tools & Techniques Used

| Component | Description |
|----------|-------------|
| **R & RStudio** | Main programming environment |
| **XML Parsing** | Extracted family descriptions using BaseX |
| **Text Mining** (`tm`, `textstem`) | Cleaned and lemmatized text data |
| **TF-IDF** | Computed term weighting for similarity analysis |
| **Cosine Similarity** | Quantified closeness between family texts |
| **Visualization** | Plotted top similar families and heatmaps with `ggplot2` |

---

## 📊 Key Steps

1. **Extracted XML data** using BaseX and imported it into R.
2. **Preprocessed** text: tokenization, lowercasing, punctuation removal, lemmatization.
3. Computed **TF-IDF matrices** for family descriptions.
4. Measured **cosine similarity** against Apocynaceae to find related families.
5. Created **bar charts** and **heatmaps** to visualize top similar families and shared vocabulary.

---

## 📂 Files

| File | Description |
|------|-------------|
| `IR_Specialist_AbdallaElgharbawy.Rmd` | RMarkdown source file (code + commentary) |
| `IR_Specialist_AbdallaElgharbawy.html` | Rendered HTML report with visualizations |
| `IR_Specialist_AbdallaElgharbawy - Code and Output Overview.pdf` | Summary document with code chunks, explanation, and visual output |

---

## 🚀 Outcomes

This project demonstrates applied skills in:
- XML data extraction
- Text preprocessing and lemmatization
- TF-IDF and cosine similarity modeling
- Effective visualization of document similarity

