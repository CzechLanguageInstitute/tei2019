<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" exclude-result-prefixes="xd" version="1.0">
  <xsl:import href="Copy-xml-nodes.xsl" />
  <xd:doc scope="stylesheet">
    <xd:desc>
      <xd:p>
        <xd:b>Created on:</xd:b> Feb 24, 2018</xd:p>
      <xd:p>
        <xd:b>Author:</xd:b> Boris</xd:p>
      <xd:p></xd:p>
    </xd:desc>
  </xd:doc>
  <xsl:strip-space elements="*" />
  <xsl:output method="xml" indent="yes" />
  <xsl:template match="poznamka[following-sibling::*[1][starts-with(name(), 'poznamka')]]   [not(preceding-sibling::*[1][starts-with(name(), 'poznamka')])]">
    <xsl:choose>
      <xsl:when test="preceding-sibling::*[1][starts-with(name(), 'poznamka')]">
        <xsl:apply-templates select="following-sibling::*[1]" mode="get-text" />
      </xsl:when>
      <xsl:otherwise>
        <xsl:copy>
          <xsl:apply-templates />
          <xsl:apply-templates select="following-sibling::*[1]" mode="get-text" />
        </xsl:copy>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template match="*[starts-with(name(), 'poznamka')]   [preceding-sibling::*[1][starts-with(name(), 'poznamka')]]" priority="5">
    <!--<xsl:apply-templates />
		<xsl:apply-templates select="following-sibling::*[1][starts-with(name(), 'transliterace')]" />-->
  </xsl:template>
  <xsl:template match="*[starts-with(name(), 'poznamka')]   [preceding-sibling::*[1][starts-with(name(), 'poznamka')]]" priority="5" mode="get-text">
    <xsl:apply-templates />
    <xsl:apply-templates select="following-sibling::*[1][starts-with(name(), 'poznamka')]" mode="get-text" />
  </xsl:template>
</xsl:stylesheet>