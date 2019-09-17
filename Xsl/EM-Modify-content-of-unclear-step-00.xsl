<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xml="http://www.w3.org/XML/1998/namespace" xmlns:vwf="http://vokabular.ujc.cas.cz/xslt/functions" xmlns:xs="http://www.w3.org/2001/XMLSchema" extension-element-prefixes="vwf" exclude-result-prefixes="xd vwf xs" version="2.0">
  <xsl:import href="Copy-xml-nodes.xsl" />
  <xsl:import href="Text-functions.xsl" />
  <xd:doc scope="stylesheet">
    <xd:desc>
      <xd:p>
        <xd:b>Created on:</xd:b> Apr 13, 2018</xd:p>
      <xd:p>
        <xd:b>Author:</xd:b> Boris</xd:p>
      <xd:p>Rozdlí element <xd:b>uncler</xd:b> na dva samostatné, pokud je uvnitř mezera.</xd:p>
    </xd:desc>
  </xd:doc>
  <xd:doc>
    <xd:desc>
      <xd:p></xd:p>
    </xd:desc>
  </xd:doc>
  <xsl:output omit-xml-declaration="no" indent="no" />
  <xsl:strip-space elements="unclear supplied" />
  <xd:doc>
    <xd:desc>
      <xd:p></xd:p>
    </xd:desc>
  </xd:doc>
  <xsl:variable name="interpunkce" select="'?.,;!:„“‚‘’#'" />
  <xd:doc>
    <xd:desc>
      <xd:p></xd:p>
    </xd:desc>
  </xd:doc>
  <xsl:variable name="mezera" select="' '" />
  <xd:doc>
    <xd:desc>
      <xd:p></xd:p>
    </xd:desc>
  </xd:doc>
  <xsl:variable name="interpunkcePlusMezera" select="concat($interpunkce, $mezera)" />
  <xd:doc>
    <xd:desc>
      <xd:p></xd:p>
    </xd:desc>
  </xd:doc>
  <xsl:template match="/">
    <xsl:comment> EM-Modify-content-of-unclear-step-00 </xsl:comment>
    <xsl:apply-templates />
  </xsl:template>
  <xd:doc>
    <xd:desc>
      <xd:p></xd:p>
    </xd:desc>
  </xd:doc>
  <xsl:template match="unclear[supplied[contains(normalize-space(.), ' ')][not(note)]]">
    <xsl:apply-templates />
  </xsl:template>
  <xsl:template match="unclear/supplied[contains(normalize-space(.), ' ')][not(note)]">
    <xsl:variable name="zacatek">
      <xsl:value-of select="substring-before(., $mezera)" />
    </xsl:variable>
    <unclear position="final">
      <xsl:copy>
        <xsl:copy-of select="@*" />
        <xsl:value-of select="$zacatek" />
      </xsl:copy>
    </unclear>
    <text xml:space="preserve"> </text>
    <unclear position="initial">
      <xsl:copy>
        <xsl:copy-of select="@*" />
        <xsl:value-of select="substring-after(., concat($zacatek, $mezera))" />
      </xsl:copy>
    </unclear>
  </xsl:template>
</xsl:stylesheet>