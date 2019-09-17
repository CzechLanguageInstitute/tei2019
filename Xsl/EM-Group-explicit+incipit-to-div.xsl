<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" exclude-result-prefixes="xd" version="2.0">
  <xd:doc scope="stylesheet">
    <xd:desc>
      <xd:p>
        <xd:b>Created on:</xd:b> Dec 19, 2014</xd:p>
      <xd:p>
        <xd:b>Author:</xd:b> Boris</xd:p>
      <xd:p></xd:p>
    </xd:desc>
  </xd:doc>
  <xsl:include href="Copy-xml-nodes.xsl" />
  <xsl:output indent="yes" />
  <xsl:strip-space elements="*" />
  <xsl:template match="/">
    <xsl:comment> EM-Group-explicit+incipit-to-div </xsl:comment>
    <xsl:apply-templates />
  </xsl:template>
  <xsl:template match="div[div[@type='explicit']] | div[head[@type='explicit']]">
    <xsl:copy>
      <xsl:copy-of select="@*" />
      <xsl:for-each-group select="*" group-ending-with="div[@type='explicit'] | head[@type='explicit']">
        <div type="bible">
          <xsl:apply-templates select="." mode="group" />
        </div>
      </xsl:for-each-group>
    </xsl:copy>
  </xsl:template>
  <!--<xsl:template match="div[@type='explicit']" mode="group">
		<div>
			<xsl:apply-templates select="current-group()" />
<!-\-			<xsl:value-of select="."/>-\->
		</div>
	</xsl:template>-->
  <xsl:template match="*" mode="group">
    <xsl:copy-of select="current-group()" />
  </xsl:template>
</xsl:stylesheet>