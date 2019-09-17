<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:vwf="http://vokabular.ujc.cas.cz/xslt/functions" xmlns:d="http://vokabular.ujc.cas.cz/ns/documentation" exclude-result-prefixes="xd vwf d" version="2.0">
  <xsl:import href="Copy-xml-nodes.xsl" />
  <xsl:import href="Text-functions.xsl" />
  <xd:doc scope="stylesheet">
    <xd:desc>
      <xd:p>
        <xd:b>Created on:</xd:b> Mar 25, 2018</xd:p>
      <xd:p>
        <xd:b>Author:</xd:b> Boris</xd:p>
      <xd:p></xd:p>
    </xd:desc>
  </xd:doc>
  <xsl:variable name="mezera" select="' '" />
  <xsl:variable name="interpunkcePlusMezera" select="concat('.,;?!)', $mezera)" />
  <xsl:strip-space elements="*" />
  <xsl:output method="xml" indent="no" />
  <xsl:template match="/">
    <xsl:comment> EM-Modify-content-of-unclear-step-02G </xsl:comment>
    <xsl:apply-templates />
  </xsl:template>
  <d:doc>
    <d:example>
      <text>
        <unclear position="initial">
          <supplied>či</supplied>
        </unclear>niti <note>Poškozený papír. Rekonstruováno podle .... </note>smějí.</text>
    </d:example>
    <d:example>
      <unclear position="initial">
        <supplied>kladi</supplied>
      </unclear>vy <unclear position="initial">zv</unclear><unclear position="final"><supplied>uk</supplied></unclear></d:example>
  </d:doc>
  <xd:doc>
    <xd:desc />
  </xd:doc>
  <xsl:template match="    node() [self::text()] [preceding-sibling::node()[1][self::unclear[@position = 'initial']] [ not( following-sibling::node()[1] [self::unclear[@position='middle'] | self::unclear[@position='final'] ] ) ] ]   ">
    <xsl:variable name="substring-before">
      <xsl:choose>
        <xsl:when test="vwf:substring-before-first-from-many(., $interpunkcePlusMezera) = ''">
          <xsl:value-of select="." />
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="vwf:substring-before-first-from-many(., $interpunkcePlusMezera)" />
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="substring-after">
      <xsl:value-of select="substring-after(., $substring-before)" />
    </xsl:variable>
    <xsl:element name="unclear">
      <xsl:attribute name="position">
        <xsl:text>final</xsl:text>
      </xsl:attribute>
      <xsl:value-of select="$substring-before" />
    </xsl:element>
    <xsl:choose>
      <xsl:when test="$substring-after = ' '">
        <hi xml:space="preserve">
          <xsl:value-of select="$substring-after" />
        </hi>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$substring-after" />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template match="*   [self::unclear[@position = 'initial']]  [following-sibling::node()[1][self::pb]]  [following-sibling::node()[2][self::fw | self::sic | self::unclear[@position='final']]]   ">
    <xsl:copy>
      <xsl:copy-of select="@*" />
      <xsl:apply-templates />
      <xsl:copy-of select="following-sibling::node()[self::pb][1]" />
      <xsl:copy-of select="following-sibling::node()[self::sic][1]" />
      <xsl:copy-of select="following-sibling::node()[self::fw][1]" />
    </xsl:copy>
  </xsl:template>
  <xd:doc>
    <xd:desc>
      <xd:p></xd:p>
    </xd:desc>
  </xd:doc>
  <xsl:template match="   *   [self::pb]   [preceding-sibling::node()[1][self::unclear[@position = 'initial']]]  [following-sibling::node()[1][self::fw | self::sic | self::unclear[@position='final']]]   ">
    <!-- vypouští se -->
  </xsl:template>
  <xsl:template match="*   [self::fw | self::sic]  [preceding-sibling::node()[self::pb]]  [preceding-sibling::node()[self::unclear[@position = 'initial']]]  [following-sibling::node()[self::unclear[@position = 'final']]]   ">
    <!-- vypouští se -->
  </xsl:template>
</xsl:stylesheet>