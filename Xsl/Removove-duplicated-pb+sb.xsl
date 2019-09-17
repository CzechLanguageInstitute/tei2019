<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" exclude-result-prefixes="xd" version="1.0">
  <xsl:import href="Copy-xml-nodes.xsl" />
  <xd:doc scope="stylesheet">
    <xd:desc>
      <xd:p>
        <xd:b>Created on:</xd:b> Jan 22, 2015</xd:p>
      <xd:p>
        <xd:b>Author:</xd:b> Boris</xd:p>
      <xd:p>Odstranit dvojí foliaci v případech, kdy styl foliace obsahuje za lomítkem písmeno sloupce a stranu před lomítkem (tj. případy 1r/a, 1r/b místo 1r/a b).</xd:p>
    </xd:desc>
  </xd:doc>
  <xsl:output omit-xml-declaration="no" indent="no" />
  <xsl:template match="/">
    <xsl:comment> Removove-duplicated-pb+sb </xsl:comment>
    <xsl:apply-templates />
  </xsl:template>
  <xsl:template match="pb[following-sibling::*[1]/self::cb]">
    <xsl:choose>
      <xsl:when test="preceding::pb[1]/@n = @n" />
      <xsl:otherwise>
        <xsl:copy>
          <xsl:copy-of select="@*" />
        </xsl:copy>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
</xsl:stylesheet>