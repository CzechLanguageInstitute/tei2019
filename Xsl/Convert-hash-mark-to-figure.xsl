<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" exclude-result-prefixes="xd" version="1.0">
  <xsl:import href="Copy-xml-nodes.xsl" />
  <xd:doc scope="stylesheet">
    <xd:desc>
      <xd:p>
        <xd:b>Created on:</xd:b> Jan 22, 2015</xd:p>
      <xd:p>
        <xd:b>Author:</xd:b> Boris</xd:p>
      <xd:p></xd:p>
    </xd:desc>
  </xd:doc>
  <xsl:output omit-xml-declaration="no" indent="yes" />
  <xsl:strip-space elements="*" />
  <xsl:template match="/">
    <xsl:comment> Convert-hash-mark-to-figure </xsl:comment>
    <xsl:apply-templates />
  </xsl:template>
  <xsl:template match="ref[@target]/text()" priority="15">
    <xsl:value-of select="." />
  </xsl:template>
  <xsl:template match="text()" priority="10">
    <xsl:call-template name="generovat-obrazek">
      <xsl:with-param name="text" select="." />
    </xsl:call-template>
  </xsl:template>
  <xsl:template name="generovat-obrazek">
    <xsl:param name="text" />
    <xsl:choose>
      <xsl:when test="contains($text, '#')">
        <xsl:value-of select="substring-before($text,'#')" />
        <xsl:element name="figure" />
        <xsl:call-template name="generovat-obrazek">
          <xsl:with-param name="text" select="substring-after($text, '#')" />
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$text" />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
</xsl:stylesheet>