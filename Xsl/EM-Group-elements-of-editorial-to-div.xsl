<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet exclude-result-prefixes="xs xd" version="2.0" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xd:doc scope="stylesheet">
    <xd:desc>
      <xd:p>
        <xd:b>Created on:</xd:b> Jan 8, 2012</xd:p>
      <xd:p>
        <xd:b>Author:</xd:b> Boris</xd:p>
      <xd:p />
    </xd:desc>
  </xd:doc>
  <xsl:output indent="yes" />
  <xsl:strip-space elements="*" />
  <xsl:include href="Copy-xml-nodes.xsl" />
  <xd:doc>
    <xd:desc>
      <xd:p>Pokud tělo obsahuje alespoň jeden element <xd:b>head</xd:b> nebo <xd:b>head1</xd:b> (začínající na "head"), vytvoří se pro takto ohraničené oblasti element <xd:b>div</xd:b>.</xd:p>
      <xd:p>Bylo by vhodné elementy, které předcházejí, rovněž seskupit do <xd:b>div</xd:b>, pokud tyto elementy netvoří <xd:b>div</xd:b> nebo <xd:b>pb</xd:b>.</xd:p>
      <xd:p>Pokud tělo žádný element <xd:b>head</xd:b> nebo <xd:b>head1</xd:b> neobsahuje, elementy se zkopírují. (Nebo by se měla vytvořit alespon jedna úroveň <xd:b>div</xd:b>?)</xd:p>
    </xd:desc>
  </xd:doc>
  <xsl:template match="/">
    <xsl:comment> EM-Group-elements-of-editorial-to-div </xsl:comment>
    <xsl:apply-templates />
  </xsl:template>
  <xsl:template match="div[@type='editorial' and @subtype='comment']">
    <xsl:copy>
      <xsl:copy-of select="@*" />
      <xsl:for-each-group select="*" group-starting-with="thead">
        <xsl:apply-templates select="." mode="group" />
      </xsl:for-each-group>
    </xsl:copy>
  </xsl:template>
  <xsl:template match="thead" mode="group">
    <div>
      <head>
        <xsl:value-of select="." />
      </head>
      <xsl:for-each-group select="current-group() except ." group-starting-with="head">
        <xsl:apply-templates select="." mode="group" />
      </xsl:for-each-group>
    </div>
  </xsl:template>
  <xsl:template match="head" mode="group">
    <div>
      <head>
        <xsl:value-of select="." />
      </head>
      <xsl:for-each-group select="current-group() except ." group-starting-with="head1">
        <xsl:apply-templates select="." mode="group" />
      </xsl:for-each-group>
    </div>
  </xsl:template>
  <xsl:template match="*" mode="group">
    <xsl:copy-of select="current-group()" />
  </xsl:template>
  <xsl:template match="div[@type='explicit']">
    <xsl:copy-of select="." />
  </xsl:template>
  <xsl:template match="div[@type='preface']">
    <xsl:copy-of select="." />
  </xsl:template>
  <xsl:template match="div[@type = 'incipit']">
    <!--		<div>-->
    <xsl:copy-of select="." />
    <!--</div>-->
  </xsl:template>
</xsl:stylesheet>