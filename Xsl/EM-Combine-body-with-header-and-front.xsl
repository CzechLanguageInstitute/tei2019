<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:c="http://vokabular.ujc.cas.cz/schemas/changes/v1.0/" xmlns="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="xd" version="1.0">
  <xd:doc scope="stylesheet">
    <xd:desc>
      <xd:p>
        <xd:b>Created on:</xd:b> Dec 4, 2010</xd:p>
      <xd:p>
        <xd:b>Author:</xd:b> boris</xd:p>
      <xd:p></xd:p>
    </xd:desc>
  </xd:doc>
  <xsl:param name="hlavicka" />
  <xsl:param name="zacatek" />
  <xsl:output omit-xml-declaration="no" indent="yes" />
  <xsl:strip-space elements="*" />
  <xsl:template match="/">
    <xsl:comment> EM-Combine-body-with-header-and-front </xsl:comment>
    <TEI xmlns="http://www.tei-c.org/ns/1.0" xmlns:c="http://vokabular.ujc.cas.cz/schemas/changes/v1.0/" xml:lang="cs" n="{document($hlavicka)/teiHeader/fileDesc/@n}">
      <xsl:apply-templates select="document($hlavicka)/*" mode="jmennyProstor" />
      <text>
        <xsl:apply-templates select="document($zacatek)/*" mode="jmennyProstor" />
        <xsl:apply-templates mode="jmennyProstor" />
      </text>
      <!-- Doplněno 18. 11. 2010 -->
    </TEI>
  </xsl:template>
  <xsl:template match="*" mode="jmennyProstor">
    <xsl:element name="{local-name()}" namespace="http://www.tei-c.org/ns/1.0">
      <xsl:apply-templates select="@*|*|text()" mode="jmennyProstor" />
    </xsl:element>
  </xsl:template>
  <xsl:template match="@*" mode="jmennyProstor">
    <xsl:variable name="nazev">
      <xsl:choose>
        <xsl:when test="local-name() = 'id'">
          <xsl:text>xml:id</xsl:text>
        </xsl:when>
        <xsl:when test="local-name() = 'lang'">
          <xsl:text>xml:lang</xsl:text>
        </xsl:when>
        <xsl:when test="local-name() = 'space'">
          <xsl:text>xml:space</xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="local-name()" />
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:attribute name="{$nazev}">
      <xsl:value-of select="." />
    </xsl:attribute>
  </xsl:template>
  <xsl:template match="@c:*" mode="jmennyProstor" priority="3">
    <xsl:copy-of select="." />
  </xsl:template>
</xsl:stylesheet>