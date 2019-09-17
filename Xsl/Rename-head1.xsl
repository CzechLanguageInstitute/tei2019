<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" exclude-result-prefixes="xd" version="1.0">
  <xd:doc scope="stylesheet">
    <xd:desc>
      <xd:p>
        <xd:b>Created on:</xd:b> Dec 4, 2010</xd:p>
      <xd:p>
        <xd:b>Author:</xd:b> boris</xd:p>
      <xd:p>Přejmenovává element <xd:b>head1</xd:b> na <xd:b>head</xd:b>. </xd:p>
    </xd:desc>
  </xd:doc>
  <xsl:include href="Copy-xml-nodes.xsl" />
  <xsl:template match="/">
    <xsl:comment> Rename-head1 </xsl:comment>
    <xsl:apply-templates />
  </xsl:template>
  <xsl:template match="head1">
    <xsl:element name="head">
      <xsl:apply-templates />
    </xsl:element>
  </xsl:template>
  <xsl:template match="head2">
    <xsl:element name="head">
      <xsl:apply-templates />
    </xsl:element>
  </xsl:template>
  <xsl:template match="head3">
    <xsl:element name="head">
      <xsl:apply-templates />
    </xsl:element>
  </xsl:template>
  <xd:doc>
    <xd:desc>
      <xd:p>Nadpis, který tvoří součást textu</xd:p>
    </xd:desc>
  </xd:doc>
  <xsl:template match="thead">
    <xsl:element name="head">
      <xsl:apply-templates />
    </xsl:element>
  </xsl:template>
</xsl:stylesheet>