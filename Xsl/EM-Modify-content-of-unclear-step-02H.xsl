<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:c="http://vokabular.ujc.cas.cz/schemas/changes/v1.0/" exclude-result-prefixes="xd" version="1.0">
  <xsl:import href="Copy-xml-nodes.xsl" />
  <xd:doc scope="stylesheet">
    <xd:desc>
      <xd:p>
        <xd:b>Created on:</xd:b> Mar 25, 2018</xd:p>
      <xd:p>
        <xd:b>Author:</xd:b> Boris</xd:p>
      <xd:p></xd:p>
    </xd:desc>
  </xd:doc>
  <xsl:strip-space elements="*" />
  <xsl:output method="xml" indent="no" />
  <xsl:template match="/">
    <xsl:comment> EM-Modify-content-of-unclear-step-02H </xsl:comment>
    <xsl:apply-templates />
  </xsl:template>
  <!--<xsl:template match="unclear[@position='initial'][following-sibling::*[1]/self::unclear][following-sibling::*[2]/self::unclear[@position='final']]">
		<xsl:copy>
			<xsl:apply-templates />
			<xsl:apply-templates select="following-sibling::*[1]/node()"/>
			<xsl:apply-templates select="following-sibling::*[2]/node()"/>
		</xsl:copy>
	</xsl:template>-->
  <xsl:template match="unclear[@position='initial']">
    <xsl:copy>
      <xsl:if test="@c:*">
        <xsl:copy-of select="@c:*" />
      </xsl:if>
      <xsl:if test="following-sibling::node()[1][self::unclear[@c:*]]">
        <xsl:copy-of select="following-sibling::node()[1][self::unclear]/@c:*" />
      </xsl:if>
      <xsl:apply-templates />
      <xsl:apply-templates select="following-sibling::node()[1][self::unclear]" mode="step" />
    </xsl:copy>
  </xsl:template>
  <xsl:template match="unclear[@position='middle']" priority="2" />
  <xsl:template match="unclear[@position='final']" priority="2" />
  <xsl:template match="unclear[@position != 'initial']" mode="step">
    <xsl:apply-templates />
    <xsl:apply-templates select="following-sibling::node()[1][self::unclear[not(@position='initial')]]" mode="step" />
  </xsl:template>
</xsl:stylesheet>