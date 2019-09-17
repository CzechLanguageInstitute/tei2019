<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" exclude-result-prefixes="xd" version="1.0">
  <xsl:import href="Copy-xml-nodes.xsl" />
  <xd:doc scope="stylesheet">
    <xd:desc>
      <xd:p>
        <xd:b>Created on:</xd:b> Oct 22, 2010</xd:p>
      <xd:p>
        <xd:b>Author:</xd:b> Boris Lehečka</xd:p>
      <xd:p>Odstraní první tabulku v dokumentu XML. Její součástí ve wordovském dokumentu byla metada o přepisu.</xd:p>
    </xd:desc>
  </xd:doc>
  <xsl:output omit-xml-declaration="no" />
  <xsl:template match="/">
    <xsl:comment> Remove-table-with-metadata </xsl:comment>
    <xsl:apply-templates />
  </xsl:template>
  <xsl:template match="table[@n='1']" />
</xsl:stylesheet>