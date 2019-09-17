<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" exclude-result-prefixes="xd" version="2.0">
  <xsl:import href="Copy-xml-nodes.xsl" />
  <xd:doc scope="stylesheet">
    <xd:desc>
      <xd:p>
        <xd:b>Created on:</xd:b> Feb 23, 2018</xd:p>
      <xd:p>
        <xd:b>Author:</xd:b> Boris</xd:p>
      <xd:p></xd:p>
    </xd:desc>
  </xd:doc>
  <xsl:strip-space elements="*" />
  <xsl:output method="xml" indent="yes" />
  <!-- KomKancTisk -->
  <xsl:template match="/body/text/p[following-sibling::*[1]/starts-with(., preceding-sibling::*[1]/. )]" priority="2" />
  <!-- ZrcSpasK -->
  <xsl:template match="notes/p[not(node())]" priority="2" />
  <xsl:template match="notes/p[not(@type='table')]">
    <xsl:copy>
      <xsl:copy-of select="@*" />
      <xsl:for-each select="tokenize(., '\|')">
        <xsl:sort lang="cs-CZ" />
        <xsl:if test=". != ''">
          <xsl:value-of select="concat(normalize-space(.), '|')" />
        </xsl:if>
      </xsl:for-each>
    </xsl:copy>
  </xsl:template>
</xsl:stylesheet>