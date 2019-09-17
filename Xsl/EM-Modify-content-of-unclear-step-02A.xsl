<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:vwf="http://vokabular.ujc.cas.cz/xslt/functions" exclude-result-prefixes="xd vwf" version="2.0">
  <xsl:import href="Copy-xml-nodes.xsl" />
  <xsl:import href="Text-functions.xsl" />
  <xd:doc scope="stylesheet">
    <xd:desc>
      <xd:p>
        <xd:b>Created on:</xd:b> Mar 25, 2018</xd:p>
      <xd:p>
        <xd:b>Author:</xd:b> Boris</xd:p>
      <xd:p></xd:p>
    </xd:desc>
  </xd:doc>
  <xsl:variable name="mezera" select="' '" />
  <xsl:variable name="interpunkcePlusMezera" select="concat('.,;?!)', $mezera)" />
  <xsl:strip-space elements="*" />
  <xsl:output method="xml" indent="no" />
  <xsl:template match="/">
    <xsl:comment> EM-Modify-content-of-unclear-step-02A </xsl:comment>
    <xsl:apply-templates />
  </xsl:template>
  <!--
		unclear[not(@position)][preceding-sibling::node()[not(normalize-space(.) = '')][1][self::text()] [substring(., string-length(.), 1) != ' '] ]
	-->
  <xd:doc>
    <xd:desc>
      <xd:pre>
        <text>a súdce jich s mi<unclear><supplied>stry</supplied></unclear>, </text>
      </xd:pre>
    </xd:desc>
    <xd:desc>
      <xd:p>Text, který nekončí mezerou a na který navazuje element <xd:b>unclear</xd:b>, text před mezerou bude představovat začátek celého doplněného výrazu.</xd:p>
    </xd:desc>
  </xd:doc>
  <xsl:template match="//text() [not(normalize-space(.) = '')] [substring(., string-length(.), 1) != ' '] [following-sibling::node()   [not(normalize-space(.) = '')][1][self::unclear[not(@position)]] ]">
    <xsl:variable name="substring-before">
      <xsl:value-of select="concat(vwf:substring-before-last(., $mezera), $mezera)" />
    </xsl:variable>
    <xsl:variable name="substring-after">
      <xsl:value-of select="substring-after(., $substring-before)" />
    </xsl:variable>
    <xsl:choose>
      <xsl:when test="$substring-before = $mezera">
        <hi xml:space="preserve">
          <xsl:value-of select="$mezera" />
        </hi>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$substring-before" />
      </xsl:otherwise>
    </xsl:choose>
    <xsl:element name="unclear">
      <xsl:attribute name="position" select="'initial'" />
      <xsl:value-of select="$substring-after" />
    </xsl:element>
  </xsl:template>
</xsl:stylesheet>