<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" exclude-result-prefixes="xs xd" version="2.0">
  <xd:doc scope="stylesheet">
    <xd:desc>
      <xd:p>
        <xd:b>Created on:</xd:b> May 26, 2014</xd:p>
      <xd:p>
        <xd:b>Author:</xd:b> Boris</xd:p>
      <xd:p></xd:p>
    </xd:desc>
  </xd:doc>
  <xsl:output indent="yes" />
  <xsl:strip-space elements="*" />
  <xsl:include href="Copy-xml-nodes.xsl" />
  <xd:doc scope="component">
    <xd:desc>Výchozí prvek šablony</xd:desc>
  </xd:doc>
  <xsl:template match="/">
    <xsl:comment> EM-Goup-paragraphs-divided-by-empty-paragrap </xsl:comment>
    <xsl:apply-templates select="comment()" />
    <xsl:apply-templates select="body" />
  </xsl:template>
  <xsl:template match="div[p[@rend='vspace']]">
    <div>
      <xsl:copy-of select="@*" />
      <xsl:choose>
        <xsl:when test="p[@rend='vspace']">
          <xsl:for-each-group select="*" group-ending-with="p[@rend='vspace']">
            <div rend="vspace">
              <!--<xsl:apply-templates select="." />-->
              <!--<xsl:for-each select="current-group()">
								<xsl:copy-of select="." />
							</xsl:for-each>-->
              <xsl:copy-of select="current-group()[not(self::p[@rend='vspace'])]" />
            </div>
          </xsl:for-each-group>
        </xsl:when>
        <xsl:otherwise>
          <xsl:copy-of select="*" />
        </xsl:otherwise>
      </xsl:choose>
    </div>
  </xsl:template>
  <xsl:template match="p[@rend='vspace']" priority="15" />
</xsl:stylesheet>