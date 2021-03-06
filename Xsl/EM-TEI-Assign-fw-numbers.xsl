﻿<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:tei="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="xd tei" version="1.0">
  <xsl:import href="Copy-xml-nodes.xsl" />
  <xd:doc scope="stylesheet">
    <xd:desc>
      <xd:p>
        <xd:b>Created on:</xd:b> Jan 31, 2018</xd:p>
      <xd:p>
        <xd:b>Author:</xd:b> Boris</xd:p>
      <xd:p>Přiřadí živému záhlaví číselné označení (velké písmeno).</xd:p>
    </xd:desc>
  </xd:doc>
  <xsl:output omit-xml-declaration="no" indent="yes" />
  <xsl:strip-space elements="*" />
  <xsl:template match="/">
    <xsl:comment> EM-TEI-Assign-fw-numbers </xsl:comment>
    <xsl:apply-templates />
  </xsl:template>
  <xsl:template match="tei:fw">
    <xsl:copy>
      <xsl:copy-of select="@*" />
      <xsl:attribute name="n">
        <xsl:call-template name="calculateFootnoteNumber" />
      </xsl:attribute>
      <xsl:attribute name="xml:id">
        <xsl:text>fw-</xsl:text>
        <xsl:number count="tei:fw" format="1" from="tei:text" level="any" />
      </xsl:attribute>
      <xsl:apply-templates />
    </xsl:copy>
  </xsl:template>
  <xsl:template name="calculateFootnoteNumber">
    <xsl:number count="tei:fw" format="A" from="tei:front | tei:body" level="any" />
  </xsl:template>
</xsl:stylesheet>