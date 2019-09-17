<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" exclude-result-prefixes="xd" version="1.0">
  <xsl:import href="Copy-xml-nodes.xsl" />
  <xd:doc scope="stylesheet">
    <xd:desc>
      <xd:p>
        <xd:b>Created on:</xd:b> Dec 1, 2010</xd:p>
      <xd:p>
        <xd:b>Author:</xd:b> Boris Lehečka</xd:p>
      <xd:p>Odstranění interních komentářů</xd:p>
    </xd:desc>
  </xd:doc>
  <xsl:output omit-xml-declaration="no" indent="yes" />
  <xsl:template match="/">
    <xsl:comment> Remove-internal-notes </xsl:comment>
    <xsl:apply-templates />
  </xsl:template>
  <xsl:template match="*[starts-with(name(), 'interni_poznamka')]" />
</xsl:stylesheet>