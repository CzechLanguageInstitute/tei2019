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
    <xsl:comment> EM-Modify-content-of-unclear-step-02F </xsl:comment>
    <xsl:apply-templates />
  </xsl:template>
  <d:doc>
    <d:example>
      <text>hluché, belha</text>
      <pb n="4r" />
      <unclear>
        <supplied>vé, </supplied>
      </unclear>
      <supplied>skloněné i dnú</supplied>
    </d:example>
    <d:example>
      <supplied>A potom jeho při</supplied>
      <pb n="30r" />
      <unclear>
        <supplied>káza<note>doplněno podle rukopisu DR III 32, v němž je tato část dopsána evidentně mladší rukou</note></supplied>
      </unclear>
    </d:example>
  </d:doc>
  <xd:doc>
    <xd:desc />
  </xd:doc>
  <xsl:template match="    *  [self::unclear[not(@position)]]  [preceding-sibling::node()[1][self::pb]] [preceding-sibling::node()[2][self::text | self::supplied]]   ">
    <xsl:copy>
      <xsl:copy-of select="@*" />
      <xsl:attribute name="position">
        <xsl:text>final</xsl:text>
      </xsl:attribute>
      <xsl:apply-templates />
    </xsl:copy>
  </xsl:template>
  <xsl:template match="*   [self::text | self::supplied][not(ends-with(., ' '))]  [following-sibling::node()[1][self::pb]] [following-sibling::node()[2][self::unclear[not(@position)]]]      ">
    <xsl:variable name="substring-before">
      <xsl:choose>
        <xsl:when test="vwf:substring-before-last-from-many-including(text()[last()], $interpunkcePlusMezera) = ''">
          <xsl:value-of select="text()[last()]" />
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="vwf:substring-before-last-from-many-including(text()[last()], $interpunkcePlusMezera)" />
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="substring-after">
      <xsl:value-of select="substring-after(text()[last()], $substring-before)" />
    </xsl:variable>
    <xsl:copy>
      <xsl:copy-of select="@*" />
      <xsl:copy-of select="node()[position() &lt; last()]" />
      <xsl:value-of select="$substring-before" />
    </xsl:copy>
    <xsl:element name="unclear">
      <xsl:attribute name="position">
        <xsl:text>initial</xsl:text>
      </xsl:attribute>
      <xsl:value-of select="$substring-after" />
      <xsl:copy-of select="following-sibling::node()[1][self::pb]" />
    </xsl:element>
  </xsl:template>
  <xsl:template match="   * [self::pb] [ preceding-sibling::node()[1] [self::text | self::supplied][not(ends-with(., ' '))] ] [following-sibling::node()[1][self::unclear[not(@position)]]]   "></xsl:template>
  <d:doc>
    <d:example>
      <text>
        <hi xml:space="preserve"> </hi>
        <unclear position="initial">čty</unclear>
        <unclear position="middle">
          <supplied>ři</supplied>
        </unclear>
        <unclear position="middle">dce</unclear>
        <unclear>
          <supplied>ti </supplied>
        </unclear>
      </text>
    </d:example>
  </d:doc>
  <xsl:template match="   *[self::unclear[not(@position)]] (: [preceding-sibling::node()[1][self::pb]] [preceding-sibling::node()[2][self::text | self::supplied]] :) [preceding-sibling::node()[1][self::unclear[@position='middle']]] [preceding-sibling::node()[2][self::unclear[@position='middle']]] [preceding-sibling::node()[3][self::unclear[@position='initial']]] [not(following-sibling::node()[1][self::unclear])]   ">
    <xsl:copy>
      <xsl:copy-of select="@*" />
      <xsl:attribute name="position">
        <xsl:text>final</xsl:text>
      </xsl:attribute>
      <xsl:apply-templates />
    </xsl:copy>
  </xsl:template>
  <d:doc>
    <d:example>
      <text>vezmu do svých vás <unclear position="initial">pří</unclear><unclear position="final"><supplied>bytků<note> Rekonstruováno podle tisku uloženého v Národní knihovně ČR pod signaturou 54 K 023269.</note></supplied></unclear><unclear position="final">.“</unclear></text>
    </d:example>
  </d:doc>
  <xsl:template match="   *   [self::unclear[@position = 'final']] [translate(substring(., 1, 1), '.,!?', '') = ''] [  preceding-sibling::node()[1]   [self::unclear[@position = 'final']]   [parent::*[self::text]] ]   ">
    <xsl:apply-templates />
  </xsl:template>
</xsl:stylesheet>