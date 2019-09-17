<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:tei="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="xd tei" version="1.0">
  <xd:doc scope="stylesheet">
    <xd:desc>
      <xd:p>
        <xd:b>Created on:</xd:b> Dec 10, 2014</xd:p>
      <xd:p>
        <xd:b>Author:</xd:b> Boris</xd:p>
      <xd:p>Pokud je element <xd:b>note</xd:b> zanořený v elementu <xd:b>note</xd:b>, popř. v jeho podelementech, přesune se za note.</xd:p>
    </xd:desc>
  </xd:doc>
  <xsl:include href="Copy-xml-nodes.xsl" />
  <xsl:output omit-xml-declaration="no" indent="yes" />
  <xsl:strip-space elements="*" />
  <xsl:template match="/">
    <xsl:comment> EM-TEI-Move-note-within-note </xsl:comment>
    <xsl:apply-templates />
  </xsl:template>
  <xsl:template match="tei:note[not(@place='margin') and tei:p][.//tei:note]">
    <xsl:copy>
      <xsl:copy-of select="@*" />
      <xsl:apply-templates />
    </xsl:copy>
    <xsl:copy-of select=".//tei:note" />
  </xsl:template>
  <xsl:template match="tei:note[ancestor::tei:note[not(@place='margin') and tei:p]]" priority="2" />
</xsl:stylesheet>