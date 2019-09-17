<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" exclude-result-prefixes="xd" version="2.0">
  <xd:doc scope="stylesheet">
    <xd:desc>
      <xd:p>
        <xd:b>Created on:</xd:b> Dec 5, 2010</xd:p>
      <xd:p>
        <xd:b>Author:</xd:b> boris</xd:p>
      <xd:p></xd:p>
    </xd:desc>
  </xd:doc>
  <xsl:output indent="yes" />
  <xsl:strip-space elements="*" />
  <xsl:include href="Copy-xml-nodes.xsl" />
  <xsl:template match="/">
    <xsl:comment> EM-Group-index-items </xsl:comment>
    <xsl:apply-templates />
  </xsl:template>
  <xsl:template match="div">
    <xsl:copy>
      <xsl:copy-of select="@*" />
      <xsl:choose>
        <xsl:when test="item">
          <xsl:for-each-group select="*" group-adjacent="if(self::item and not(parent::cell)) then        0 else position()">
            <xsl:apply-templates select="." />
          </xsl:for-each-group>
        </xsl:when>
        <xsl:otherwise>
          <xsl:apply-templates />
        </xsl:otherwise>
      </xsl:choose>
    </xsl:copy>
  </xsl:template>
  <xsl:template match="item">
    <xsl:choose>
      <xsl:when test="parent::cell">
        <xsl:apply-templates mode="item-group" />
      </xsl:when>
      <xsl:otherwise>
        <xsl:choose>
          <xsl:when test="parent::*/self::div">
            <list type="index">
              <xsl:apply-templates select="current-group()" mode="item-group" />
            </list>
          </xsl:when>
          <xsl:otherwise>
            <div>
              <list type="index">
                <xsl:apply-templates select="current-group()" mode="item-group" />
              </list>
            </div>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template match="item" mode="item-group">
    <xsl:copy>
      <xsl:copy-of select="@*" />
      <xsl:apply-templates />
    </xsl:copy>
  </xsl:template>
  <!-- Recursive template used to match the next sibling if it has the same name -->
  <xsl:template match="item" mode="next">
    <xsl:variable name="name" select="local-name()" />
    <xsl:element name="{$name}">
      <xsl:apply-templates />
    </xsl:element>
    <xsl:apply-templates select="following-sibling::*[1][local-name()=$name]" mode="next" />
  </xsl:template>
</xsl:stylesheet>