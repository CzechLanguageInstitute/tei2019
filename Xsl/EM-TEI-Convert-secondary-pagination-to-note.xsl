<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:tei="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="xd tei" version="1.0">
  <xd:doc scope="stylesheet">
    <xd:desc>
      <xd:p>
        <xd:b>Created on:</xd:b> Dec 10, 2014</xd:p>
      <xd:p>
        <xd:b>Author:</xd:b> Boris</xd:p>
      <xd:p></xd:p>
    </xd:desc>
  </xd:doc>
  <xsl:include href="Copy-xml-nodes.xsl" />
  <xsl:output omit-xml-declaration="no" indent="yes" />
  <xsl:strip-space elements="*" />
  <xsl:template match="/">
    <xsl:comment> EM-TEI-Convert-secondary-pagination-to-note </xsl:comment>
    <xsl:apply-templates />
  </xsl:template>
  <xsl:template match="tei:pb[@n='x'][preceding-sibling::node()[1]/self::tei:pb]" />
  <xsl:template match="tei:pb[following-sibling::node()[1]/self::tei:pb[@n='x']]">
    <xsl:element name="note" namespace="http://www.tei-c.org/ns/1.0">
      <xsl:value-of select="concat('Pokračování textu na straně ', @n)" />
    </xsl:element>
    <xsl:if test="@rend='space'">
      <xsl:text></xsl:text>
    </xsl:if>
  </xsl:template>
</xsl:stylesheet>