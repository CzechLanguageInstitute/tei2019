<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xml="http://www.w3.org/XML/1998/namespace" xmlns:c="http://vokabular.ujc.cas.cz/schemas/changes/v1.0/" exclude-result-prefixes="xd" version="1.0">
  <xd:doc scope="stylesheet">
    <xd:desc>
      <xd:p>
        <xd:b>Created on:</xd:b> Dec 3, 2010</xd:p>
      <xd:p>
        <xd:b>Author:</xd:b> boris</xd:p>
      <xd:p />
    </xd:desc>
  </xd:doc>
  <xsl:param name="exportovatTransliteraci" select="true()" />
  <!-- 'true()' nebo 'false()' -->
  <xsl:include href="Transpose-styles-to-TEI-elements.xsl" />
  <xsl:include href="EM+EB-Transpose-styles-to-TEI-elements-Common.xsl" />
  <xsl:output omit-xml-declaration="no" indent="no" />
  <xsl:strip-space elements="*" />
  <xsl:template match="/">
    <xsl:comment> EM-Transpose-styles-to-TEI-elements; parameters: exportovatTransliteraci = '<xsl:value-of select="$exportovatTransliteraci" />' </xsl:comment>
    <xsl:apply-templates />
  </xsl:template>
  <!-- Ignorované styly -->
  <!-- Anotace je určena jenom pro e-shop Academie -->
  <xsl:template match="Anotace" />
  <xsl:template match="Komercni_titul" />
  <xsl:template match="comment()">
    <xsl:copy-of select="." />
  </xsl:template>
  <xsl:template match="annotation_reference" />
  <xsl:template match="identifikator">
    <anchor type="structure">
      <xsl:attribute name="n">
        <xsl:value-of select="normalize-space(.)" />
      </xsl:attribute>
    </anchor>
  </xsl:template>
  <!-- obsahuje titulek obrázku vloženému do dokumentu; obrázek a jeho titulek se objeví pouze v elektronických knihách; -->
  <xsl:template match="Titulek_obrazku" />
</xsl:stylesheet>