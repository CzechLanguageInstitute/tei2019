<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:tei="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="xd tei" version="1.0">
  <xd:doc scope="stylesheet">
    <xd:desc>
      <xd:p>
        <xd:b>Created on:</xd:b> Jan 27, 2015</xd:p>
      <xd:p>
        <xd:b>Author:</xd:b> Boris</xd:p>
      <xd:p>Vytvoří element <xd:b>projectDesc</xd:b>. Zkopíruje do něm informaci o grantové podpoře </xd:p>
    </xd:desc>
  </xd:doc>
  <xsl:output method="xml" indent="yes" />
  <xsl:output indent="yes" />
  <xsl:strip-space elements="*" />
  <xsl:include href="Copy-xml-nodes.xsl" />
  <xsl:template match="/">
    <xsl:comment> EM-Create-projectDesc </xsl:comment>
    <xsl:apply-templates />
  </xsl:template>
  <xsl:template match="tei:encodingDesc">
    <xsl:copy>
      <xsl:copy-of select="@*" />
      <xsl:if test="not(tei:projectDesc) and //tei:div[@type='editorial' and @subtype='grant'][node()]">
        <xsl:element name="projectDesc" namespace="http://www.tei-c.org/ns/1.0">
          <xsl:apply-templates select="//tei:div[@type='editorial' and @subtype='grant']" mode="copy" />
        </xsl:element>
      </xsl:if>
      <xsl:apply-templates />
    </xsl:copy>
  </xsl:template>
  <xsl:template match="tei:projectDesc">
    <xsl:copy>
      <xsl:copy-of select="@*" />
      <xsl:if test="not(p[@rend='grant']) and //tei:div[@type='editorial' and @subtype='grant'][node()]">
        <xsl:apply-templates select="//tei:div[@type='editorial' and @subtype='grant']" mode="copy" />
      </xsl:if>
    </xsl:copy>
  </xsl:template>
  <xsl:template match="tei:div[@type='editorial' and @subtype='grant']" mode="copy">
    <xsl:apply-templates />
  </xsl:template>
</xsl:stylesheet>