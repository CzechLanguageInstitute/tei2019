<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:c="http://vokabular.ujc.cas.cz/schemas/changes/v1.0/" exclude-result-prefixes="xd" version="1.0">
  <xsl:import href="Copy-xml-nodes.xsl" />
  <xd:doc scope="stylesheet">
    <xd:desc>
      <xd:p>
        <xd:b>Created on:</xd:b> Dec 4, 2010</xd:p>
      <xd:p>
        <xd:b>Author:</xd:b> boris</xd:p>
      <xd:p>Převede prvek <xd:b>text</xd:b> na obsah.</xd:p>
    </xd:desc>
  </xd:doc>
  <xsl:output omit-xml-declaration="no" indent="no" />
  <xsl:strip-space elements="*" />
  <xsl:template match="/">
    <xsl:comment> Convert-text-element-to-content </xsl:comment>
    <xsl:apply-templates />
  </xsl:template>
  <xsl:template match="text">
    <xsl:apply-templates />
  </xsl:template>
  <xsl:template match="text[@c:change]" priority="2">
    <xsl:element name="mod">
      <xsl:attribute name="type">
        <xsl:text>change</xsl:text>
      </xsl:attribute>
      <xsl:copy-of select="@*" />
      <xsl:apply-templates />
    </xsl:element>
  </xsl:template>
  <xsl:template match="text[@xml:space='preserve']">
    <xsl:choose>
      <xsl:when test=". = ' '">
        <!--<xsl:text> </xsl:text>-->
        <hi xml:space="preserve"> </hi>
        <!--<xsl:element name="seg">
					<xsl:attribute name="type"><xsl:text>space</xsl:text></xsl:attribute>
					<xsl:copy-of select="@*"/>
					<xsl:apply-templates />
				</xsl:element>-->
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
</xsl:stylesheet>