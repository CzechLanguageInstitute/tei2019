<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" exclude-result-prefixes="xd" version="1.0">
  <xd:doc scope="stylesheet">
    <xd:desc>
      <xd:p>
        <xd:b>Created on:</xd:b> Dec 8, 2010</xd:p>
      <xd:p>
        <xd:b>Author:</xd:b> boris</xd:p>
      <xd:p></xd:p>
    </xd:desc>
  </xd:doc>
  <xsl:include href="Copy-xml-nodes.xsl" />
  <xsl:output omit-xml-declaration="no" indent="yes" />
  <xsl:strip-space elements="*" />
  <xsl:template match="/">
    <xsl:comment> Merge-l-with-line-numbers </xsl:comment>
    <xsl:apply-templates />
  </xsl:template>
  <!--<xsl:template match="/body/div/l[child::*[1] = lb]">-->
  <xsl:template match="div/l[child::*[1] = lb]">
    <xsl:element name="l">
      <xsl:attribute name="n">
        <xsl:value-of select="normalize-space(lb/@n)" />
      </xsl:attribute>
      <xsl:apply-templates />
    </xsl:element>
  </xsl:template>
  <xsl:template match="lb" />
</xsl:stylesheet>