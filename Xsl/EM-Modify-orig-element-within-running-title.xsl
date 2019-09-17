<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:vwf="http://vokabular.ujc.cas.cz/xslt/functions" exclude-result-prefixes="xd" version="2.0">
  <xsl:import href="Copy-xml-nodes.xsl" />
  <xsl:import href="Substring-after-last.xsl" />
  <xsl:import href="Text-functions.xsl" />
  <xd:doc scope="stylesheet">
    <xd:desc>
      <xd:p>
        <xd:b>Created on:</xd:b> Jan 23, 2015</xd:p>
      <xd:p>
        <xd:b>Author:</xd:b> Boris</xd:p>
      <xd:p></xd:p>
    </xd:desc>
  </xd:doc>
  <xsl:output method="xml" indent="yes" />
  <xsl:variable name="interpunkce" select="'?.,;!:„“‚‘’#'" />
  <xsl:variable name="mezera" select="' '" />
  <xsl:variable name="interpunkcePlusMezera" select="concat($interpunkce, $mezera)" />
  <xsl:template match="/">
    <xsl:comment> EM-Modify-orig-element-within-running-title </xsl:comment>
    <xsl:apply-templates />
  </xsl:template>
  <!--
		<anchor type="start" xml:id="ra.ID0EBTAE.8" /><text>snesti mohla</text><anchor type="end" xml:id="ra.ID0EDTAE.10" /><note><orig>ſneſtimohla</orig></note><text>
	-->
  <xsl:template match="note[orig][preceding-sibling::node()[1]/self::anchor[@type='end']]" priority="2">
    <xsl:copy>
      <xsl:copy-of select="@*" />
      <choice>
        <reg>
          <xsl:value-of select="preceding-sibling::anchor[@type='start'][1]/following-sibling::*[1]" />
        </reg>
        <xsl:apply-templates />
      </choice>
    </xsl:copy>
  </xsl:template>
  <xsl:template match="unclear/note[orig]"></xsl:template>
  <xsl:template match="note[orig]">
    <xsl:variable name="text">
      <xsl:choose>
        <xsl:when test="parent::*[self::supplied]">
          <xsl:value-of select="normalize-space(concat(parent::*/parent::*/text(), parent::*/text() ))" />
          <!--					<xsl:value-of select="string-join(parent::*/parent::*//text(), '')"/>-->
        </xsl:when>
        <xsl:when test="parent::*[self::text]/preceding-sibling::*[1][self::pb[not(@rend='space')]]">
          <xsl:value-of select="concat(        parent::*[self::text]/preceding-sibling::*[2]/text()[last()],        normalize-space(preceding::text()[1])       )       " />
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="normalize-space(preceding::text()[1])" />
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:copy>
      <xsl:copy-of select="@*" />
      <xsl:element name="choice">
        <xsl:element name="reg">
          <xsl:variable name="citat">
            <xsl:variable name="znak">
              <xsl:call-template name="najitPosledniVyskytujiciSeZnak">
                <xsl:with-param name="text" select="$text" />
                <xsl:with-param name="interpunkce" select="$interpunkcePlusMezera" />
              </xsl:call-template>
            </xsl:variable>
            <xsl:choose>
              <xsl:when test="$znak = ''">
                <xsl:value-of select="$text" />
              </xsl:when>
              <xsl:otherwise>
                <xsl:value-of select="vwf:substring-after-last($text, $znak)" />
              </xsl:otherwise>
            </xsl:choose>
          </xsl:variable>
          <xsl:value-of select="$citat" />
          <!--				<xsl:choose>
					<xsl:when test="contains($text, '(')">
						<xsl:variable name="zbytek">
							<xsl:call-template name="substring-after-last">
								<xsl:with-param name="string" select="$text" />
								<xsl:with-param name="delimiter" select="'('" />
							</xsl:call-template>
						</xsl:variable>
						<xsl:choose>
							<xsl:when test="contains($zbytek, ' ')">
								<xsl:call-template name="substring-after-last">
									<xsl:with-param name="string" select="$text" />
									<xsl:with-param name="delimiter" select="' '" />
								</xsl:call-template>
							</xsl:when>
							<xsl:otherwise>
								<xsl:call-template name="substring-after-last">
									<xsl:with-param name="string" select="$text" />
									<xsl:with-param name="delimiter" select="'('" />
								</xsl:call-template>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:when test="contains($text, ' ')">
						<xsl:call-template name="substring-after-last">
							<xsl:with-param name="string" select="$text" />
							<xsl:with-param name="delimiter" select="' '" />
						</xsl:call-template>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="$text"/>
					</xsl:otherwise>
				</xsl:choose>-->
        </xsl:element>
        <xsl:apply-templates />
      </xsl:element>
    </xsl:copy>
  </xsl:template>
</xsl:stylesheet>