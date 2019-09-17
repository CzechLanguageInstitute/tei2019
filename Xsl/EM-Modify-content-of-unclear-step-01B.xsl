<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xml="http://www.w3.org/XML/1998/namespace" xmlns:vwf="http://vokabular.ujc.cas.cz/xslt/functions" xmlns:xs="http://www.w3.org/2001/XMLSchema" extension-element-prefixes="vwf" exclude-result-prefixes="xd vwf xs" version="2.0">
  <xsl:import href="Copy-xml-nodes.xsl" />
  <xsl:import href="Text-functions.xsl" />
  <xd:doc scope="stylesheet">
    <xd:desc>
      <xd:p>
        <xd:b>Created on:</xd:b> Apr 13, 2018</xd:p>
      <xd:p>
        <xd:b>Author:</xd:b> Boris</xd:p>
      <xd:p>Đ</xd:p>
    </xd:desc>
  </xd:doc>
  <xd:doc scope="stylesheet">
    <xd:desc>
      <xd:p>
        <xd:b>Created on:</xd:b> Mar 25, 2018</xd:p>
      <xd:p>
        <xd:b>Author:</xd:b> Boris</xd:p>
      <xd:p />
    </xd:desc>
  </xd:doc>
  <xd:doc>
    <xd:desc>
      <xd:p></xd:p>
    </xd:desc>
  </xd:doc>
  <xsl:output omit-xml-declaration="no" indent="no" />
  <xsl:strip-space elements="unclear supplied" />
  <xd:doc>
    <xd:desc>
      <xd:p></xd:p>
    </xd:desc>
  </xd:doc>
  <xsl:variable name="interpunkce" select="'?.,;!:„“‚‘’#'" />
  <xd:doc>
    <xd:desc>
      <xd:p></xd:p>
    </xd:desc>
  </xd:doc>
  <xsl:variable name="mezera" select="' '" />
  <xd:doc>
    <xd:desc>
      <xd:p></xd:p>
    </xd:desc>
  </xd:doc>
  <xsl:variable name="interpunkcePlusMezera" select="concat($interpunkce, $mezera)" />
  <xd:doc>
    <xd:desc>
      <xd:p></xd:p>
    </xd:desc>
  </xd:doc>
  <xsl:template match="/">
    <xsl:comment> EM-Modify-content-of-unclear-step-01B </xsl:comment>
    <xsl:apply-templates />
  </xsl:template>
  <xd:doc>
    <xd:desc>
      <xd:p></xd:p>
    </xd:desc>
  </xd:doc>
  <xsl:template match="    text()    [normalize-space(.) != '']    [following-sibling::node()[1]/self::unclear[@position = 'middle']]    [substring(., string-length(.), 1) != $mezera]    ">
    <xsl:choose>
      <xsl:when test="contains(., $mezera)">
        <xsl:variable name="normal-text" select="vwf:substring-before-last-from-many-including(., $interpunkcePlusMezera)" />
        <xsl:choose>
          <xsl:when test="$normal-text != ''">
            <xsl:value-of select="$normal-text" />
            <unclear position="initial">
              <xsl:value-of select="substring-after(., $normal-text)" />
            </unclear>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="." />
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:otherwise>
        <unclear position="initial">
          <xsl:value-of select="." />
        </unclear>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template match="    text()    [normalize-space(.) != '']    [following-sibling::node()[1]/self::unclear[@position = 'final']]    [substring(., string-length(.), 1) != $mezera]   ">
    <xsl:choose>
      <xsl:when test="contains(., $mezera)">
        <xsl:variable name="normal-text" select="vwf:substring-before-last-from-many-including(., $interpunkcePlusMezera)" />
        <xsl:choose>
          <xsl:when test="$normal-text != ''">
            <xsl:choose>
              <xsl:when test="$normal-text = ' '">
                <text xml:space="preserve"> </text>
              </xsl:when>
              <xsl:otherwise>
                <xsl:value-of select="$normal-text" />
              </xsl:otherwise>
            </xsl:choose>
            <unclear position="initial">
              <xsl:value-of select="substring-after(., $normal-text)" />
            </unclear>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="." />
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:otherwise>
        <unclear position="initial">
          <xsl:value-of select="." />
        </unclear>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
</xsl:stylesheet>