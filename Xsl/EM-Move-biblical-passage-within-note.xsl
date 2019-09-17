<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:tei="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="xd tei" version="1.0">
  <xsl:import href="Copy-xml-nodes.xsl" />
  <xd:doc scope="stylesheet">
    <xd:desc>
      <xd:p>
        <xd:b>Created on:</xd:b> Feb 6, 2015</xd:p>
      <xd:p>
        <xd:b>Author:</xd:b> Boris</xd:p>
      <xd:p></xd:p>
    </xd:desc>
  </xd:doc>
  <xsl:output omit-xml-declaration="no" indent="yes" />
  <xsl:strip-space elements="*" />
  <xsl:template match="/">
    <xsl:comment> EM-Move-biblical-passage-within-note </xsl:comment>
    <xsl:apply-templates />
  </xsl:template>
  <xsl:template match="tei:anchor[@type='bible'][@subtype='book']">
    <xsl:choose>
      <xsl:when test="not(/tei:TEI/tei:teiHeader/tei:profileDesc/tei:textClass/tei:keywords/tei:term[. = 'biblický text'])">
        <xsl:element name="note" namespace="http://www.tei-c.org/ns/1.0">
          <xsl:copy-of select="." />
          <xsl:copy-of select="following-sibling::*[1]/self::*[@subtype='chapter']" />
          <xsl:copy-of select="following-sibling::*[1]/self::*[@subtype='verse']" />
          <xsl:copy-of select="following-sibling::*[2]/self::*[@subtype='verse']" />
        </xsl:element>
      </xsl:when>
      <xsl:otherwise>
        <xsl:copy-of select="." />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template match="tei:anchor[@type='bible'][@subtype='chapter' or @subtype='verse']">
    <xsl:if test="/tei:TEI/tei:teiHeader/tei:profileDesc/tei:textClass/tei:keywords/tei:term[. = 'biblický text']">
      <xsl:copy-of select="." />
    </xsl:if>
  </xsl:template>
</xsl:stylesheet>