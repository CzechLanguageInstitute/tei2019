<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:tei="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="xs xd tei" version="1.0">
  <xsl:import href="Copy-xml-nodes.xsl" />
  <xsl:output indent="no" method="xml" omit-xml-declaration="no" />
  <!--<xsl:strip-space elements="*"/>-->
  <xd:doc scope="stylesheet">
    <xd:desc>
      <xd:p>
        <xd:b>Created on:</xd:b> Apr 12, 2018</xd:p>
      <xd:p>
        <xd:b>Author:</xd:b> Boris</xd:p>
      <xd:p></xd:p>
    </xd:desc>
  </xd:doc>
  <xsl:template match="/">
    <xsl:comment> TEI-Remove-empty-elements </xsl:comment>
    <xsl:apply-templates />
  </xsl:template>
  <xd:doc>
    <xd:desc>
      <xd:p></xd:p>
    </xd:desc>
  </xd:doc>
  <xsl:template match="tei:hi[not(node())][not(@*)]" />
  <xsl:template match="tei:hi[@xml:space='preserve'][. = ' ']">
    <xsl:element name="c" namespace="http://www.tei-c.org/ns/1.0">
      <xsl:attribute name="space" namespace="http://www.w3.org/XML/1998/namespace">preserve</xsl:attribute>
      <xsl:text></xsl:text>
    </xsl:element>
  </xsl:template>
</xsl:stylesheet>