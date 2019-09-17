<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xml="http://www.w3.org/XML/1998/namespace" xmlns:tei="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="xs xd tei" version="1.0">
  <xsl:import href="Copy-xml-nodes.xsl" />
  <xsl:output indent="no" method="xml" omit-xml-declaration="no" />
  <xsl:strip-space elements="*" />
  <xd:doc scope="stylesheet">
    <xd:desc>
      <xd:p>
        <xd:b>Created on:</xd:b> Feb 21, 2017</xd:p>
      <xd:p>
        <xd:b>Author:</xd:b> Boris</xd:p>
      <xd:p></xd:p>
    </xd:desc>
  </xd:doc>
  <xsl:template match="/">
    <xsl:comment> TEI-Remove-xml-space-preserve </xsl:comment>
    <xsl:apply-templates />
  </xsl:template>
  <xsl:template match="*[@xml:space='preserve']" priority="10">
    <xsl:copy>
      <xsl:choose>
        <xsl:when test=". = ' '">
          <xsl:copy-of select="@*" />
          <xsl:text></xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:copy-of select="@*[name() != 'xml:space']" />
          <xsl:apply-templates />
        </xsl:otherwise>
      </xsl:choose>
    </xsl:copy>
  </xsl:template>
  <xd:doc>
    <xd:desc>
      <xd:p></xd:p>
    </xd:desc>
  </xd:doc>
  <xsl:template match="tei:seg[tei:gap][text()[last()] = ' ']" priority="15">
    <xsl:copy>
      <xsl:attribute name="space" namespace="http://www.w3.org/XML/1998/namespace">preserve</xsl:attribute>
      <xsl:copy-of select="@*" />
      <xsl:apply-templates />
    </xsl:copy>
  </xsl:template>
</xsl:stylesheet>