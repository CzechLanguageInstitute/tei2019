<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" exclude-result-prefixes="xd" version="2.0">
  <xd:doc scope="stylesheet">
    <xd:desc>
      <xd:p>
        <xd:b>Created on:</xd:b> Dec 18, 2014</xd:p>
      <xd:p>
        <xd:b>Author:</xd:b> Boris</xd:p>
      <xd:p>Pokud existují v oddílu prvky <xd:b>head1</xd:b>, které nejsou typu nadpis/titul, seskupí se tyto prvky do samostatného oddílu <xd:b>div</xd:b></xd:p>
    </xd:desc>
  </xd:doc>
  <xsl:output indent="yes" />
  <xsl:strip-space elements="*" />
  <xsl:include href="Copy-xml-nodes.xsl" />
  <xsl:template match="/">
    <xsl:comment> Group-elements-head1-without-head2 </xsl:comment>
    <xsl:apply-templates />
  </xsl:template>
  <xd:doc>
    <xd:desc>Případy, kdy obsahuje nadpis, ale nezačíná jím. Pasáže před nadpisem se vyčlení do samostatného oddílu.</xd:desc>
  </xd:doc>
  <xsl:template match="body/div[not(@type)][*[1] = head1] | body/div/div[@type='bible'][*[1] = head1]" priority="10">
    <!-- Úvodní pasáž (do 1. výskytu hlavičky) se  -->
    <xsl:copy>
      <xsl:copy-of select="@*" />
      <div>
        <xsl:choose>
          <xsl:when test="head | thead">
            <xsl:apply-templates select="(head|thead)[1]/preceding-sibling::*" />
          </xsl:when>
          <xsl:otherwise>
            <xsl:apply-templates />
          </xsl:otherwise>
        </xsl:choose>
      </div>
      <!-- Vypustí úvodní sekvenci až do 1. výskytu hlavičky -->
      <xsl:apply-templates select="(head|thead)[1]/(self::*, following-sibling::*)" />
    </xsl:copy>
  </xsl:template>
  <xsl:template match="body/div[not(@type)]/div[@type='bible'][*[1] = div][*[2] = head1]">
    <xsl:copy>
      <xsl:copy-of select="@*" />
      <xsl:apply-templates select="*[1]" />
      <div>
        <xsl:choose>
          <xsl:when test="head | thead">
            <xsl:apply-templates select="(head|thead)[1]/preceding-sibling::* except *[1]" />
          </xsl:when>
          <xsl:otherwise>
            <xsl:apply-templates select="* except *[1]" />
          </xsl:otherwise>
        </xsl:choose>
      </div>
      <!-- Vypustí úvodní sekvenci až do 1. výskytu hlavičky -->
      <xsl:apply-templates select="(head|thead)[1]/(self::*, following-sibling::*)" />
    </xsl:copy>
  </xsl:template>
</xsl:stylesheet>