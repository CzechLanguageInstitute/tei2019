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
    <xsl:comment> EM-Modify-content-of-unclear-step-02B </xsl:comment>
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
      <xd:p>Elementy <xd:b>unclear</xd:b>, které končí mezerou a nimiž je počáteční element <xd:b>unclear</xd:b>.</xd:p>
    </xd:desc>
  </xd:doc>
  <xsl:template match="//unclear  [not(@position)]  [ends-with(., ' ')]  [   preceding-sibling::node()[1]   [self::unclear[@position='initial']]  ] ">
    <xsl:copy>
      <xsl:copy-of select="@*" />
      <xsl:attribute name="position" select="'final'" />
      <xsl:apply-templates />
    </xsl:copy>
  </xsl:template>
</xsl:stylesheet>