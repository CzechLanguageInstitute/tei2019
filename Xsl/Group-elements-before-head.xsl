<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" exclude-result-prefixes="xd" version="2.0">
  <xd:doc scope="stylesheet">
    <xd:desc>
      <xd:p>
        <xd:b>Created on:</xd:b> Dec 18, 2014</xd:p>
      <xd:p>
        <xd:b>Author:</xd:b> Boris</xd:p>
      <xd:p>Pokud jsou na začátku oddílu prvky, které nejsou typu nadpis/titul, seskupí se tyto prvky do samostatného oddílu <xd:b>div</xd:b>.</xd:p>
    </xd:desc>
  </xd:doc>
  <xsl:output indent="yes" />
  <xsl:strip-space elements="*" />
  <xsl:include href="Copy-xml-nodes.xsl" />
  <xsl:template match="/">
    <xsl:comment> Group-elements-before-head </xsl:comment>
    <xsl:apply-templates />
  </xsl:template>
  <xd:doc>
    <xd:desc>Případy, kdy obsahuje nadpis, ale nezačíná jím. Pasáže před nadpisem se vyčlení do samostatného oddílu.</xd:desc>
  </xd:doc>
  <xsl:template match="body/div[not(@type)][head|head1|thead][not(contains(name(*[1]), 'head'))]" priority="10">
    <!-- Úvodní pasáž (do 1. výskytu hlavičky) se  -->
    <div>
      <xsl:apply-templates select="(head|thead|head1)[1]/preceding-sibling::*" />
    </div>
    <xsl:copy>
      <xsl:copy-of select="@*" />
      <!-- Vypustí úvodní sekvenci až do 1. výskytu hlavičky -->
      <xsl:apply-templates select="(head|thead|head1)[1]/(self::*, following-sibling::*)" />
    </xsl:copy>
  </xsl:template>
  <xsl:template match="body/div/div[@type='bible'][head|head1|thead][not(contains(name(*[1]), 'head'))]" priority="10">
    <!-- Úvodní pasáž (do 1. výskytu hlavičky) se  -->
    <xsl:copy>
      <xsl:copy-of select="@*" />
      <div>
        <xsl:apply-templates select="(head|thead|head1)[1]/preceding-sibling::*" />
      </div>
      <!-- Vypustí úvodní sekvenci až do 1. výskytu hlavičky -->
      <xsl:apply-templates select="(head|thead|head1)[1]/(self::*, following-sibling::*)" />
    </xsl:copy>
  </xsl:template>
  <xsl:template match="body/div[@type='editorial'][head|head1][not(contains(name(*[1]), 'head'))]" priority="10">
    <!-- Úvodní pasáž (do 1. výskytu hlavičky) se  -->
    <xsl:copy>
      <xsl:copy-of select="@*" />
      <div>
        <xsl:apply-templates select="(head|head1)[1]/preceding-sibling::*" />
      </div>
      <!-- Vypustí úvodní sekvenci až do 1. výskytu hlavičky -->
      <xsl:apply-templates select="(head|head1)[1]/(self::*, following-sibling::*)" />
    </xsl:copy>
  </xsl:template>
  <xd:doc>
    <xd:desc>Případy, kdy za titulem následují pouze nadpisy 1. úrovně</xd:desc>
  </xd:doc>
  <xsl:template match="body/div[not(@type)][*[1]=thead][not(head)][head1]">
    <xsl:copy>
      <xsl:copy-of select="@*" />
      <xsl:apply-templates select="*[1]" />
      <div>
        <xsl:apply-templates select="(head|head1)[1]/preceding-sibling::* except *[1]" />
      </div>
      <!-- Vypustí úvodní sekvenci až do 1. výskytu hlavičky -->
      <xsl:apply-templates select="(head|head1)[1]/(self::*, following-sibling::*)" />
    </xsl:copy>
  </xsl:template>
</xsl:stylesheet>