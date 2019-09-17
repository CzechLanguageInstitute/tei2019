<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:tei="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="xs xd tei" version="1.0">
  <xsl:import href="Copy-xml-nodes.xsl" />
  <xsl:output indent="no" method="xml" omit-xml-declaration="no" />
  <xd:doc scope="stylesheet">
    <xd:desc>
      <xd:p>
        <xd:b>Created on:</xd:b> Jun 17, 2019</xd:p>
      <xd:p>
        <xd:b>Author:</xd:b> Boris</xd:p>
      <xd:p></xd:p>
    </xd:desc>
  </xd:doc>
  <xsl:template match="/">
    <xsl:comment> TEI-Remove-space-before-note </xsl:comment>
    <xsl:apply-templates />
  </xsl:template>
  <xsl:template match="tei:c[@xml:space][. = ' '] [following-sibling::node()[1][self::tei:note[not(tei:choice)]]] [preceding-sibling::node()[1][self::tei:unclear]]" />
</xsl:stylesheet>