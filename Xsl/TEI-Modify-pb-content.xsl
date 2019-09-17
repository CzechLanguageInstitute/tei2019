<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" exclude-result-prefixes="xd" version="1.0">
  <xd:doc scope="stylesheet">
    <xd:desc>
      <xd:p>
        <xd:b>Created on:</xd:b> Feb 6, 2011</xd:p>
      <xd:p>
        <xd:b>Author:</xd:b> Boris</xd:p>
      <xd:p>Rozdělí foliaci na jednotlivé části oddělené mezerou; pro každou část vygeneruje (na základě zakončení textu) odpovídající číslo paginy.</xd:p>
    </xd:desc>
  </xd:doc>
  <xsl:output method="xml" indent="yes" />
  <xsl:include href="Copy-xml-nodes.xsl" />
  <xsl:template match="/">
    <xsl:comment> TEI-Modify-pb-content </xsl:comment>
    <xsl:apply-templates />
  </xsl:template>
  <xsl:include href="TEI-Transpose-pagination-to-pb.xsl" />
</xsl:stylesheet>