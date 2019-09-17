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
    <xsl:comment> EM-Modify-content-of-unclear-step-01A </xsl:comment>
    <xsl:apply-templates />
  </xsl:template>
  <xd:doc>
    <xd:desc>
      <xd:p></xd:p>
    </xd:desc>
  </xd:doc>
  <xsl:template match="    text()    [normalize-space(.) != '']    [following-sibling::node()[1]/self::unclear[not(@position)]]    [substring(., string-length(.), 1) != $mezera]    ">
    <xsl:choose>
      <xsl:when test="contains(., $mezera)">
        <xsl:value-of select="vwf:substring-before-last(., $mezera)" />
        <xsl:value-of select="$mezera" />
        <unclear position="initial">
          <xsl:value-of select="vwf:substring-after-last(., $mezera)" />
        </unclear>
      </xsl:when>
      <xsl:otherwise>
        <unclear position="initial">
          <xsl:value-of select="." />
        </unclear>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xd:doc>
    <xd:desc>
      <xd:p></xd:p>
    </xd:desc>
  </xd:doc>
  <xsl:template match="    text()    [preceding-sibling::node()[1]/self::unclear[not(@position)]]    [not(ends-with(preceding-sibling::node()[1], $mezera))]    [normalize-space(.) != '']    [substring(., 1, 1) != $mezera]" priority="5">
    <xsl:choose>
      <xsl:when test="not(contains(., $mezera)) and preceding-sibling::*[1]/self::unclear and following-sibling::*[1]/self::unclear">
        <unclear position="middle">
          <xsl:value-of select="." />
        </unclear>
      </xsl:when>
      <xsl:when test="contains(., $mezera)">
        <xsl:variable name="unclear-text" select="vwf:substring-before-first-from-many(., $interpunkcePlusMezera)" />
        <xsl:if test="$unclear-text != ''">
          <unclear position="final">
            <!--<xsl:value-of select="substring-before(., $mezera)" />-->
            <xsl:value-of select="$unclear-text" />
            <!--<xsl:value-of select="$mezera" />-->
          </unclear>
        </xsl:if>
        <xsl:choose>
          <xsl:when test="substring-after(., $unclear-text) = ' '">
            <hi xml:space="preserve"> </hi>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="substring-after(., $unclear-text)" />
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:otherwise>
        <unclear position="final">
          <xsl:value-of select="." />
        </unclear>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xd:doc>
    <xd:desc>
      <xd:p></xd:p>
    </xd:desc>
  </xd:doc>
  <xsl:template match="    text()    [preceding-sibling::node()[1]/self::unclear]    [preceding-sibling::node()[1]/self::text()[not(contains(., ' '))]]    [not(ends-with(preceding-sibling::node()[1], $mezera))]    [normalize-space(.) != '']    [substring(., 1, 1) != $mezera]" priority="10">
    <xsl:choose>
      <xsl:when test="contains(., $mezera)">
        <unclear position="final">
          <xsl:value-of select="substring-before(., $mezera)" />
          <xsl:value-of select="$mezera" />
        </unclear>
        <xsl:value-of select="vwf:substring-after-first(., $mezera)" />
      </xsl:when>
      <xsl:otherwise>
        <unclear position="final">
          <xsl:value-of select="." />
        </unclear>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template match="unclear   [not(@position)]   [preceding-sibling::node()[1][self::text()[not(ends-with(., $mezera))]]]   [following-sibling::node()[1][self::text()[not(ends-with(., $mezera))]]]   ">
    <xsl:copy>
      <xsl:copy-of select="@*" />
      <xsl:choose>
        <xsl:when test="vwf:starts-with-one-from-many(following-sibling::node()[1], $interpunkce)">
          <xsl:attribute name="position">
            <xsl:text>final</xsl:text>
          </xsl:attribute>
        </xsl:when>
        <xsl:otherwise>
          <xsl:attribute name="position">
            <xsl:text>middle</xsl:text>
          </xsl:attribute>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates />
    </xsl:copy>
  </xsl:template>
</xsl:stylesheet>