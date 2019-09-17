<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:tei="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="xd tei" version="1.0">
  <xd:doc scope="stylesheet">
    <xd:desc>
      <xd:p>
        <xd:b>Created on:</xd:b> Dec 20, 2014</xd:p>
      <xd:p>
        <xd:b>Author:</xd:b> Boris</xd:p>
      <xd:p>Přesune element <xd:b>&lt;docImprint&gt;</xd:b> z elementu <xd:b>&lt;body&gt;</xd:b> do elementu <xd:b>&lt;back&gt;</xd:b>.</xd:p>
    </xd:desc>
  </xd:doc>
  <xsl:output method="xml" indent="yes" />
  <xsl:output indent="yes" />
  <xsl:strip-space elements="*" />
  <xsl:include href="Copy-xml-nodes.xsl" />
  <xsl:template match="/">
    <xsl:comment> EM-Move-docImprint </xsl:comment>
    <xsl:apply-templates />
  </xsl:template>
  <xsl:template match="tei:text">
    <xsl:copy>
      <xsl:copy-of select="@*" />
      <xsl:choose>
        <xsl:when test="tei:back">
          <xsl:apply-templates />
        </xsl:when>
        <xsl:otherwise>
          <xsl:apply-templates />
          <xsl:if test="tei:body//tei:docImprint">
            <back xmlns="http://www.tei-c.org/ns/1.0">
              <xsl:call-template name="moveDocImprintDiv" />
            </back>
          </xsl:if>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:copy>
  </xsl:template>
  <xsl:template name="moveDocImprintDiv">
    <xsl:apply-templates select="tei:body//tei:docImprint" mode="move" />
  </xsl:template>
  <xsl:template match="tei:back">
    <xsl:if test="./tei:body//tei:docImprint">
      <xsl:call-template name="moveDocImprintDiv" />
    </xsl:if>
    <xsl:apply-templates />
  </xsl:template>
  <xsl:template match="tei:pb[following-sibling::*[1]/self::tei:docImprint]" />
  <xsl:template match="tei:text/tei:body//tei:docImprint" />
  <xsl:template match="tei:text/tei:body//tei:docImprint" mode="move">
    <xsl:if test="preceding-sibling::*[1]/self::tei:pb">
      <xsl:copy-of select="preceding-sibling::*[1]" />
    </xsl:if>
    <xsl:copy-of select="." />
  </xsl:template>
</xsl:stylesheet>