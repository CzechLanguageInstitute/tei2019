<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:tei="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="xd tei" version="1.0">
  <xd:doc scope="stylesheet">
    <xd:desc>
      <xd:p>
        <xd:b>Created on:</xd:b> Dec 10, 2014</xd:p>
      <xd:p>
        <xd:b>Author:</xd:b> Boris</xd:p>
      <xd:p>Přiřadí jenotlivám významonosným prvkům jedinečné ID spočívacící v identifikaci předchozích prvků.</xd:p>
    </xd:desc>
  </xd:doc>
  <xsl:include href="Copy-xml-nodes.xsl" />
  <xsl:output omit-xml-declaration="no" indent="yes" />
  <xsl:strip-space elements="*" />
  <xsl:template match="/">
    <xsl:comment> TEI-Assign-hierarchical-id </xsl:comment>
    <xsl:apply-templates />
  </xsl:template>
  <xsl:template match="tei:text|tei:teiHeader">
    <xsl:variable name="name">
      <xsl:call-template name="nameShortCut">
        <xsl:with-param name="name" select="name()" />
      </xsl:call-template>
    </xsl:variable>
    <xsl:copy>
      <xsl:attribute name="xml:id">
        <xsl:value-of select="$name" />-<xsl:number format="1" level="single" /></xsl:attribute>
      <xsl:apply-templates select="@*|node()">
        <xsl:with-param name="prev_id">
          <xsl:value-of select="$name" />-<xsl:number format="1" level="single" /></xsl:with-param>
      </xsl:apply-templates>
    </xsl:copy>
  </xsl:template>
  <!--	<xsl:template match="tei:pb">
		<xsl:copy-of select="@*" />
	</xsl:template>
-->
  <xsl:template match="tei:body | tei:front | tei:back | tei:div | tei:head |    tei:note | tei:p | tei:l | tei:w | tei:pb | tei:app | tei:item | tei:figure | tei:list |   tei:table | tei:row | tei:cell | tei:seg | tei:fw | tei:supplied | tei:add | tei:app |    tei:unclear | tei:foreign | tei:del | tei:rdg | tei:orig | tei:choice |   tei:encodingDesc | tei:projectDesc">
    <!-- <xsl:template match="tei:note[ancestor-or-self::*]">-->
    <xsl:param name="prev_id" />
    <xsl:variable name="name">
      <xsl:call-template name="nameShortCut">
        <xsl:with-param name="name" select="name()" />
      </xsl:call-template>
    </xsl:variable>
    <xsl:copy>
      <xsl:copy-of select="@*" />
      <xsl:variable name="cur_id">
        <xsl:choose>
          <xsl:when test="$prev_id = ''">
            <xsl:value-of select="$name" />-<xsl:number format="1" level="single" /></xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="concat($prev_id,'.',name())" />-<xsl:number format="1" level="single" /></xsl:otherwise>
        </xsl:choose>
      </xsl:variable>
      <xsl:attribute name="xml:id">
        <xsl:value-of select="$cur_id" />
      </xsl:attribute>
      <xsl:apply-templates select="node()">
        <xsl:with-param name="prev_id" select="$cur_id" />
      </xsl:apply-templates>
    </xsl:copy>
  </xsl:template>
  <xsl:template name="nameShortCut">
    <xsl:param name="name" />
    <xsl:choose>
      <xsl:when test="$name = 'back'">
        <xsl:value-of select="$name" />
      </xsl:when>
      <xsl:when test="$name = 'pb'">
        <xsl:value-of select="$name" />
      </xsl:when>
      <xsl:when test="$name = 'teiHeader'">
        <xsl:value-of select="$name" />
      </xsl:when>
      <xsl:when test="$name = 'list'">
        <xsl:value-of select="$name" />
      </xsl:when>
      <xsl:when test="$name = 'supplied'">
        <xsl:value-of select="'supp'" />
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="substring($name, 1, 1)" />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
</xsl:stylesheet>