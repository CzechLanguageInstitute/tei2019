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
  <xsl:variable name="type" select="'preface'" />
  <xsl:template match="/">
    <xsl:comment> Group-elements-of-preface-to-div </xsl:comment>
    <xsl:apply-templates />
  </xsl:template>
  <xsl:template match="body/div">
    <div>
      <xsl:copy-of select="@*" />
      <xsl:choose>
        <xsl:when test="div[@type=$type]">
          <xsl:for-each-group select="*" group-adjacent="if(self::*[@type=$type ]) then 0 else position()">
            <xsl:apply-templates select="." />
          </xsl:for-each-group>
        </xsl:when>
        <xsl:otherwise>
          <xsl:copy-of select="*" />
        </xsl:otherwise>
      </xsl:choose>
    </div>
  </xsl:template>
  <xsl:template match="*[@type=$type]">
    <!--		<xsl:comment> <xsl:value-of select="current-grouping-key()"></xsl:value-of> </xsl:comment>-->
    <div type="{$type}">
      <xsl:apply-templates select="current-group()" mode="editorial-group" />
    </div>
  </xsl:template>
  <xsl:template match="div[@type=$type]" mode="editorial-group" priority="15">
    <xsl:apply-templates />
  </xsl:template>
</xsl:stylesheet>