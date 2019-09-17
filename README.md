# Using Microsoft Word for preparing XML TEI-compliant digital editions
Boris Lehečka, Czech Language Institute, Czech Republic

TEI Conference and Members' Meeting 2019

## External resources
-  Černá, A. and Lehečka, B. (2016). *Metodika přípravy a zpracování elektronických edic starších českých textů*. (*The Methodology of the preparation and processing of electronic editions of Old Czech texts*.) [pdf] Praha: oddělení vývoje jazyka Ústavu pro jazyk český AV ČR, v. v. i. Available at: <[http://vokabular.ujc.cas.cz/soubory/nastroje/Methodics/Metodika_pripravy_a_zpracovani_elektronickych_edic_DF12P01OVV028.pdf](http://vokabular.ujc.cas.cz/soubory/nastroje/Methodics/Metodika_pripravy_a_zpracovani_elektronickych_edic_DF12P01OVV028.pdf)>
- *eEdice*. An add-in for Microsoft Word 2010 and higher, containing definitions of the paragraph and character styles and some tools facilitating the text and metadata editing. Available at: <[https://vokabular.ujc.cas.cz/moduly/nastroje/e-edice/ke-stazeni](https://vokabular.ujc.cas.cz/moduly/nastroje/e-edice/ke-stazeni)>.


## Content of the accompanying material
- **Register**: XML file with metadata about the digital editions.
- **Transformations**: XML file with the definition of the transformation process. Whole process is represented by one or more transformation. Each *transformation* consists of one or more *step*s (i. e. XSLT transformations).
- **Xsl**: Directory with XSLT files used during the transformation process.
- **Conversion**: Directory with input DOCX documents, result of individual transformation steps and the final XML TEI.
  - **DOCX**: DOCX documents (so called *electronic editions*)
  - **Input**: Result of the conversion of DOCX to flat XML document (elements represents paragraph and character styles, footnotes, comments, or table).
  - **Temp**: Result of individual transformation steps. Each DOCX file has its own directory. Each transformation, consisting of several steps, shares the same suffix in the file name.
  - **Output**: Final XML TEI documents.