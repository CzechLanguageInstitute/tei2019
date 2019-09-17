<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:ev="http://www.daliboris.cz/schemata/prepisy.xsd" exclude-result-prefixes="xd ev" version="1.0">
  <xd:doc scope="stylesheet">
    <xd:desc>
      <xd:p>
        <xd:b>Created on:</xd:b> Dec 2, 2010</xd:p>
      <xd:p>
        <xd:b>Author:</xd:b> boris</xd:p>
      <xd:p>Vytvoří titulní stránku</xd:p>
    </xd:desc>
  </xd:doc>
  <xsl:param name="soubor" />
  <xsl:output indent="yes" />
  <xsl:strip-space elements="*" />
  <xsl:template match="/">
    <xsl:comment> Generate-front-TEI </xsl:comment>
    <xsl:apply-templates select="/ev:Prepisy/ev:Prepis[ev:Soubor/ev:Nazev = $soubor]" />
  </xsl:template>
  <xsl:template match="/ev:Prepisy">
    <xsl:apply-templates select="ev:Prepis[ev:Soubor/ev:Nazev = $soubor]" />
  </xsl:template>
  <xsl:template match="ev:Prepis">
    <front>
      <docTitle>
        <titlePart>
          <xsl:value-of select="ev:Hlavicka/ev:Titul" />
        </titlePart>
      </docTitle>
      <xsl:apply-templates select="ev:Hlavicka/ev:Autor" mode="front" />
    </front>
  </xsl:template>
  <xsl:template match="ev:Autor" mode="front">
    <docAuthor>
      <xsl:value-of select="." />
    </docAuthor>
  </xsl:template>
</xsl:stylesheet>