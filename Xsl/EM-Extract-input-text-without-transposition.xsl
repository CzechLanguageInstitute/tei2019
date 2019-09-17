<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" exclude-result-prefixes="xd" version="1.0">
  <xsl:import href="EM-Extract-input-text-Insert-paragraph-type.xsl" />
  <xd:doc scope="stylesheet">
    <xd:desc>
      <xd:p>
        <xd:b>Created on:</xd:b> Apr 14, 2018</xd:p>
      <xd:p>
        <xd:b>Author:</xd:b> Boris</xd:p>
      <xd:p></xd:p>
    </xd:desc>
  </xd:doc>
  <xsl:output method="xml" indent="yes" />
  <xsl:strip-space elements="*" />
  <xsl:key name="poznamka" match="poznamka_pod_carou" use="@id" />
  <xd:doc>
    <xd:desc>
      <xd:p>Výchozí element pro konverzi textu. Rozděluje text na hlavní text a poznámky.</xd:p>
    </xd:desc>
  </xd:doc>
  <xsl:template match="/">
    <body>
      <text>
        <xsl:apply-templates />
      </text>
    </body>
  </xsl:template>
  <xsl:template match="body/*">
    <p>
      <xsl:call-template name="insert-paragraph-type" />
      <xsl:apply-templates />
    </p>
  </xsl:template>
  <xsl:template match="*[@xml:space='preserve']">
    <xsl:value-of select="." />
  </xsl:template>
</xsl:stylesheet>