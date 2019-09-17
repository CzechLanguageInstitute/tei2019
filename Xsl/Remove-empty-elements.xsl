<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" exclude-result-prefixes="xd" version="1.0">
  <!--<xsl:import href="Kopirovani_prvku.xsl"/>-->
  <xsl:import href="Remove-all-empty-elements.xsl" />
  <xd:doc scope="stylesheet">
    <xd:desc>
      <xd:p>
        <xd:b>Created on:</xd:b> Dec 4, 2010</xd:p>
      <xd:p>
        <xd:b>Author:</xd:b> boris</xd:p>
      <xd:p>Jakékoli jiné prázdné elementy kromě odstavců a buněk se odstraní.</xd:p>
    </xd:desc>
  </xd:doc>
  <xsl:template match="/">
    <xsl:comment> Remove-empty-elements </xsl:comment>
    <xsl:apply-templates />
  </xsl:template>
  <xd:doc>
    <xd:desc>
      <xd:p>Prázdné odstavce se zachovají.</xd:p>
    </xd:desc>
  </xd:doc>
  <xsl:template match="Normalni[. = '']" priority="2">
    <xsl:element name="{name(.)}" />
  </xsl:template>
  <xd:doc>
    <xd:desc>
      <xd:p>Prázdné buňky v tabulce se zachovají.</xd:p>
    </xd:desc>
  </xd:doc>
  <xsl:template match="cell[.='']" priority="2">
    <xsl:copy-of select="." />
  </xsl:template>
  <xsl:template match="Volny_radek" priority="2">
    <xsl:copy-of select="." />
  </xsl:template>
</xsl:stylesheet>