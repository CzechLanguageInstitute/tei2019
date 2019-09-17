<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" exclude-result-prefixes="xd" version="1.0">
  <xd:doc scope="stylesheet">
    <xd:desc>
      <xd:p>
        <xd:b>Created on:</xd:b> Dec 5, 2010</xd:p>
      <xd:p>
        <xd:b>Author:</xd:b> boris</xd:p>
      <xd:p>Podle TEI P5 nemůže být součástí prvku <xd:b>cell</xd:b> prvek <xd:b>p</xd:b>.</xd:p>
      <xd:p>Změna prvku <xd:b>p</xd:b> na <xd:b>segment</xd:b>.</xd:p>
    </xd:desc>
  </xd:doc>
  <xsl:include href="Copy-xml-nodes.xsl" />
  <xsl:template match="/">
    <xsl:comment> Modify-content-of-cell-element </xsl:comment>
    <xsl:apply-templates />
  </xsl:template>
  <xsl:template match="cell/p">
    <xsl:element name="seg">
      <xsl:apply-templates select="@*" />
      <xsl:apply-templates />
    </xsl:element>
  </xsl:template>
  <xsl:template match="cell/div/p">
    <xsl:apply-templates />
  </xsl:template>
  <xsl:template match="cell/div">
    <xsl:element name="seg">
      <xsl:apply-templates select="@*" />
      <xsl:apply-templates />
    </xsl:element>
  </xsl:template>
</xsl:stylesheet>